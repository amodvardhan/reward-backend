// src/controllers/contingencyCropPlanController.js
const ContingencyCropPlan = require('../models/contingencyCropPlan');
const ApiResponse = require('../utils/ApiResponse');

/**
 * Get contingency crop plan for a district and date (handles YES/NO sown condition)
 */
exports.getContingencyCropPlan = async (req, res) => {
  console.log(`[${new Date().toISOString()}] ContingencyCropPlan API request started: ${req.method} ${req.url}`);
  try {
    const { 
      sown, 
      district, 
      date, 
      showing_date, 
      crop, 
      mobileNo, 
      trg_code, 
      hobli_code, 
      hobli, 
      region, 
      prevRainfall, 
      nextRainfall 
    } = req.query;

    const targetDateStr = date || showing_date;
    const isSownYes = sown && sown.toUpperCase() === 'YES';

    if (!isSownYes) {
      // ----------------------------------------------------
      // SOWN "NO" FLOW (or default)
      // ----------------------------------------------------
      let targetDistrict = district;
      
      // Resolve district if missing and mobileNo is provided
      if (!targetDistrict && mobileNo) {
        const farmer = await ContingencyCropPlan.getFarmerByMobileNo(mobileNo);
        if (farmer) {
          targetDistrict = farmer.district;
        }
      }

      if (!targetDistrict) {
        console.log(`[${new Date().toISOString()}] ContingencyCropPlan validation failed: missing district`);
        return ApiResponse.error(res, 400, 'Missing required parameter: district or mobileNo');
      }

      // Parse date robustly, default to current system date if not passed
      let parsedDate = null;
      if (targetDateStr) {
        parsedDate = parseDate(targetDateStr);
        if (!parsedDate) {
          console.log(`[${new Date().toISOString()}] ContingencyCropPlan validation failed: invalid date format: ${targetDateStr}`);
          return ApiResponse.error(res, 400, 'Invalid date format. Supported formats include YYYY-MM-DD, DD-MM-YYYY, and DD-MM-YY');
        }
      } else {
        parsedDate = new Date();
      }

      console.log(`[${new Date().toISOString()}] Fetching contingency crop plan for district: ${targetDistrict}, date: ${parsedDate.toISOString()}`);
      const plan = await ContingencyCropPlan.getPlanByDistrictAndDate({ district: targetDistrict, date: parsedDate });

      if (!plan) {
        console.log(`[${new Date().toISOString()}] Contingency crop plan not found for the parameters`);
        return ApiResponse.error(res, 404, 'Contingency crop plan not available for the given district and date');
      }

      console.log(`[${new Date().toISOString()}] Contingency crop plan retrieved successfully`);
      return ApiResponse.ok(res, 'Contingency crop plan retrieved successfully', plan);
    }

    // ----------------------------------------------------
    // SOWN "YES" FLOW
    // ----------------------------------------------------
    console.log(`[${new Date().toISOString()}] Processing Yes condition for crop advisory...`);
    
    // 1. Resolve farmer details if mobileNo is provided
    let farmer = null;
    if (mobileNo) {
      farmer = await ContingencyCropPlan.getFarmerByMobileNo(mobileNo);
    }

    // 2. Resolve target parameters
    const targetCrop = crop || (farmer && farmer.crop_name);
    const targetTrgCode = trg_code || (farmer && farmer.trgcode);
    const targetHobliCode = hobli_code || (farmer && farmer.hobli_code);
    const targetHobli = hobli || (farmer && farmer.hobliname);
    const targetDistrict = district || (farmer && farmer.district);
    const targetDistrictCode = district || (farmer && farmer.districtcode); // Fallback to district if code missing

    if (!targetCrop) {
      return ApiResponse.error(res, 400, 'Missing required parameter: crop');
    }

    if (!targetDateStr) {
      return ApiResponse.error(res, 400, 'Missing required parameter: showing_date or date');
    }

    const parsedShowingDate = parseDate(targetDateStr);
    if (!parsedShowingDate) {
      return ApiResponse.error(res, 400, 'Invalid date format. Supported formats include YYYY-MM-DD, DD-MM-YYYY, and DD-MM-YY');
    }

    // 3. Resolve Region (clean SIK/NIK)
    let cleanRegion = null;
    if (region) {
      cleanRegion = getCleanRegion(region);
    }
    if (!cleanRegion) {
      // Find region from district
      const dbRegion = await ContingencyCropPlan.getRegionByDistrict({
        district: targetDistrict,
        districtCode: targetDistrictCode
      });
      if (dbRegion) {
        cleanRegion = getCleanRegion(dbRegion);
      }
    }
    if (!cleanRegion) {
      cleanRegion = 'NIK'; // Default fallback if unable to resolve
    }

    console.log(`[${new Date().toISOString()}] Resolved parameters: Crop: ${targetCrop}, Region: ${cleanRegion}, Sowing Date: ${parsedShowingDate.toISOString()}`);

    // 4. Verify crop type is strictly AGRICULTURE
    const cropDetails = await ContingencyCropPlan.getCropVarietyDuration(targetCrop, cleanRegion);
    if (!cropDetails) {
      return ApiResponse.error(res, 400, `Crop details not found for crop: ${targetCrop} in region: ${cleanRegion}`);
    }

    const cropType = (cropDetails.crop_type || '').trim().toUpperCase();
    if (cropType !== 'AGRICULTURE') {
      return ApiResponse.error(res, 400, `Weather based advisory is strictly for Agriculture crops. Crop ${targetCrop} is ${cropType}`);
    }

    // 5. Fetch blocking period records and validate showing date
    const blocking = await ContingencyCropPlan.getBlockingPeriod(targetCrop, cleanRegion);
    if (!blocking) {
      return ApiResponse.error(res, 400, `Blocking period configuration not found for crop ${targetCrop} in region ${cleanRegion}`);
    }

    const year = parsedShowingDate.getFullYear();
    const ranges = parseSowingPeriod(blocking.sowing_period, year);

    if (ranges.length === 0) {
      return ApiResponse.error(res, 500, `Failed to parse sowing periods for crop ${targetCrop}: ${blocking.sowing_period}`);
    }

    // Evaluate sowing date against parsed ranges
    let isWithinSowingRange = false;
    let isWithinOpenRange = false;

    for (const r of ranges) {
      if (parsedShowingDate >= r.sowingStart && parsedShowingDate <= r.sowingEnd) {
        isWithinSowingRange = true;
        break;
      }
    }

    if (!isWithinSowingRange) {
      for (const r of ranges) {
        if (parsedShowingDate >= r.openStart && parsedShowingDate <= r.sowingEnd) {
          isWithinOpenRange = true;
          break;
        }
      }
    }

    // Range-based branching
    if (!isWithinSowingRange && !isWithinOpenRange) {
      // Outside Open Period: Return blocked response
      console.log(`[${new Date().toISOString()}] Sowing date ${formatDateLocal(parsedShowingDate)} is blocked.`);
      return ApiResponse.ok(res, 'Sowing date is outside the allowed open period. Calendar blocked.', {
        status: 'BLOCKED',
        message: 'Sowing date is outside the allowed open period.'
      });
    }

    if (!isWithinSowingRange && isWithinOpenRange) {
      // Inside Open Period but before Sowing Period (Pre-Sowing): Return Kannada warning message
      console.log(`[${new Date().toISOString()}] Sowing date is pre-sowing warning period.`);
      const warningKn = fixKannadaGarbage(blocking.openperiod_msg);
      return ApiResponse.ok(res, 'Pre-sowing warning', {
        status: 'PRE_SOWING',
        message: warningKn || 'Pre-sowing warning period',
        openperiod_msg: warningKn || ''
      });
    }

    // 6. Within Sowing Range: Run weather calculation
    console.log(`[${new Date().toISOString()}] Sowing date is within sowing range. Running weather based calculations...`);
    
    // Calculate Days After Sowing (DAS)
    const today = new Date();
    const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    const sowingDateOnly = new Date(parsedShowingDate.getFullYear(), parsedShowingDate.getMonth(), parsedShowingDate.getDate());
    const timeDiff = todayDateOnly.getTime() - sowingDateOnly.getTime();
    const das = Math.floor(timeDiff / (1000 * 60 * 60 * 24));

    let prevRainCategory = prevRainfall;
    let nextRainCategory = nextRainfall;

    if (!prevRainCategory || !nextRainCategory) {
      const metrics = await ContingencyCropPlan.getRainfallMetrics({
        hobliCode: targetHobliCode,
        trgCode: targetTrgCode
      });

      const actualRain = metrics.actualRain;
      const normalRain = metrics.normalRain;
      const forecastRain = metrics.forecastRain;

      const deviation = calculateDeviation(actualRain, normalRain);
      const rainCategory = getDeviationCategory(deviation);

      if (!prevRainCategory) prevRainCategory = rainCategory;
      if (!nextRainCategory) nextRainCategory = forecastRain;

      // Override: If Previous Week Rainfall is NORMAL, Next Week Forecast is YES
      if (prevRainCategory === 'NORMAL') {
        nextRainCategory = 'YES';
      }
    }

    console.log(`[${new Date().toISOString()}] Rain Categories - Previous Week: ${prevRainCategory}, Forecast: ${nextRainCategory}, DAS: ${das}`);

    // 7. Query FIELD_CROPS_ADVISORY
    const sowingMonthNorm = normalizeSowingMonth(blocking.sowing_period);
    const cropId = cropDetails.crop_id || cropDetails.CROP_ID;

    const advisories = await ContingencyCropPlan.fetchFieldCropAdvisory({
      cropName: targetCrop,
      cropId: cropId,
      sowingMonth: sowingMonthNorm,
      prevRainfall: prevRainCategory,
      nextRainfall: nextRainCategory,
      regionCode: cleanRegion
    });

    // 8. Filter by DAS range in JS
    let matchedAdvisory = null;
    for (const adv of advisories) {
      if (matchDas(das, adv.das_of_crop)) {
        matchedAdvisory = adv;
        break;
      }
    }

    if (!matchedAdvisory) {
      console.log(`[${new Date().toISOString()}] No crop advisory row matched for crop: ${targetCrop}, region: ${cleanRegion}, DAS: ${das}`);
      return ApiResponse.error(res, 404, `No matching crop advisory found for crop ${targetCrop} in region ${cleanRegion} at ${das} DAS.`);
    }

    // Build responsive payload with clean Kannada texts
    const knMeasures = fixKannadaGarbage(matchedAdvisory.agriculture_measures_kn || matchedAdvisory.AGRICULTURE_MEASURES_KN);
    const knProtection = fixKannadaGarbage(matchedAdvisory.plant_protection_mearures_kn || matchedAdvisory.PLANT_PROTECTION_MEARURES_KN);
    const enMeasures = matchedAdvisory.agriculture_measures_en || matchedAdvisory.AGRICULTURE_MEASURES_EN;
    const enProtection = matchedAdvisory.plant_protection_mearures_en || matchedAdvisory.PLANT_PROTECTION_MEARURES_EN;

    const responsePayload = {
      AGRICULTURE_MEASURES_KN: knMeasures,
      PLANT_PROTECTION_MEARURES_KN: knProtection,
      AGRICULTURE_MEASURES_ENG: enMeasures,
      PLANT_PROTECTION_MEARURES_ENG: enProtection,
      AGRICULTURE_MEASURES_KN2: '',
      PLANT_PROTECTION_MEARURES_KN2: '',
      CROP_NAME: targetCrop,
      DAS_OF_CROP: matchedAdvisory.das_of_crop || matchedAdvisory.DAS_OF_CROP,
      CROP_DURATION: cropDetails.crop_duration || cropDetails.CROP_DURATION,
      das: das,
      prevRainfall: prevRainCategory,
      nextRainfall: nextRainCategory
    };

    console.log(`[${new Date().toISOString()}] Weather-based crop advisory matched and resolved successfully`);
    return ApiResponse.ok(res, 'Crop advisory retrieved successfully', responsePayload);
  } catch (error) {
    console.error(`[${new Date().toISOString()}] Error in getContingencyCropPlan:`, error.message);
    return ApiResponse.error(res, 500, 'Failed to retrieve crop advisory', { error: error.message });
  }
};

/**
 * Get crop period information (ranges & warning messages)
 */
exports.getCropPeriodInfo = async (req, res) => {
  try {
    const { crop, mobileNo, region } = req.query;
    if (!crop) {
      return ApiResponse.error(res, 400, 'Missing required parameter: crop');
    }
    
    let cleanRegion = null;
    if (region) {
      cleanRegion = getCleanRegion(region);
    }
    
    let targetDistrict = null;
    let targetDistrictCode = null;
    
    if (!cleanRegion && mobileNo) {
      const farmer = await ContingencyCropPlan.getFarmerByMobileNo(mobileNo);
      if (farmer) {
        targetDistrict = farmer.district;
        targetDistrictCode = farmer.districtcode;
      }
    }
    
    if (!cleanRegion) {
      const dbRegion = await ContingencyCropPlan.getRegionByDistrict({ district: targetDistrict, districtCode: targetDistrictCode });
      if (dbRegion) {
        cleanRegion = getCleanRegion(dbRegion);
      }
    }
    
    if (!cleanRegion) {
      cleanRegion = 'NIK'; // Default fallback
    }
    
    const blocking = await ContingencyCropPlan.getBlockingPeriod(crop, cleanRegion);
    if (!blocking) {
      return ApiResponse.error(res, 404, `Blocking period not found for crop ${crop} in region ${cleanRegion}`);
    }
    
    const year = new Date().getFullYear();
    const ranges = parseSowingPeriod(blocking.sowing_period, year);
    
    const formattedRanges = ranges.map(r => ({
      sowingStart: formatDateLocal(r.sowingStart),
      sowingEnd: formatDateLocal(r.sowingEnd),
      openStart: formatDateLocal(r.openStart),
      openEnd: formatDateLocal(r.openEnd)
    }));
    
    return ApiResponse.ok(res, 'Crop period info retrieved successfully', {
      crop,
      region: cleanRegion,
      sowing_period: blocking.sowing_period,
      openperiod_msg: fixKannadaGarbage(blocking.openperiod_msg),
      ranges: formattedRanges
    });
  } catch (error) {
    console.error('Error in getCropPeriodInfo:', error);
    return ApiResponse.error(res, 500, 'Failed to retrieve crop period info', { error: error.message });
  }
};

/**
 * Helper to robustly parse date strings from query parameters as local dates
 */
function parseDate(dateStr) {
  if (!dateStr) return null;
  
  // Remove time portion if present
  const onlyDateStr = dateStr.split('T')[0].trim();
  
  // 1. Try parsing YYYY-MM-DD
  const yyyymmdd = /^(\d{4})[-/](\d{1,2})[-/](\d{1,2})$/.exec(onlyDateStr);
  if (yyyymmdd) {
    const year = parseInt(yyyymmdd[1], 10);
    const month = parseInt(yyyymmdd[2], 10) - 1;
    const day = parseInt(yyyymmdd[3], 10);
    const parsed = new Date(year, month, day, 0, 0, 0, 0);
    if (!isNaN(parsed.getTime())) return parsed;
  }
  
  // 2. Try parsing DD-MM-YYYY or DD-MM-YY
  const ddmmyyyy = /^(\d{1,2})[-/](\d{1,2})[-/](\d{2,4})$/.exec(onlyDateStr);
  if (ddmmyyyy) {
    const day = parseInt(ddmmyyyy[1], 10);
    const month = parseInt(ddmmyyyy[2], 10) - 1;
    let year = parseInt(ddmmyyyy[3], 10);
    if (year < 100) {
      year += 2000;
    }
    const parsed = new Date(year, month, day, 0, 0, 0, 0);
    if (!isNaN(parsed.getTime())) return parsed;
  }
  
  // Fallback parsing (handles other standard string formats)
  const parsed = new Date(dateStr);
  if (!isNaN(parsed.getTime())) {
    // Normalize to local 00:00:00
    return new Date(parsed.getFullYear(), parsed.getMonth(), parsed.getDate(), 0, 0, 0, 0);
  }
  
  return null;
}

/**
 * Format date to YYYY-MM-DD using local timezone values
 */
function formatDateLocal(date) {
  if (!date) return '';
  const yyyy = date.getFullYear();
  const mm = String(date.getMonth() + 1).padStart(2, '0');
  const dd = String(date.getDate()).padStart(2, '0');
  return `${yyyy}-${mm}-${dd}`;
}

/**
 * Helper to extract region code from region parameter
 */
function getCleanRegion(regionStr) {
  if (!regionStr) return null;
  const upper = regionStr.toUpperCase();
  if (upper.includes('SIK')) return 'SIK';
  if (upper.includes('NIK')) return 'NIK';
  return upper;
}

// Sowing period parser helper functions
const MONTH_MAP = {
  JANUARY: 0, JAN: 0,
  FEBRUARY: 1, FEB: 1,
  MARCH: 2, MAR: 2,
  APRIL: 3, APR: 3,
  MAY: 4,
  JUNE: 5, JUN: 5,
  JULY: 6, JUL: 6,
  AUGUST: 7, AUG: 7,
  SEPTEMBER: 8, SEP: 8,
  OCTOBER: 9, OCT: 9,
  NOVEMBER: 10, NOV: 10,
  DECEMBER: 11, DEC: 11
};

function parseTerm(term, isEndTerm, year) {
  const parts = term.trim().toUpperCase().split(/\s+/);
  let monthName = null;
  let dayNum = null;
  for (const part of parts) {
    if (MONTH_MAP[part] !== undefined) {
      monthName = part;
    } else {
      const num = parseInt(part, 10);
      if (!isNaN(num)) {
        dayNum = num;
      }
    }
  }
  if (!monthName) return null;
  const month = MONTH_MAP[monthName];
  let day = dayNum;
  if (day === null) {
    if (isEndTerm) {
      day = new Date(year, month + 1, 0).getDate();
    } else {
      day = 1;
    }
  }
  return { month, day };
}

function parseSowingPeriod(sowingPeriodStr, year) {
  if (!sowingPeriodStr) return [];
  const parts = sowingPeriodStr.split(',');
  const ranges = [];
  
  for (const part of parts) {
    const rangeParts = part.split('-');
    if (rangeParts.length === 2) {
      const startObj = parseTerm(rangeParts[0], false, year);
      const endObj = parseTerm(rangeParts[1], true, year);
      if (startObj && endObj) {
        const sowingStart = new Date(year, startObj.month, startObj.day, 0, 0, 0, 0);
        const sowingEnd = new Date(year, endObj.month, endObj.day, 23, 59, 59, 999);
        const openStart = new Date(sowingStart.getTime());
        openStart.setDate(sowingStart.getDate() - 30);
        openStart.setHours(0, 0, 0, 0);
        ranges.push({ sowingStart, sowingEnd, openStart, openEnd: sowingEnd });
      }
    } else if (rangeParts.length === 1) {
      const startObj = parseTerm(rangeParts[0], false, year);
      const endObj = parseTerm(rangeParts[0], true, year);
      if (startObj && endObj) {
        const sowingStart = new Date(year, startObj.month, startObj.day, 0, 0, 0, 0);
        const sowingEnd = new Date(year, endObj.month, endObj.day, 23, 59, 59, 999);
        const openStart = new Date(sowingStart.getTime());
        openStart.setDate(sowingStart.getDate() - 30);
        openStart.setHours(0, 0, 0, 0);
        ranges.push({ sowingStart, sowingEnd, openStart, openEnd: sowingEnd });
      }
    }
  }
  return ranges;
}

function calculateDeviation(actual, normal) {
  if (actual === 0 && normal === 0) return 0;
  if (actual + normal === 0) return 0;
  return ((actual - normal) / (actual + normal)) * 100;
}

function getDeviationCategory(deviation) {
  if (deviation > 19) return 'ABOVE NORMAL';
  if (deviation < -19) return 'BELOW NORMAL';
  return 'NORMAL';
}

function normalizeSowingMonth(sowingPeriod) {
  if (!sowingPeriod) return '';
  let clean = sowingPeriod.replace(/\s+/g, '').toUpperCase();
  clean = clean.replace('JANUARY', 'JAN')
               .replace('FEBRUARY', 'FEB')
               .replace('MARCH', 'MAR')
               .replace('APRIL', 'APR')
               .replace('AUGUST', 'AUG')
               .replace('SEPTEMBER', 'SEP')
               .replace('OCTOBER', 'OCT')
               .replace('NOVEMBER', 'NOV')
               .replace('DECEMBER', 'DEC');
  return clean;
}

function matchDas(das, dasStr) {
  if (!dasStr) return false;
  const clean = dasStr.trim();
  
  if (clean.startsWith('>')) {
    const val = parseInt(clean.substring(1).trim(), 10);
    return !isNaN(val) && das > val;
  }
  
  if (clean.startsWith('<')) {
    const val = parseInt(clean.substring(1).trim(), 10);
    return !isNaN(val) && das < val;
  }
  
  const hyphenIndex = clean.indexOf('-', 1);
  if (hyphenIndex > 0) {
    const startVal = parseInt(clean.substring(0, hyphenIndex).trim(), 10);
    const endVal = parseInt(clean.substring(hyphenIndex + 1).trim(), 10);
    return !isNaN(startVal) && !isNaN(endVal) && das >= startVal && das <= endVal;
  }
  
  const val = parseInt(clean, 10);
  return !isNaN(val) && das === val;
}

function fixKannadaGarbage(str) {
  if (!str) return str;
  try {
    let decoded = Buffer.from(str, "latin1").toString("utf8");
    decoded = decoded.replace(/[\u0000-\u001F\u007F-\u009F]/g, "");
    decoded = decoded.replace(/[\uFFFD]+/g, "");
    decoded = decoded.replace(/[^\u0C80-\u0CFF\s.,0-9\-\/]+/g, "");
    return decoded.trim();
  } catch (err) {
    return str;
  }
}

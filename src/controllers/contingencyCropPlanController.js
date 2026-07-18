// src/controllers/contingencyCropPlanController.js
const ContingencyCropPlan = require('../models/contingencyCropPlan');
const ApiResponse = require('../utils/ApiResponse');

const HORTI_WEEKS_CROPS = [
  'TOMATO', 'BRINJAL', 'CHILLI', 'CHILLIES', 'CHILLYS', 'POTATO', 'ONION', 'PUMPKIN',
  'FRENCH BEAN', 'FRENCH BEANS', 'BEANS', 'SWEAT POTATO', 'SWEET POTATO', 'BANANA',
  'GINGER', 'TURMERIC', 'CUCUMBER', 'CABBAGE'
];

const HORTI_MONTHS_CROPS = [
  'MANGO', 'GRAPES', 'POMEGRANATE', 'GUAVA', 'SAPOTA', 'JACKFRUIT', 'PAPAYA',
  'COCONUT', 'ARECA NUT', 'ARECANUT', 'CASHEW NUT', 'CASHEWNUT', 'CASHEW',
  'BLACK PEPPER', 'BLACKPEPPER', 'CARDAMOM', 'CARDMOM', 'LEMON', 'BETELVINE',
  'BEETLEVINE', 'DRUMSTICK'
];

function normalizeHortiCropNameForAdvisory(cropName) {
  if (!cropName) return '';
  const upper = cropName.toUpperCase().trim();
  if (upper === 'ARECA NUT' || upper === 'ARECANUT') return 'ARECANUT';
  if (upper === 'CASHEW NUT' || upper === 'CASHEW' || upper === 'CASHEWNUT') return 'CASHEWNUT';
  if (upper === 'BLACKPEPPER' || upper === 'BLACK PEPPER') return 'BLACK PEPPER';
  if (upper === 'CARDMOM' || upper === 'CARDAMOM') return 'CARDAMOM';
  if (upper === 'BETELVINE' || upper === 'BEETLEVINE' || upper === 'BETEL VINE') return 'BETEL VINE';
  if (upper === 'PROMOGRANATE' || upper === 'POMEGRANATE') return 'POMEGRANATE';
  return upper;
}

function getHortiMonthsSowingPeriodFallback(crop, region) {
  const upper = crop.toUpperCase().trim();
  const isSik = region === 'SIK';
  const isNik = region === 'NIK';
  const isBoth = isSik || isNik;

  if (upper === 'MANGO' && isBoth) return '6,7';
  if (upper === 'GRAPES' && isBoth) return '10,11,12,1';
  if ((upper === 'POMEGRANATE' || upper === 'PROMOGRANATE') && isBoth) return '6';
  if (upper === 'GUAVA' && isBoth) return '6,7';
  if (upper === 'SAPOTA' && isBoth) return '6';
  if (upper === 'PAPAYA' && isBoth) return '6';
  if (upper === 'COCONUT' && isBoth) return '6,7';
  if ((upper === 'ARECANUT' || upper === 'ARECA NUT') && isBoth) return '6';
  if ((upper === 'CASHEWNUT' || upper === 'CASHEW NUT' || upper === 'CASHEW') && isBoth) return '6';
  if ((upper === 'BLACK PEPPER' || upper === 'BLACKPEPPER') && isSik) return '6,7';
  if ((upper === 'CARDAMOM' || upper === 'CARDMOM') && isSik) return '5,6';
  if (upper === 'JACKFRUIT' && isSik) return '6,7';
  if (upper === 'LEMON' && isNik) return '6';
  if ((upper === 'BETELVINE' || upper === 'BEETLEVINE' || upper === 'BETEL VINE') && isNik) return '6,7';
  if (upper === 'DRUMSTICK' && isNik) return '6,7';

  return '';
}

function groupMonthNumbersIntoRanges(year, monthNumbers) {
  if (!monthNumbers || monthNumbers.length === 0) return [];
  const sorted = [...monthNumbers].sort((a, b) => a - b);
  
  const ranges = [];
  let startMonth = sorted[0];
  let prevMonth = sorted[0];
  
  for (let i = 1; i < sorted.length; i++) {
    const m = sorted[i];
    if (m === prevMonth + 1) {
      prevMonth = m;
    } else {
      ranges.push({ startMonth, endMonth: prevMonth });
      startMonth = m;
      prevMonth = m;
    }
  }
  ranges.push({ startMonth, endMonth: prevMonth });
  
  return ranges.map(r => {
    const sowingStart = new Date(year, r.startMonth - 1, 1, 0, 0, 0, 0);
    const sowingEnd = new Date(year, r.endMonth, 0, 23, 59, 59, 999);
    return {
      sowingStart,
      sowingEnd,
      openStart: new Date(sowingStart),
      openEnd: new Date(sowingEnd)
    };
  });
}

async function isHortiMonthDateAllowed(crop, region, targetDate) {
  const normCropName = normalizeHortiCropNameForAdvisory(crop);
  let sowingPeriodStr = await ContingencyCropPlan.getHortiMonthsSowingPeriod(normCropName, region);
  if (!sowingPeriodStr) {
    sowingPeriodStr = getHortiMonthsSowingPeriodFallback(crop, region);
  }

  if (!sowingPeriodStr) return true;

  const monthNumbers = sowingPeriodStr.split(',').map(m => parseInt(m.trim(), 10)).filter(m => !isNaN(m));
  if (monthNumbers.length === 0) return true;

  const currentYear = new Date().getFullYear();
  const today = new Date();
  const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 0, 0, 0, 0);
  const targetDateOnly = new Date(targetDate.getFullYear(), targetDate.getMonth(), targetDate.getDate(), 0, 0, 0, 0);

  for (let year = currentYear; year >= currentYear - 30; year--) {
    const yearRanges = groupMonthNumbersIntoRanges(year, monthNumbers);
    for (const r of yearRanges) {
      if (year === currentYear) {
        if (r.sowingStart > todayDateOnly) {
          continue;
        }
        if (r.sowingEnd > todayDateOnly) {
          r.sowingEnd = new Date(todayDateOnly);
          r.openEnd = new Date(todayDateOnly);
        }
      }

      if (targetDateOnly >= r.sowingStart && targetDateOnly <= r.sowingEnd) {
        return true;
      }
    }
  }

  return false;
}

function normalizeCropName(cropName, tableType, region) {
  if (!cropName) return '';
  const upper = cropName.toUpperCase().trim();
  const cleanRegion = region ? region.toUpperCase().trim() : '';

  if (tableType === 'BLOCKING') {
    if (upper === 'RAGI') return 'FINGER MILLET';
    if (upper === 'BROWNTOP MILLET') return 'BROWN TOP MILLET';
    if (upper === 'RICE' || upper === 'RICE(IR)' || upper === 'RICE (IR)') {
      return (cleanRegion.includes('NIK') || cleanRegion === '2.NIK') ? 'PADDY' : 'RICE (IR)';
    }
    return upper;
  }

  if (tableType === 'DURATION') {
    if (upper === 'RAGI') return 'FINGER MILLET';
    if (upper === 'BROWNTOP MILLET') return 'BROWN TOP MILLET';
    if (upper === 'RICE' || upper === 'RICE(IR)' || upper === 'RICE (IR)') return 'RICE (IR)';
    return upper;
  }

  if (tableType === 'ADVISORY') {
    if (upper === 'FINGER MILLET') return 'RAGI';
    if (upper === 'BROWN TOP MILLET') return 'BROWNTOP MILLET';
    if (upper === 'RICE (IR)' || upper === 'RICE(IR)' || upper === 'RICE') {
      return (cleanRegion.includes('NIK') || cleanRegion === '2.NIK') ? 'PADDY' : 'RICE';
    }
    return upper;
  }

  return upper;
}

function resolveSowingMonth(crop, region, sowingDate, blockingPeriod) {
  const upperCrop = crop.toUpperCase().trim();
  const month = sowingDate.getMonth() + 1; // 1-12
  const day = sowingDate.getDate();

  const cleanRegion = region ? region.toUpperCase().trim() : '';

  if (cleanRegion.includes('SIK')) {
    if (upperCrop === 'GROUNDNUT') {
      return 'June';
    }

    if (upperCrop === 'REDGRAM') {
      if ((month === 5 && day >= 15) || month === 6) {
        return 'MAY 15 - JUNE 30';
      }
      if (month === 7) {
        return 'JULY 1 - JULY 31';
      }
      if (month === 8 && day <= 20) {
        return 'August 1 - August 20';
      }
      if (month < 5 || (month === 5 && day < 15)) {
        return 'MAY 15 - JUNE 30';
      }
      return 'August 1 - August 20';
    }

    if (upperCrop === 'GREENGRAM') {
      return 'January-February & April-May';
    }

    if (upperCrop === 'SORGHUM') {
      return 'September 15 to October 15';
    }

    if (upperCrop === 'FOXTAIL MILLET') {
      if (month === 1) return 'January';
      if (month === 5) return 'May-August';
      return 'June-August';
    }

    if (upperCrop === 'SUGARCANE') {
      if (month === 1 || month === 2) return 'January-February';
      if (month === 7 || month === 8) return 'July-August';
      return 'Oct-November';
    }

    if (upperCrop === 'FIELDBEAN') {
      return 'FEB-AUG-SEP';
    }

    if (upperCrop === 'CASTOR') {
      if (month === 7) return 'MAY-JULY';
      return 'MAY-JUNE';
    }

    if (upperCrop === 'PROSO MILLET') {
      if (month === 5) return 'May-July';
      return 'June-July';
    }

    if (upperCrop === 'RAGI' || upperCrop === 'FINGER MILLET') {
      if (month === 6) return 'June-July';
      if (month === 7) {
        return day <= 15 ? 'June-July' : 'July-August';
      }
      if (month === 8) {
        return day <= 15 ? 'July-August' : 'August-September';
      }
      if (month === 9) return 'August-September';
      return 'June-July';
    }
  }

  if (cleanRegion.includes('NIK')) {
    if (upperCrop === 'SORGHUM') {
      return 'June, Sept 15 - Oct 15';
    }
    if (upperCrop === 'SUGARCANE') {
      return 'Jul-Aug, Oct-Nov';
    }
    if (upperCrop === 'SOYABEAN') {
      return 'JULY-15';
    }
    if (upperCrop === 'COWPEA') {
      return 'JULY - AUGUST';
    }
    if (upperCrop === 'RICE (IR)' || upperCrop === 'RICE' || upperCrop === 'PADDY') {
      return 'June-July, October';
    }
  }

  return normalizeSowingMonth(blockingPeriod);
}



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
      return await handleSownNo(req, res, district, mobileNo, targetDateStr);
    }

    // Resolve farmer and target parameters
    let farmer = null;
    if (mobileNo) {
      farmer = await ContingencyCropPlan.getFarmerByMobileNo(mobileNo);
    }

    const targetCrop = crop || (farmer && farmer.crop_name);
    const targetTrgCode = trg_code || (farmer && farmer.trgcode);
    const targetHobliCode = hobli_code || (farmer && farmer.hobli_code);
    const targetDistrict = district || (farmer && farmer.district);
    const targetDistrictCode = district || (farmer && farmer.districtcode);

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

    // Validate: Do not allow future sowing date
    const today = new Date();
    const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    if (parsedShowingDate > todayDateOnly) {
      return ApiResponse.error(res, 400, 'Sowing date cannot be a future date.');
    }

    let cleanRegion = null;
    if (region) {
      cleanRegion = getCleanRegion(region);
    }
    if (!cleanRegion) {
      const dbRegion = await ContingencyCropPlan.getRegionByDistrict({
        district: targetDistrict,
        districtCode: targetDistrictCode
      });
      if (dbRegion) {
        cleanRegion = getCleanRegion(dbRegion);
      }
    }
    if (!cleanRegion) {
      cleanRegion = 'NIK';
    }

    console.log(`[${new Date().toISOString()}] Resolved parameters: Crop: ${targetCrop}, Region: ${cleanRegion}, Sowing Date: ${parsedShowingDate.toISOString()}`);

    // Determine crop type
    const durationCropName = normalizeCropName(targetCrop, 'DURATION', cleanRegion);
    const cropDetails = await ContingencyCropPlan.getCropVarietyDuration(durationCropName, cleanRegion);
    let cropType = '';
    let resolvedCropId = null;
    let resolvedCropDuration = '';

    if (cropDetails) {
      cropType = (cropDetails.crop_type || '').trim().toUpperCase();
      resolvedCropId = cropDetails.crop_id || cropDetails.CROP_ID;
      resolvedCropDuration = cropDetails.crop_duration || cropDetails.CROP_DURATION;
    }

    const upperCrop = targetCrop.toUpperCase().trim();
    if (upperCrop === 'FIELDBEAN') {
      cropType = 'AGRICULTURE';
    }

    const isWeeksHorti = HORTI_WEEKS_CROPS.includes(upperCrop);
    const isMonthsHorti = HORTI_MONTHS_CROPS.includes(upperCrop);

    if (isWeeksHorti || isMonthsHorti || cropType === 'HORTICULTURE' || cropType === 'HORTI') {
      cropType = 'HORTICULTURE';
    }

    if (!cropType) {
      cropType = 'AGRICULTURE';
    }

    if (cropType === 'HORTICULTURE') {
      if (isMonthsHorti) {
        const isAllowed = await isHortiMonthDateAllowed(targetCrop, cleanRegion, parsedShowingDate);
        if (!isAllowed) {
          console.log(`[${new Date().toISOString()}] Sowing date ${formatDateLocal(parsedShowingDate)} is blocked for Horti crop ${targetCrop}.`);
          return ApiResponse.ok(res, 'Sowing date is outside the allowed sowing months. Calendar blocked.', {
            status: 'BLOCKED',
            message: 'Sowing date is outside the allowed sowing months.'
          });
        }
      }

      // Resolve previous and next week rainfall category
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

        if (prevRainCategory === 'NORMAL') {
          nextRainCategory = 'YES';
        }
      }

      if (!isMonthsHorti) {
        return await handleHortiWeeksAdvisory(req, res, {
          targetCrop,
          cleanRegion,
          parsedShowingDate,
          prevRainCategory,
          nextRainCategory,
          resolvedCropDuration
        });
      } else {
        return await handleHortiMonthsAdvisory(req, res, {
          targetCrop,
          cleanRegion,
          parsedShowingDate,
          prevRainCategory,
          nextRainCategory,
          resolvedCropDuration
        });
      }
    } else {
      return await handleAgricultureAdvisory(req, res, {
        targetCrop,
        cleanRegion,
        parsedShowingDate,
        targetTrgCode,
        targetHobliCode,
        prevRainfall,
        nextRainfall,
        cropDetails
      });
    }
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

    const upperCrop = crop.toUpperCase().trim();
    const isWeeksHorti = HORTI_WEEKS_CROPS.includes(upperCrop);
    const isMonthsHorti = HORTI_MONTHS_CROPS.includes(upperCrop);

    if (isWeeksHorti || isMonthsHorti) {
      let ranges = [];
      if (isMonthsHorti) {
        const normCropName = normalizeHortiCropNameForAdvisory(crop);
        let sowingPeriodStr = await ContingencyCropPlan.getHortiMonthsSowingPeriod(normCropName, cleanRegion);
        if (!sowingPeriodStr) {
          sowingPeriodStr = getHortiMonthsSowingPeriodFallback(crop, cleanRegion);
        }

        if (sowingPeriodStr) {
          const monthNumbers = sowingPeriodStr.split(',').map(m => parseInt(m.trim(), 10)).filter(m => !isNaN(m));
          if (monthNumbers.length > 0) {
            const currentYear = new Date().getFullYear();
            const today = new Date();
            const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 0, 0, 0, 0);
            
            const allRanges = [];
            for (let year = currentYear; year >= currentYear - 30; year--) {
              const yearRanges = groupMonthNumbersIntoRanges(year, monthNumbers);
              for (const r of yearRanges) {
                if (year === currentYear) {
                  if (r.sowingStart > todayDateOnly) {
                    continue;
                  }
                  if (r.sowingEnd > todayDateOnly) {
                    r.sowingEnd = new Date(todayDateOnly);
                    r.openEnd = new Date(todayDateOnly);
                  }
                }
                allRanges.push(r);
              }
            }
            allRanges.sort((a, b) => a.sowingStart - b.sowingStart);

            ranges = allRanges.map(r => ({
              sowingStart: formatDateLocal(r.sowingStart),
              sowingEnd: formatDateLocal(r.sowingEnd),
              openStart: formatDateLocal(r.openStart),
              openEnd: formatDateLocal(r.openEnd)
            }));
          }
        }
      }

      return ApiResponse.ok(res, 'Crop period info retrieved successfully', {
        crop,
        cropType: 'HORTICULTURE',
        calendarType: isWeeksHorti ? 'WEEKS' : 'MONTHS',
        allowFutureDate: false,
        openperiod_msg: '',
        ranges: ranges
      });
    }

    const blockingCropName = normalizeCropName(crop, 'BLOCKING', cleanRegion);
    const blocking = await ContingencyCropPlan.getBlockingPeriod(blockingCropName, cleanRegion);
    if (!blocking) {
      return ApiResponse.error(res, 404, `Blocking period not found for crop ${crop} in region ${cleanRegion}`);
    }

    const currentYear = new Date().getFullYear();
    const rangesCurrent = parseSowingPeriod(blocking.sowing_period, currentYear);
    const rangesPrev = parseSowingPeriod(blocking.sowing_period, currentYear - 1);
    const allRanges = [...rangesPrev, ...rangesCurrent];

    const formattedRanges = allRanges.map(r => ({
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
    // If the string already contains valid Kannada characters, it is already correct.
    // Do not run the Latin-1 conversion, as it will destroy it.
    const hasKannada = /[\u0C80-\u0CFF]/.test(str);
    if (hasKannada) {
      return str.replace(/[\u0000-\u001F\u007F-\u009F]/g, "").trim();
    }

    // Otherwise, it might be double-encoded or Latin-1 corrupted.
    let decoded = Buffer.from(str, "latin1").toString("utf8");

    // Check if the decoded version now contains Kannada.
    if (/[\u0C80-\u0CFF]/.test(decoded)) {
      decoded = decoded.replace(/[\u0000-\u001F\u007F-\u009F]/g, "");
      decoded = decoded.replace(/[\uFFFD]+/g, "");
      decoded = decoded.replace(/[^\u0C80-\u0CFF\s.,0-9\-\/]+/g, "");
      return decoded.trim();
    }

    return str.trim();
  } catch (err) {
    return str;
  }
}

/**
 * Handles Sown = NO advisory logic
 */
async function handleSownNo(req, res, district, mobileNo, targetDateStr) {
  let targetDistrict = district;

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

/**
 * Handles Sown = YES, Agriculture (Field) Crop advisory logic
 */
async function handleAgricultureAdvisory(req, res, {
  targetCrop,
  cleanRegion,
  parsedShowingDate,
  targetTrgCode,
  targetHobliCode,
  prevRainfall,
  nextRainfall,
  cropDetails
}) {
  const blockingCropName = normalizeCropName(targetCrop, 'BLOCKING', cleanRegion);
  const blocking = await ContingencyCropPlan.getBlockingPeriod(blockingCropName, cleanRegion);
  if (!blocking) {
    return ApiResponse.error(res, 400, `Blocking period configuration not found for crop ${targetCrop} in region ${cleanRegion}`);
  }

  const year = parsedShowingDate.getFullYear();
  const ranges = parseSowingPeriod(blocking.sowing_period, year);

  if (ranges.length === 0) {
    return ApiResponse.error(res, 500, `Failed to parse sowing periods for crop ${targetCrop}: ${blocking.sowing_period}`);
  }

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

  if (!isWithinSowingRange && !isWithinOpenRange) {
    console.log(`[${new Date().toISOString()}] Sowing date ${formatDateLocal(parsedShowingDate)} is blocked.`);
    return ApiResponse.ok(res, 'Sowing date is outside the allowed open period. Calendar blocked.', {
      status: 'BLOCKED',
      message: 'Sowing date is outside the allowed open period.'
    });
  }

  if (!isWithinSowingRange && isWithinOpenRange) {
    console.log(`[${new Date().toISOString()}] Sowing date is pre-sowing warning period.`);
    const warningKn = fixKannadaGarbage(blocking.openperiod_msg);
    return ApiResponse.ok(res, 'Pre-sowing warning', {
      status: 'PRE_SOWING',
      message: warningKn || 'Pre-sowing warning period',
      openperiod_msg: warningKn || ''
    });
  }

  console.log(`[${new Date().toISOString()}] Sowing date is within sowing range. Running weather based calculations...`);

  const today = new Date();
  const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
  const sowingDateOnly = new Date(parsedShowingDate.getFullYear(), parsedShowingDate.getMonth(), parsedShowingDate.getDate());
  const timeDiff = todayDateOnly.getTime() - sowingDateOnly.getTime();
  const das = Math.floor(timeDiff / (1000 * 60 * 60 * 24));

  const cropDuration = cropDetails ? (cropDetails.crop_duration || cropDetails.CROP_DURATION) : 0;
  if (cropDuration && das > (cropDuration + 30)) {
    console.log(`[${new Date().toISOString()}] Sowing date is older than crop duration + 30 days (${das} > ${cropDuration + 30}). Crop is harvested.`);
    return ApiResponse.ok(res, 'Crop has been harvested.', {
      AGRICULTURE_MEASURES_KN: 'ಬೆಳೆ ಕಟಾವಾಗಿದೆ.',
      PLANT_PROTECTION_MEARURES_KN: 'ಕಟಾವಿನ ನಂತರದ ಹಂತದಲ್ಲಿ ಯಾವುದೇ ಸಸ್ಯ ಸಂರಕ್ಷಣಾ ಕ್ರಮಗಳ ಅಗತ್ಯವಿಲ್ಲ.',
      AGRICULTURE_MEASURES_ENG: 'Crop has been harvested.',
      PLANT_PROTECTION_MEARURES_ENG: 'No plant protection measures are required post-harvest.',
      AGRICULTURE_MEASURES_KN2: '',
      PLANT_PROTECTION_MEARURES_KN2: '',
      CROP_NAME: targetCrop,
      DAS_OF_CROP: `${cropDuration}+`,
      CROP_DURATION: cropDuration,
      das: das,
      prevRainfall: prevRainfall || 'NIL',
      nextRainfall: nextRainfall || 'NIL',
      status: 'HARVESTED',
      message: 'Crop has been harvested.'
    });
  }

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

    if (prevRainCategory === 'NORMAL') {
      nextRainCategory = 'YES';
    }
  }

  console.log(`[${new Date().toISOString()}] Rain Categories - Previous Week: ${prevRainCategory}, Forecast: ${nextRainCategory}, DAS: ${das}`);

  const advisoryCropName = normalizeCropName(targetCrop, 'ADVISORY', cleanRegion);
  const sowingMonthNorm = resolveSowingMonth(targetCrop, cleanRegion, parsedShowingDate, blocking.sowing_period);
  const cropId = cropDetails.crop_id || cropDetails.CROP_ID;

  let advisories = await ContingencyCropPlan.fetchFieldCropAdvisory({
    cropName: advisoryCropName,
    cropId: cropId,
    sowingMonth: sowingMonthNorm,
    prevRainfall: prevRainCategory,
    nextRainfall: nextRainCategory,
    regionCode: cleanRegion
  });

  let matchedAdvisory = null;
  for (const adv of advisories) {
    if (matchDas(das, adv.das_of_crop)) {
      matchedAdvisory = adv;
      break;
    }
  }

  // Fallback to NIL/NIL rainfall if no match is found (weather-independent post-harvest stages)
  if (!matchedAdvisory && (prevRainCategory !== 'NIL' || nextRainCategory !== 'NIL')) {
    console.log(`[${new Date().toISOString()}] No active weather advisory matched. Falling back to NIL/NIL weather-independent query...`);
    const fallbackAdvisories = await ContingencyCropPlan.fetchFieldCropAdvisory({
      cropName: advisoryCropName,
      cropId: cropId,
      sowingMonth: sowingMonthNorm,
      prevRainfall: 'NIL',
      nextRainfall: 'NIL',
      regionCode: cleanRegion
    });
    for (const adv of fallbackAdvisories) {
      if (matchDas(das, adv.das_of_crop)) {
        matchedAdvisory = adv;
        break;
      }
    }
  }

  if (!matchedAdvisory) {
    console.log(`[${new Date().toISOString()}] No crop advisory row matched for crop: ${targetCrop}, region: ${cleanRegion}, DAS: ${das}`);
    return ApiResponse.error(res, 404, `No matching crop advisory found for crop ${targetCrop} in region ${cleanRegion} at ${das} DAS.`);
  }

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
}

/**
 * Handles Sown = YES, Horticulture Weeks-based advisory logic
 */
async function handleHortiWeeksAdvisory(req, res, {
  targetCrop,
  cleanRegion,
  parsedShowingDate,
  prevRainCategory,
  nextRainCategory,
  resolvedCropDuration
}) {
  console.log(`[${new Date().toISOString()}] Processing weeks-based Horticulture crop: ${targetCrop}`);

  let activePrevRain = prevRainCategory;
  let activeNextRain = nextRainCategory;

  if (activePrevRain === 'NIL' || !activePrevRain) {
    activePrevRain = 'BELOW NORMAL';
  }
  if (activeNextRain === 'NIL' || !activeNextRain) {
    activeNextRain = 'NO';
  }

  const today = new Date();
  const todayDateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
  const sowingDateOnly = new Date(parsedShowingDate.getFullYear(), parsedShowingDate.getMonth(), parsedShowingDate.getDate());
  const timeDiff = todayDateOnly.getTime() - sowingDateOnly.getTime();
  const das = Math.floor(timeDiff / (1000 * 60 * 60 * 24));

  // Standard round off: e.g. 22/7 should be 3.1 -> 3
  const weeks = Math.round(das / 7);

  const advisories = await ContingencyCropPlan.fetchHortiWeekAdvisory({
    cropName: targetCrop,
    prevRainfall: activePrevRain,
    nextRainfall: activeNextRain,
    regionCode: cleanRegion
  });

  if (advisories.length === 0) {
    console.log(`[${new Date().toISOString()}] No advisories found in HORTI_WEEKS_CROPS_ADVISORY for crop: ${targetCrop}`);
    return ApiResponse.error(res, 404, `No crop advisories found for crop ${targetCrop} in region ${cleanRegion}`);
  }

  let matchedAdvisory = null;
  const upperCrop = targetCrop.toUpperCase().trim();
  const isCabbage = upperCrop === 'CABBAGE';
  let cabbageSowingMonth = '';
  if (isCabbage) {
    const monthsLong = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'];
    cabbageSowingMonth = monthsLong[parsedShowingDate.getMonth()];
  }

  for (const adv of advisories) {
    const weeksField = adv.weeks_in_number || adv.WEEKS_IN_NUMBER || adv.crop_period_in_weeks || adv.CROP_PERIOD_IN_WEEKS;
    if (matchDas(weeks, weeksField)) {
      const rowSowingMonth = adv.sowing_month || adv.SOWING_MONTH;
      if (isCabbage && rowSowingMonth && rowSowingMonth !== 'NIL') {
        if (!rowSowingMonth.toUpperCase().includes(cabbageSowingMonth)) {
          continue;
        }
      }
      matchedAdvisory = adv;
      break;
    }
  }

  if (!matchedAdvisory) {
    console.log(`[${new Date().toISOString()}] No matching week advisory for week: ${weeks}`);
    return ApiResponse.error(res, 404, `No matching week advisory found for crop ${targetCrop} at week ${weeks} in region ${cleanRegion}`);
  }

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
    WEEKS_IN_NUMBER: matchedAdvisory.weeks_in_number || matchedAdvisory.WEEKS_IN_NUMBER || matchedAdvisory.crop_period_in_weeks || matchedAdvisory.CROP_PERIOD_IN_WEEKS,
    GROWTH_STAGE: matchedAdvisory.growth_stage || matchedAdvisory.GROWTH_STAGE,
    CROP_DURATION: resolvedCropDuration || '',
    weeks: weeks,
    das: das,
    prevRainfall: prevRainCategory,
    nextRainfall: nextRainCategory
  };

  console.log(`[${new Date().toISOString()}] Weeks-based horticulture advisory resolved successfully`);
  return ApiResponse.ok(res, 'Crop advisory retrieved successfully', responsePayload);
}

/**
 * Resolves the crop's database age category dynamically
 */
function resolveAgeCategory(categories, monthsAfterSowing) {
  if (!categories || categories.length === 0) {
    if (monthsAfterSowing < 12) return '<1';
    if (monthsAfterSowing >= 12 && monthsAfterSowing <= 48) return '1-4';
    return '>4';
  }

  const cleaned = categories.map(c => c ? c.trim() : '').filter(Boolean);

  const hasLessThanOne = cleaned.includes('<1') || cleaned.includes('< 1');
  const hasGreaterThanOne = cleaned.includes('>1') || cleaned.includes('> 1');
  const hasGreaterThanTwo = cleaned.includes('>2') || cleaned.includes('> 2');
  const hasGreaterThanFour = cleaned.includes('>4') || cleaned.includes('> 4');
  const intermediate = cleaned.find(c => c.includes('-'));

  if (monthsAfterSowing < 12) {
    if (hasLessThanOne) {
      return cleaned.find(c => c.includes('<1') || c === '< 1') || '<1';
    }
    // If we only have >1 and no <1 (like Lemon NIK), map <12 months to >1
    if (hasGreaterThanOne && !hasLessThanOne && hasGreaterThanFour) {
      return cleaned.find(c => c.includes('>1') || c === '> 1') || '>1';
    }
    return '<1';
  }

  if (intermediate) {
    const parts = intermediate.split('-');
    if (parts.length === 2) {
      const maxYears = parseInt(parts[1].trim(), 10);
      if (!isNaN(maxYears)) {
        const maxMonths = maxYears * 12;
        if (monthsAfterSowing <= maxMonths) {
          return intermediate;
        }
      }
    }
  }

  if (hasGreaterThanFour) {
    return cleaned.find(c => c.includes('>4') || c === '> 4') || '>4';
  }
  if (hasGreaterThanTwo) {
    return cleaned.find(c => c.includes('>2') || c === '> 2') || '>2';
  }
  if (hasGreaterThanOne) {
    return cleaned.find(c => c.includes('>1') || c === '> 1') || '>1';
  }

  return '>4';
}

/**
 * Handles Sown = YES, Horticulture Months-based advisory logic
 */
async function handleHortiMonthsAdvisory(req, res, {
  targetCrop,
  cleanRegion,
  parsedShowingDate,
  prevRainCategory,
  nextRainCategory,
  resolvedCropDuration
}) {
  console.log(`[${new Date().toISOString()}] Processing months-based Horticulture crop: ${targetCrop}`);

  let activePrevRain = prevRainCategory;
  let activeNextRain = nextRainCategory;

  if (activePrevRain === 'NIL' || !activePrevRain) {
    activePrevRain = 'BELOW NORMAL';
  }
  if (activeNextRain === 'NIL' || !activeNextRain) {
    activeNextRain = 'NO';
  }

  const today = new Date();
  const monthsAfterSowing = (today.getFullYear() - parsedShowingDate.getFullYear()) * 12 + (today.getMonth() - parsedShowingDate.getMonth());

  const normCrop = normalizeHortiCropNameForAdvisory(targetCrop);
  const categories = await ContingencyCropPlan.getHortiMonthAgeCategories(normCrop, cleanRegion);
  const ageCategory = resolveAgeCategory(categories, monthsAfterSowing);

  const advisories = await ContingencyCropPlan.fetchHortiMonthAdvisory({
    cropName: normCrop,
    prevRainfall: activePrevRain,
    nextRainfall: activeNextRain,
    regionCode: cleanRegion,
    ageOfCrop: ageCategory
  });

  if (advisories.length === 0) {
    console.log(`[${new Date().toISOString()}] No advisories found in HORTI_MONTHS_CROPS_ADVISORY for crop: ${targetCrop}`);
    return ApiResponse.error(res, 404, `No crop advisories found for crop ${targetCrop} in region ${cleanRegion}`);
  }

  const currentMonthIndex = today.getMonth() + 1;
  let matchedAdvisory = null;

  for (const adv of advisories) {
    const monthsStr = adv.month_in_number || adv.MONTH_IN_NUMBER || '';
    const monthsList = monthsStr.toString().split(',').map(m => m.trim());
    if (monthsList.includes(currentMonthIndex.toString())) {
      matchedAdvisory = adv;
      break;
    }
  }

  if (!matchedAdvisory) {
    matchedAdvisory = advisories[0];
  }

  const knMeasures = fixKannadaGarbage(matchedAdvisory.agriculture_measures_kn || matchedAdvisory.AGRICULTURE_MEASURES_KN);
  const knProtection = fixKannadaGarbage(matchedAdvisory.plant_protection_kn || matchedAdvisory.PLANT_PROTECTION_KN);
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
    AGE_OF_THE_CROP: matchedAdvisory.age_of_the_crop || matchedAdvisory.AGE_OF_THE_CROP,
    MONTH_IN_NUMBER: matchedAdvisory.month_in_number || matchedAdvisory.MONTH_IN_NUMBER,
    GROWTH_STAGE: matchedAdvisory.growth_stage || matchedAdvisory.GROWTH_STAGE,
    CROP_DURATION: resolvedCropDuration || '',
    monthsAfterSowing: monthsAfterSowing,
    prevRainfall: prevRainCategory,
    nextRainfall: nextRainCategory
  };

  console.log(`[${new Date().toISOString()}] Months-based horticulture advisory resolved successfully`);
  return ApiResponse.ok(res, 'Crop advisory retrieved successfully', responsePayload);
}

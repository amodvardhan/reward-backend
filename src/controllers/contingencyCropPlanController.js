// src/controllers/contingencyCropPlanController.js
const ContingencyCropPlan = require('../models/contingencyCropPlan');
const ApiResponse = require('../utils/ApiResponse');

/**
 * Get contingency crop plan for a district and date
 */
exports.getContingencyCropPlan = async (req, res) => {
  console.log(`[${new Date().toISOString()}] ContingencyCropPlan API request started: ${req.method} ${req.url}`);
  try {
    const { district, date, showing_date } = req.query;
    const targetDateStr = date || showing_date;

    // Validate district parameter
    if (!district) {
      console.log(`[${new Date().toISOString()}] ContingencyCropPlan validation failed: missing district`);
      return ApiResponse.error(res, 400, 'Missing required parameter: district');
    }

    // Validate date parameter
    if (!targetDateStr) {
      console.log(`[${new Date().toISOString()}] ContingencyCropPlan validation failed: missing date`);
      return ApiResponse.error(res, 400, 'Missing required parameter: date or showing_date');
    }

    // Parse date robustly
    const parsedDate = parseDate(targetDateStr);
    if (!parsedDate) {
      console.log(`[${new Date().toISOString()}] ContingencyCropPlan validation failed: invalid date format: ${targetDateStr}`);
      return ApiResponse.error(res, 400, 'Invalid date format. Supported formats include YYYY-MM-DD, DD-MM-YYYY, and DD-MM-YY');
    }

    console.log(`[${new Date().toISOString()}] Fetching contingency crop plan for district: ${district}, date: ${parsedDate.toISOString()}`);
    const plan = await ContingencyCropPlan.getPlanByDistrictAndDate({ district, date: parsedDate });

    if (!plan) {
      console.log(`[${new Date().toISOString()}] Contingency crop plan not found for the parameters`);
      return ApiResponse.error(res, 404, 'Contingency crop plan not available for the given district and date');
    }

    console.log(`[${new Date().toISOString()}] Contingency crop plan retrieved successfully`);
    return ApiResponse.ok(res, 'Contingency crop plan retrieved successfully', plan);
  } catch (error) {
    console.error(`[${new Date().toISOString()}] Error in getContingencyCropPlan:`, error.message);
    return ApiResponse.error(res, 500, 'Failed to retrieve contingency crop plan', { error: error.message });
  }
};

/**
 * Helper to robustly parse date strings from query parameters
 * @param {string} dateStr 
 * @returns {Date|null}
 */
function parseDate(dateStr) {
  if (!dateStr) return null;
  
  // Try standard ISO/Date parsing first (e.g. YYYY-MM-DD, YYYY/MM/DD)
  let parsed = new Date(dateStr);
  if (!isNaN(parsed.getTime())) {
    return parsed;
  }

  // Handle formats: DD-MM-YYYY, DD/MM/YYYY, DD-MM-YY, DD/MM/YY
  const parts = dateStr.split(/[-/]/);
  if (parts.length === 3) {
    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1; // JS Date months are 0-indexed (0 = Jan, 11 = Dec)
    let year = parseInt(parts[2], 10);
    
    // Handle 2-digit years
    if (year < 100) {
      year += 2000;
    }
    
    if (!isNaN(day) && !isNaN(month) && !isNaN(year)) {
      parsed = new Date(year, month, day);
      if (!isNaN(parsed.getTime())) {
        return parsed;
      }
    }
  }

  return null;
}

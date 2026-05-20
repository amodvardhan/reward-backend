// src/controllers/cropAdvisoryController.js
const CropAdvisory = require('../models/cropAdvisory');
const ApiResponse = require('../utils/ApiResponse');

exports.getCropAdvisory = async (req, res) => {
  console.log(`[${new Date().toISOString()}] CropAdvisory API request started: ${req.method} ${req.url}`);
  try {
    const { crop, mobileNo, showing_date, sowing_period, sowing_period_unit, trg_code, hobli_code, hobli, region, prevRainfall, nextRainfall } = req.query;

    // Validate required parameters
    if (!crop || !trg_code || !hobli_code || !hobli || !region) {
      console.log(`[${new Date().toISOString()}] CropAdvisory validation failed: missing parameters`);
      return ApiResponse.error(res, 400, 'Missing required parameters: crop, trg_code, hobli_code, hobli, region');
    }

    // Validate that either showing_date or sowing_period/sowing_period_unit is provided
    if (!showing_date && (!sowing_period || !sowing_period_unit)) {
      console.log(`[${new Date().toISOString()}] CropAdvisory validation failed: need either showing_date or sowing_period and sowing_period_unit`);
      return ApiResponse.error(res, 400, 'Need either showing_date or both sowing_period and sowing_period_unit');
    }

    console.log(`[${new Date().toISOString()}] CropAdvisory API called with params:`, { crop, mobileNo, showing_date, sowing_period, sowing_period_unit, trg_code, hobli_code, hobli, region, prevRainfall, nextRainfall });

    console.log(`[${new Date().toISOString()}] Calling CropAdvisory.getAdvisory`);
    const result = await CropAdvisory.getAdvisory({ crop, mobileNo, showing_date, sowing_period, sowing_period_unit, trg_code, hobli_code, hobli, region, prevRainfall, nextRainfall });
    console.log(`[${new Date().toISOString()}] CropAdvisory result received:`, JSON.stringify(result, null, 2));

    if (result.error) {
      console.log(`[${new Date().toISOString()}] Advisory not available, sending 404 response`);
      return ApiResponse.error(res, 404, 'Crop advisory not available', { error: result.error });
    }

    console.log(`[${new Date().toISOString()}] Sending success response for CropAdvisory`);
    return ApiResponse.ok(res, 'Crop advisory retrieved successfully', result);
  } catch (error) {
    console.log(`[${new Date().toISOString()}] Error in getCropAdvisory:`, error.message);
    console.error('Full error details:', error);

    // Check if it's a "not found" error
    if (error.message.includes('not found') || error.message.includes('Crop not found') || error.message.includes('Advisory not found')) {
      console.log(`[${new Date().toISOString()}] Advisory not found, sending 404 response`);
      return ApiResponse.error(res, 404, 'Crop advisory not available', { error: error.message });
    }

    // For other errors, return 500
    console.log(`[${new Date().toISOString()}] Other error occurred, sending 500 response`);
    return ApiResponse.error(res, 500, 'Failed to retrieve crop advisory', { error: error.message });
  }
};
const RainForecast = require('../models/rainForecast');
const ApiResponse = require('../utils/ApiResponse');


exports.getSevenDayForecast = async (req, res) => {
  try {
    const { trgCode } = req.params;
    if (!trgCode) {
      return ApiResponse.error(res, 400, 'TRG code is required.');
    }

    // Fetch future data
    const futureRain = await RainForecast.getFutureForecast(trgCode, 3);  // next 3 days

    const mergedData = futureRain;

    return ApiResponse.ok(res, '7-day rainfall data retrieved successfully', mergedData);
  } catch (err) {
    console.error('Error in getSevenDayForecast:', err);
    return ApiResponse.error(res, 500, 'Failed to retrieve rainfall data', { error: err.message });
  }
};

exports.getTodayForecast = async (req, res) => {
  try {
    const { trgCode } = req.params;
    if (!trgCode) {
      return ApiResponse.error(res, 400, 'TRG code is required.');
    }

    const todayForecast = await RainForecast.getTodayForecast(trgCode);

    return ApiResponse.ok(res, 'Today\'s forecast data retrieved successfully', todayForecast);
  } catch (err) {
    console.error('Error in getTodayForecast:', err);
    return ApiResponse.error(res, 500, 'Failed to retrieve today\'s forecast data', { error: err.message });
  }
};

exports.getInstantWeatherInfo = async(req,res) => {
  try {
    const {mobileno} = req.params;
    if(!mobileno){
      return ApiResponse.error(res, 400, 'mobile number is required');
    }
    const hobliCode = await RainForecast.getInstantWeatherInfo(mobileno);

    return ApiResponse.ok(res, 'Weather Info retrieved ', hobliCode);

  } catch (err) {
    console.error('Error in GettingHobliCode',err);
    return ApiResponse.error(res, 500, 'Failed to retrieve the weatherinfo',{error: err.message});
  }
};

exports.get24HourWeather = async (req, res) => {
  try {
    const { trgCode } = req.params;
    if (!trgCode) {
      return ApiResponse.error(res, 400, 'TRG code is required.');
    }

    const weatherData = await RainForecast.get24HourWeather(trgCode);

    return ApiResponse.ok(res, '24-hour weather data retrieved successfully', weatherData);
  } catch (err) {
    console.error('Error in get24HourWeather:', err);
    return ApiResponse.error(res, 500, 'Failed to retrieve 24-hour weather data', { error: err.message });
  }
};
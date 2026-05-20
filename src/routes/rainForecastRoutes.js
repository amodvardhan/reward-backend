const express = require('express');
const router = express.Router();
const rainForecastController = require('../controllers/rainForecastController');

// GET /api/rain-forecast/today/:trgCode
router.get('/today/:trgCode', rainForecastController.getTodayForecast);

// GET /api/rain-forecast/24hour/:trgCode
router.get('/24hour/:trgCode', rainForecastController.get24HourWeather);

router.get('/getInstantWeatherInfo/:mobileno',rainForecastController.getInstantWeatherInfo);

// GET /api/rain-forecast/:trgCode
router.get('/:trgCode', rainForecastController.getSevenDayForecast);

module.exports = router;
// src/routes/cropAdvisoryRoutes.js
const express = require('express');
const router = express.Router();
// const cropAdvisoryController = require('../controllers/cropAdvisoryController');
const contingencyCropPlanController = require('../controllers/contingencyCropPlanController');

// router.get('/crop_advisory', cropAdvisoryController.getCropAdvisory);
router.get('/', contingencyCropPlanController.getContingencyCropPlan);
router.get('/period_info', contingencyCropPlanController.getCropPeriodInfo);

module.exports = router; 
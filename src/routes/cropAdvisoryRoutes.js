// src/routes/cropAdvisoryRoutes.js
const express = require('express');
const router = express.Router();
// const cropAdvisoryController = require('../controllers/cropAdvisoryController');
const contingencyCropPlanController = require('../controllers/contingencyCropPlanController');

// router.get('/crop_advisory', cropAdvisoryController.getCropAdvisory);
router.get('/crop_advisory', contingencyCropPlanController.getContingencyCropPlan);

module.exports = router; 
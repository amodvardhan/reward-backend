const express = require('express');
const router = express.Router();
const rewardFarmerDetailsController = require('../controllers/rewardFarmerDetailsController');

// Reward Farmer Details routes
router.get('/:mobileNo', rewardFarmerDetailsController.getFarmerDetailsByMobileNo);
router.post('/register-referral', rewardFarmerDetailsController.registerReferralFarmer);
router.post('/submit-feedback', rewardFarmerDetailsController.submitFeedback);
router.post('/submit-crop-practice', rewardFarmerDetailsController.submitCropPractice);
router.get('/crop-practices/all', rewardFarmerDetailsController.getAllCropPractices);
router.get('/crop-practices/:cropName', rewardFarmerDetailsController.getCropPracticeByName);
router.get('/crop-images/:filename', rewardFarmerDetailsController.getCropImage);
router.get('/fetch-lri-information/:mobileNo', rewardFarmerDetailsController.fetchLriInformation);

module.exports = router;
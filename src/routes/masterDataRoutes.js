const express = require('express');
const router = express.Router();
const masterDataController = require('../controllers/masterDataController');

// Master data routes
router.get('/districts', masterDataController.getDistricts);
router.get('/taluks', masterDataController.getTaluks);
router.get('/hoblis', masterDataController.getHoblis);
router.get('/gps', masterDataController.getGPs);
router.get('/crops', masterDataController.getCrops);
router.get('/crop-master', masterDataController.getCropMaster);
router.get('/farmer-location-details', masterDataController.getFarmerLocationDetails);
router.get('/hobli-translation', masterDataController.getHobliTranslation);
router.get('/villages', masterDataController.getVillages);
router.post('/update-farmer-crop', masterDataController.updateFarmerCrop);
router.post('/register-customer', masterDataController.registerCustomer);

module.exports = router;
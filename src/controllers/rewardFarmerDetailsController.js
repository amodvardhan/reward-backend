const RewardFarmerDetails = require('../models/rewardFarmerDetails');
const ApiResponse = require('../utils/ApiResponse');
const axios = require('axios');

exports.getFarmerDetailsByMobileNo = async (req, res) => {
    try {
        const farmerDetails = await RewardFarmerDetails.findByMobileNo(req.params.mobileNo);
        if (!farmerDetails) {
            return ApiResponse.error(res,500, 'No farmer details found for this mobile number', "");
        }
        return ApiResponse.ok(res, 'Farmer details retrieved successfully', farmerDetails);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve farmer details', { error: err.message });
    }
};

exports.registerReferralFarmer = async (req, res) => {
    try {
        const {
            district,
            districtCode,
            taluk,
            talukCode,
            hobli,
            hobliCode,
            gp,
            gpCode,
            fullName,
            mobileNumber,
            cropName,
            cropId,
            sowingDate
        } = req.body;

        // Validate required fields
        if (!district || !districtCode || !taluk || !talukCode || !hobli || !hobliCode ||
            !gp || !gpCode || !fullName || !mobileNumber || !cropName || !cropId || !sowingDate) {
            return ApiResponse.error(res, 400, 'All fields are required', null);
        }

        const result = await RewardFarmerDetails.insertReferralFarmer({
            district,
            districtCode,
            taluk,
            talukCode,
            hobli,
            hobliCode,
            gp,
            gpCode,
            fullName,
            mobileNumber,
            cropName,
            cropId,
            sowingDate
        });

        return ApiResponse.ok(res, 'Referral farmer registered successfully', result);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to register referral farmer', { error: err.message });
    }
};

exports.submitFeedback = async (req, res) => {
    try {
        console.log('Received feedback submission request:', req.body);

        const {
            farmerName,
            mobileNo,
            weatherForecast,
            agricultureAdvice,
            sowingVariety,
            smsUnderstandable,
            yieldImprovement,
            calledVarnamitra,
            formingPractices,
            cropOperations,
            fertilizerUsage,
            varietySelection,
            cropAdvisory,
            irrigationAdvice,
            harvestAdvice,
            pestDiseases,
            integratedPestDiseaseAdvice,
            opinionComments
        } = req.body;

        // Validate required fields
        if (!farmerName || !mobileNo) {
            console.log('Validation failed: farmerName or mobileNo missing');
            return ApiResponse.error(res, 400, 'Farmer name and mobile number are required', null);
        }

        console.log('Validation passed, calling insertFeedback');

        const result = await RewardFarmerDetails.insertFeedback({
            farmerName,
            mobileNo,
            weatherForecast,
            agricultureAdvice,
            sowingVariety,
            smsUnderstandable,
            yieldImprovement,
            calledVarnamitra,
            formingPractices,
            cropOperations,
            fertilizerUsage,
            varietySelection,
            cropAdvisory,
            irrigationAdvice,
            harvestAdvice,
            pestDiseases,
            integratedPestDiseaseAdvice,
            opinionComments
        });

        console.log('Feedback insertion result:', result);
        return ApiResponse.ok(res, 'Feedback submitted successfully', result);
    } catch (err) {
        console.log('Error in submitFeedback:', err);
        return ApiResponse.error(res, 500, 'Failed to submit feedback', { error: err.message });
    }
};

exports.submitCropPractice = async (req, res) => {
    try {
        console.log('Received crop practice submission request');
        console.log('Request body keys:', Object.keys(req.body));

        const {
            cropName,
            cropId,
            cropImage,
            practices
        } = req.body;

        // Validate required fields
        if (!cropName || !cropId || !cropImage) {
            console.log('Validation failed: cropName, cropId, or cropImage missing');
            console.log('cropName:', cropName, 'cropId:', cropId, 'cropImage length:', cropImage ? cropImage.length : 'null');
            return ApiResponse.error(res, 400, 'Crop name, crop ID, and crop image are required', null);
        }

        console.log('Validation passed, calling insertCropPractice');
        console.log('Image data length:', cropImage.length);

        const result = await RewardFarmerDetails.insertCropPractice({
            cropName,
            cropId,
            practices,
            cropImage
        });

        console.log('Crop practice insertion result:', result);
        return ApiResponse.ok(res, 'Crop practice submitted successfully', result);
    } catch (err) {
        console.log('Error in submitCropPractice:', err);
        console.log('Error stack:', err.stack);
        return ApiResponse.error(res, 500, 'Failed to submit crop practice', { error: err.message });
    }
};

exports.getAllCropPractices = async (req, res) => {
    try {
        console.log('Fetching all crop practices');
        const result = await RewardFarmerDetails.getAllCropPractices();
        return ApiResponse.ok(res, 'Crop practices fetched successfully', result);
    } catch (err) {
        console.log('Error in getAllCropPractices:', err);
        return ApiResponse.error(res, 500, 'Failed to fetch crop practices', { error: err.message });
    }
};

exports.getCropPracticeByName = async (req, res) => {
    try {
        const { cropName } = req.params;
        console.log('Fetching crop practice by name:', cropName);

        if (!cropName) {
            return ApiResponse.error(res, 400, 'Crop name is required', null);
        }

        const result = await RewardFarmerDetails.getCropPracticeByName(cropName);

        if (result) {
            return ApiResponse.ok(res, 'Crop practice fetched successfully', result);
        } else {
            return ApiResponse.error(res, 404, 'Crop practice not found', null);
        }
    } catch (err) {
        console.log('Error in getCropPracticeByName:', err);
        return ApiResponse.error(res, 500, 'Failed to fetch crop practice', { error: err.message });
    }
};

// Serve crop images
exports.getCropImage = async (req, res) => {
    try {
        const { filename } = req.params;
        const path = require('path');
        const fs = require('fs');

        const imagePath = path.join(__dirname, '../../uploads/crop-images', filename);

        if (fs.existsSync(imagePath)) {
            res.sendFile(imagePath);
        } else {
            res.status(404).json({
                status: 'error',
                message: 'Image not found'
            });
        }
    } catch (error) {
        console.error('Error serving image:', error);
        res.status(500).json({
            status: 'error',
            message: 'Failed to serve image'
        });
    }
};

exports.fetchLriInformation = async (req, res) => {
    try {
        const { mobileNo } = req.params;

        if (!mobileNo) {
            return ApiResponse.error(res, 400, 'Mobile number is required', null);
        }

        // Get farmer details
        const farmerDetails = await RewardFarmerDetails.findByMobileNo(mobileNo);
        if (!farmerDetails || farmerDetails.length === 0) {
            return ApiResponse.error(res, 404, 'Farmer details not found', null);
        }

        const farmer = farmerDetails[0]; // Assuming one record per mobile

        // Extract required fields
        const { VILLAGE_CODE, SURVEY_NO } = farmer;

        if (!VILLAGE_CODE || !SURVEY_NO) {
            return ApiResponse.error(res, 400, 'Incomplete farmer location data', null);
        }

        // Parse village code to extract hierarchical codes
        // Assuming VILLAGE_CODE format: DDTTTHHHHVVVVV (District-Taluk-Hobli-Village)
        const districtCode = VILLAGE_CODE.substring(0, 2);
        const talukCode = VILLAGE_CODE.substring(0, 4);
        const hobliCode = VILLAGE_CODE.substring(0, 6);
        const villageCode = VILLAGE_CODE;

        // Parse survey number and hissa number from SURVEY_NO format: "survey/ * /hissa"
        const surveyRegex = /^(\d+)\/\s*\*\s*\/([A-Za-z0-9]+)/;
        const match = SURVEY_NO.match(surveyRegex);

        let surveyNumber, hissaNumber;
        if (match) {
            surveyNumber = match[1].trim();
            hissaNumber = match[2].trim();
        } else {
            // Fallback to old parsing if regex doesn't match
            surveyNumber = SURVEY_NO.split('/')[0].trim();
            hissaNumber = "1";
        }

        // Prepare request body for external API
        const requestBody = {
            DistrictCode: districtCode,
            TalukCode: talukCode,
            HobliCode: hobliCode,
            VillageCode: villageCode,
            SurveyNumber: surveyNumber,
            HissaNo: hissaNumber
        };

        console.log('Sending request to external LRI API:', requestBody);

        // Call external API
        const externalApiUrl = 'https://kgis.ksrsac.in/LRIFarmerData/api/getFarmerLandData';
        const response = await axios.post(externalApiUrl, requestBody, {
            headers: {
                'Content-Type': 'application/json'
            }
        });

        // Filter farmerSoilProperties to match the farmer's name
        const farmerName = farmer.FARMER_NAME || '';
        let filteredSoilProperties = response.data.farmerSoilProperties || [];

        if (filteredSoilProperties.length > 0 && farmerName) {
            // Extract key identifier (first word) from farmer name for matching
            const farmerKey = farmerName.trim().split(' ')[0].replace(/[-.]/g, '').trim();

            // Filter properties where the response name contains the farmer's key identifier
            const matchingProperties = filteredSoilProperties.filter(prop => {
                if (!prop.Name) return false;
                const responseName = prop.Name.trim();
                return responseName.includes(farmerKey);
            });

            if (matchingProperties.length > 0) {
                filteredSoilProperties = matchingProperties;
            }
            // If no matches, keep all (fallback)
        }

        // Return filtered response data
        const filteredResponse = {
            ...response.data,
            farmerSoilProperties: filteredSoilProperties
        };

        return ApiResponse.ok(res, 'LRI information fetched successfully', filteredResponse);

    } catch (error) {
        console.error('Error fetching LRI information:', error);
        if (error.response) {
            // External API error
            return ApiResponse.error(res, error.response.status, 'External API error', error.response.data);
        } else {
            // Internal error
            return ApiResponse.error(res, 500, 'Failed to fetch LRI information', { error: error.message });
        }
    }
};
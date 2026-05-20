const oracledb = require('oracledb');
const { getConnection, closeConnection } = require('../config/database');

class RewardFarmerDetails {
    static async findByMobileNo(mobileNo) {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                'SELECT * FROM KSNDMC.REWARD_FARMER_DETAILS WHERE MOBILE_NO = :mobileNo',
                [mobileNo],
                { outFormat: oracledb.OUT_FORMAT_OBJECT }
            );
            // For each row, if CROP_ID is null or blank, fetch from REWARD_CROP_MASTER using CROP_NAME
            for (const row of result.rows) {
                if (!row.CROP_ID || row.CROP_ID === '' || row.CROP_ID === null) {
                    const cropResult = await connection.execute(
                        'SELECT CROP_ID FROM KSNDMC.REWARD_CROP_MASTER WHERE CROP_NAME = :cropName',
                        [row.CROP_NAME],
                        { outFormat: oracledb.OUT_FORMAT_OBJECT }
                    );
                    if (cropResult.rows.length > 0) {
                        row.CROP_ID = cropResult.rows[0].CROP_ID;
                    }
                }
                // Fetch REWARD_REGION from REWARD_REGION_MASTER using DISTRICTCODE
                if (row.DISTRICTCODE) {
                    const regionResult = await connection.execute(
                        'SELECT REWARD_REGION FROM KSNDMC.REWARD_REGION_MASTER WHERE DISTRICTCODE = :districtCode',
                        [row.DISTRICTCODE],
                        { outFormat: oracledb.OUT_FORMAT_OBJECT }
                    );
                    if (regionResult.rows.length > 0) {
                        row.REWARD_REGION = regionResult.rows[0].REWARD_REGION;
                    } else {
                        row.REWARD_REGION = null;
                    }
                    // Temporary fix: Override region for district 09 to 1.SIK
                    if (row.DISTRICTCODE === '09') {
                        row.REWARD_REGION = '1.SIK';
                    }
                } else {
                    row.REWARD_REGION = null;
                }
            }

            return result.rows;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async insertReferralFarmer(data) {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                `INSERT INTO KSNDMC.REFFERAL_FARMER_REGISTRATION_SMS (
                    DISTRICT,
                    DISTRICT_CODE,
                    TALUK,
                    TALUK_CODE,
                    HOBLI,
                    HOBLI_CODE,
                    GP,
                    GP_CODE,
                    FULL_NAME,
                    MOBILE_NUMBER,
                    CROP_NAME,
                    CROP_ID,
                    SOWING_DATE
                ) VALUES (
                    :district,
                    :districtCode,
                    :taluk,
                    :talukCode,
                    :hobli,
                    :hobliCode,
                    :gp,
                    :gpCode,
                    :fullName,
                    :mobileNumber,
                    :cropName,
                    :cropId,
                    TO_DATE(:sowingDate, 'DD/MM/YYYY')
                )`,
                {
                    district: data.district,
                    districtCode: data.districtCode,
                    taluk: data.taluk,
                    talukCode: data.talukCode,
                    hobli: data.hobli,
                    hobliCode: data.hobliCode,
                    gp: data.gp,
                    gpCode: data.gpCode,
                    fullName: data.fullName,
                    mobileNumber: data.mobileNumber,
                    cropName: data.cropName,
                    cropId: data.cropId,
                    sowingDate: data.sowingDate
                },
                { autoCommit: true }
            );

            return { success: true, rowsAffected: result.rowsAffected };
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async insertFeedback(data) {
        let connection;
        try {
            console.log('Inserting feedback data:', data);
            connection = await getConnection();
            console.log('Database connection established');

            const result = await connection.execute(
                `INSERT INTO KSNDMC.FEEDBACK (
                    FARMER_NAME,
                    MOBILE_NO,
                    WEATHER_FORECAST,
                    AGRICULTURE_ADVICE,
                    SOWING_VARIETY,
                    SMS_UNDERSTANDABLE,
                    YIELD_IMPROVEMENT,
                    CALLED_VARNAMITRA,
                    FORMING_PRACTICES,
                    CROP_OPERATIONS,
                    FERTILIZER_USAGE,
                    VARIETY_SELECTION,
                    CROP_ADVISORY,
                    IRRIGATION_ADVICE,
                    HARVEST_ADVICE,
                    PEST_DISEASES,
                    INTEGRATED_PEST_DISEASE_ADVICE,
                    OPINION_COMMENTS,
                    CREATEDDATE
                ) VALUES (
                    :farmerName,
                    :mobileNo,
                    :weatherForecast,
                    :agricultureAdvice,
                    :sowingVariety,
                    :smsUnderstandable,
                    :yieldImprovement,
                    :calledVarnamitra,
                    :formingPractices,
                    :cropOperations,
                    :fertilizerUsage,
                    :varietySelection,
                    :cropAdvisory,
                    :irrigationAdvice,
                    :harvestAdvice,
                    :pestDiseases,
                    :integratedPestDiseaseAdvice,
                    :opinionComments,
                    SYSDATE
                )`,
                {
                    farmerName: data.farmerName,
                    mobileNo: data.mobileNo,
                    weatherForecast: data.weatherForecast,
                    agricultureAdvice: data.agricultureAdvice,
                    sowingVariety: data.sowingVariety,
                    smsUnderstandable: data.smsUnderstandable,
                    yieldImprovement: data.yieldImprovement,
                    calledVarnamitra: data.calledVarnamitra,
                    formingPractices: data.formingPractices,
                    cropOperations: data.cropOperations,
                    fertilizerUsage: data.fertilizerUsage,
                    varietySelection: data.varietySelection,
                    cropAdvisory: data.cropAdvisory,
                    irrigationAdvice: data.irrigationAdvice,
                    harvestAdvice: data.harvestAdvice,
                    pestDiseases: data.pestDiseases,
                    integratedPestDiseaseAdvice: data.integratedPestDiseaseAdvice,
                    opinionComments: data.opinionComments || null
                },
                { autoCommit: true }
            );

            console.log('Feedback insertion successful, rows affected:', result.rowsAffected);
            return { success: true, rowsAffected: result.rowsAffected };
        } catch (error) {
            console.log('Error in insertFeedback:', error);
            throw error;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async insertCropPractice(data) {
        let connection;
        try {
            console.log('Inserting crop practice data:', data.cropName, data.cropId);
            connection = await getConnection();
            console.log('Database connection established');

            // Convert base64 to buffer for BLOB storage
            const imageBuffer = Buffer.from(data.cropImage, 'base64');
            console.log('Image buffer length:', imageBuffer.length);

            const result = await connection.execute(
                `INSERT INTO KSNDMC.CROP_PRACTICES (
                    CROP_NAME,
                    CROP_ID,
                    PRACTICES,
                    CROP_IMAGE
                ) VALUES (
                    :cropName,
                    :cropId,
                    :practices,
                    :cropImage
                )`,
                {
                    cropName: data.cropName,
                    cropId: data.cropId,
                    practices: data.practices || null,
                    cropImage: imageBuffer
                },
                { autoCommit: true }
            );

            console.log('Crop practice insertion successful, rows affected:', result.rowsAffected);
            return { success: true, rowsAffected: result.rowsAffected };
        } catch (error) {
            console.log('Error in insertCropPractice:', error);
            throw error;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async getAllCropPractices() {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                'SELECT CROP_NAME, CROP_ID, PRACTICES FROM KSNDMC.CROP_PRACTICES ORDER BY CROP_NAME',
                [],
                { outFormat: oracledb.OUT_FORMAT_OBJECT }
            );

            // Handle CLOB PRACTICES field for all rows
            for (const row of result.rows) {
                if (row.PRACTICES) {
                    if (typeof row.PRACTICES === 'string') {
                        // Already a string, use as is
                        console.log('PRACTICES is already a string for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                    } else if (typeof row.PRACTICES === 'object' && row.PRACTICES.constructor && row.PRACTICES.constructor.name === 'Lob') {
                        console.log('Oracle CLOB object detected for PRACTICES in getAllCropPractices, attempting to read as stream');
                        try {
                            const chunks = [];
                            const stream = row.PRACTICES;

                            await new Promise((resolve, reject) => {
                                stream.on('data', (chunk) => {
                                    chunks.push(chunk);
                                });
                                stream.on('end', () => {
                                    const buffer = Buffer.concat(chunks);
                                    row.PRACTICES = buffer.toString('utf8');
                                    console.log('CLOB converted to string for', row.CROP_NAME, ', length:', row.PRACTICES.length, ', value:', row.PRACTICES.substring(0, 50));
                                    resolve();
                                });
                                stream.on('error', (err) => {
                                    console.log('CLOB stream error for', row.CROP_NAME, ':', err);
                                    reject(err);
                                });
                            });
                        } catch (lobError) {
                            console.log('Failed to read CLOB stream for', row.CROP_NAME, ':', lobError);
                            // Try alternative method - direct access
                            try {
                                if (row.PRACTICES && typeof row.PRACTICES.toString === 'function') {
                                    row.PRACTICES = row.PRACTICES.toString();
                                    console.log('CLOB converted using toString for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                                } else {
                                    row.PRACTICES = null;
                                }
                            } catch (altError) {
                                console.log('Failed alternative CLOB conversion for', row.CROP_NAME, ':', altError);
                                row.PRACTICES = null;
                            }
                        }
                    } else {
                        console.log('PRACTICES is of unknown type for', row.CROP_NAME, ':', typeof row.PRACTICES, 'constructor:', row.PRACTICES?.constructor?.name);
                        // Try to convert to string if possible
                        try {
                            row.PRACTICES = String(row.PRACTICES);
                            console.log('Converted PRACTICES to string for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                        } catch (convertError) {
                            console.log('Failed to convert PRACTICES to string for', row.CROP_NAME, ':', convertError);
                            row.PRACTICES = null;
                        }
                    }
                } else {
                    console.log('PRACTICES is null or undefined for', row.CROP_NAME);
                }
            }

            return result.rows;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async getCropPracticeByName(cropName) {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                'SELECT CROP_NAME, CROP_ID, CROP_IMAGE, PRACTICES FROM KSNDMC.CROP_PRACTICES WHERE CROP_NAME = :cropName',
                [cropName],
                { outFormat: oracledb.OUT_FORMAT_OBJECT }
            );

            if (result.rows.length > 0) {
                const row = result.rows[0];
                console.log('Row data after query:', row);
                console.log('PRACTICES type:', typeof row.PRACTICES, 'value:', row.PRACTICES);
                // Convert BLOB to base64 if it exists
                if (row.CROP_IMAGE) {
                    console.log('Converting BLOB to base64, type:', typeof row.CROP_IMAGE, 'length:', row.CROP_IMAGE.length);
                    console.log('BLOB data type details:', Object.prototype.toString.call(row.CROP_IMAGE));

                    // For Oracle BLOB, we need to handle it differently
                    let buffer;
                    try {
                        if (Buffer.isBuffer(row.CROP_IMAGE)) {
                            console.log('Already a Buffer');
                            buffer = row.CROP_IMAGE;
                        } else if (row.CROP_IMAGE instanceof Uint8Array) {
                            console.log('Converting from Uint8Array');
                            buffer = Buffer.from(row.CROP_IMAGE);
                        } else if (typeof row.CROP_IMAGE === 'object' && row.CROP_IMAGE !== null) {
                            // Oracle BLOB might be returned as an object
                            console.log('Oracle BLOB object, trying different approaches');

                            // Try to get the buffer from the object
                            if (row.CROP_IMAGE.buffer) {
                                console.log('Using .buffer property');
                                buffer = Buffer.from(row.CROP_IMAGE.buffer);
                            } else if (row.CROP_IMAGE.data) {
                                console.log('Using .data property');
                                buffer = Buffer.from(row.CROP_IMAGE.data);
                            } else if (row.CROP_IMAGE.constructor && row.CROP_IMAGE.constructor.name === 'Lob') {
                                // Oracle LOB object - try to read it as stream
                                console.log('Oracle LOB object detected, attempting to read as stream');
                                try {
                                    // Read the LOB data
                                    const chunks = [];
                                    const stream = row.CROP_IMAGE;

                                    // Wait for the stream to be readable
                                    await new Promise((resolve, reject) => {
                                        stream.on('data', (chunk) => {
                                            chunks.push(chunk);
                                        });
                                        stream.on('end', () => {
                                            const buffer = Buffer.concat(chunks);
                                            row.PRACTICES = buffer.toString('utf8');
                                            console.log('CLOB converted to string, length:', row.PRACTICES.length, ', value:', row.PRACTICES.substring(0, 50));
                                            resolve();
                                        });
                                        stream.on('error', (err) => {
                                            console.log('CLOB stream error:', err);
                                            reject(err);
                                        });
                                    });
                                } catch (lobError) {
                                    console.log('Failed to read LOB stream:', lobError);
                                    row.CROP_IMAGE = null;
                                }
                                return row;
                            } else {
                                console.log('Unknown object structure, available properties:', Object.keys(row.CROP_IMAGE));
                                // Don't try to convert unknown objects
                                row.CROP_IMAGE = null;
                                return row;
                            }
                        } else {
                            console.log('Unknown type, trying binary conversion');
                            buffer = Buffer.from(row.CROP_IMAGE, 'binary');
                        }

                        if (buffer) {
                            console.log('Buffer created, length:', buffer.length);
                            console.log('First 20 bytes of buffer:', buffer.slice(0, 20));

                            row.CROP_IMAGE = buffer.toString('base64');
                            console.log('Base64 conversion result length:', row.CROP_IMAGE.length);
                            console.log('First 100 chars of base64:', row.CROP_IMAGE.substring(0, 100));
                        }
                    } catch (error) {
                        console.log('Error converting BLOB to base64:', error);
                        row.CROP_IMAGE = null; // Set to null so frontend can handle it
                    }
                }

                // Handle CLOB PRACTICES field
                console.log('Before PRACTICES handling, row.PRACTICES:', row.PRACTICES);
                if (row.PRACTICES) {
                    if (typeof row.PRACTICES === 'string') {
                        // Already a string, use as is
                        console.log('PRACTICES is already a string for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                    } else if (typeof row.PRACTICES === 'object' && row.PRACTICES.constructor && row.PRACTICES.constructor.name === 'Lob') {
                        console.log('Oracle CLOB object detected for PRACTICES, attempting to read using getData');
                        try {
                            const data = await row.PRACTICES.getData();
                            row.PRACTICES = data.toString('utf8');
                            console.log('CLOB converted to string for', row.CROP_NAME, ', length:', row.PRACTICES.length, ', value:', row.PRACTICES.substring(0, 50));
                        } catch (lobError) {
                            console.log('Failed to read CLOB using getData for', row.CROP_NAME, ':', lobError);
                            // Try alternative method - direct access
                            try {
                                if (row.PRACTICES && typeof row.PRACTICES.toString === 'function') {
                                    row.PRACTICES = row.PRACTICES.toString();
                                    console.log('CLOB converted using toString for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                                } else {
                                    row.PRACTICES = null;
                                }
                            } catch (altError) {
                                console.log('Failed alternative CLOB conversion for', row.CROP_NAME, ':', altError);
                                row.PRACTICES = null;
                            }
                        }
                    } else {
                        console.log('PRACTICES is of unknown type for', row.CROP_NAME, ':', typeof row.PRACTICES, 'constructor:', row.PRACTICES?.constructor?.name);
                        // Try to convert to string if possible
                        try {
                            row.PRACTICES = String(row.PRACTICES);
                            console.log('Converted PRACTICES to string for', row.CROP_NAME, ', value:', row.PRACTICES.substring(0, 50));
                        } catch (convertError) {
                            console.log('Failed to convert PRACTICES to string for', row.CROP_NAME, ':', convertError);
                            row.PRACTICES = null;
                        }
                    }
                } else {
                    console.log('PRACTICES is null or undefined for', row.CROP_NAME);
                }

                console.log('Final PRACTICES value for', row.CROP_NAME, ':', row.PRACTICES);
                return row;
            }
            return null;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }
}

module.exports = RewardFarmerDetails;
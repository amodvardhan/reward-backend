const oracledb = require('oracledb');
const { getConnection, closeConnection } = require('../config/database');
const ApiResponse = require('../utils/ApiResponse');

exports.registerCustomer = async (req, res) => {
    console.log('registerCustomer called with body:', req.body);
    let connection;
    try {
        connection = await getConnection();
        console.log('Database connection established');
        const { phone1, fname, districtCode, talukCode, hobliCode, gpCode, trgCode, districtName, talukName, hobliName, gpName, cropId, cropName, sowingDate, surveyNo, fruitsId, villageName, hissaNo } = req.body;
        console.log('Parsed request data:', { phone1, fname, districtCode, talukCode, hobliCode, gpCode, trgCode, districtName, talukName, hobliName, gpName, cropId, cropName, sowingDate, surveyNo, fruitsId, villageName, hissaNo });

        // Combine surveyNo and hissaNo if hissaNo is provided
        let combinedSurveyNo = surveyNo;
        if (hissaNo) {
            combinedSurveyNo = `${surveyNo}/*/${hissaNo}`;
        }

        // Get village code from village name
        let villageCode = null;
        if (villageName) {
            const villageSql = `SELECT KGIS_VILLAGE_CODE FROM KSNDMC.KSRSAC_VILLAGE_MASTER WHERE KGIS_VILLAGE_NAME = :villageName`;
            const villageResult = await connection.execute(villageSql, { villageName }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (villageResult.rows.length > 0) {
                villageCode = villageResult.rows[0].KGIS_VILLAGE_CODE;
                console.log('Village code found:', villageCode);
            } else {
                console.log('Village code not found for village:', villageName);
            }
        }

        // Check if mobile number already exists
        const checkSql = `SELECT COUNT(*) AS count FROM KSNDMC.REWARD_FARMER_DETAILS WHERE MOBILE_NO = :mobileNo`;
        console.log('Executing check SQL:', checkSql, 'with params:', { mobileNo: phone1 });
        const checkResult = await connection.execute(checkSql, { mobileNo: phone1 });
        const count = checkResult.rows[0][0];
        console.log('Existing user count:', count);

        if (count > 0) {
            console.log('User already exists, returning error');
            return ApiResponse.error(res, 400, 'Already Registered. Please Login');
        }

        const sql = `
            INSERT INTO KSNDMC.REWARD_FARMER_DETAILS (
                MOBILE_NO, FARMER_NAME, DISTRICTCODE, TALUKCODE, HOBLI_CODE, GPCODE, TRGCODE,
                DISTRICT, TALUK, HOBLINAME, GP_NAME,
                CROP_ID, CROP_NAME, SOWING_DATE, SURVEY_NO, FRUITS_ID,
                VILLAGE_NAME, VILLAGE_CODE,
                REWARD_FARMER_REGISTRATION_DATE, LAST_MODIFIED_DATE
            ) VALUES (
                :mobileNo, :farmerName, :districtCode, :talukCode, :hobliCode, :gpCode, :trgCode,
                :districtName, :talukName, :hobliName, :gpName,
                :cropId, :cropName, TO_DATE(:sowingDate, 'DD/MM/YYYY'), :surveyNo, :fruitsId,
                :villageName, :villageCode,
                SYSDATE, SYSDATE
            )
        `;
        console.log('Executing INSERT SQL:', sql);
        const insertParams = {
            mobileNo: phone1,
            farmerName: fname,
            districtCode: districtCode,
            talukCode: talukCode,
            hobliCode: hobliCode,
            gpCode: gpCode,
            trgCode: trgCode,
            districtName: districtName || null,
            talukName: talukName || null,
            hobliName: hobliName || null,
            gpName: gpName || null,
            cropId: cropId || null,
            cropName: cropName || null,
            sowingDate: sowingDate || null,
            surveyNo: combinedSurveyNo || null,
            fruitsId: fruitsId || null,
            villageName: villageName || null,
            villageCode: villageCode || null
        };
        console.log('INSERT parameters:', insertParams);

        await connection.execute(sql, insertParams);
        console.log('INSERT executed successfully');

        await connection.commit();
        console.log('Transaction committed successfully');
        return ApiResponse.ok(res, 'Customer registered successfully');
    } catch (err) {
        console.log('Error in registerCustomer:', err);
        if (connection) {
            await connection.rollback();
            console.log('Transaction rolled back');
        }
        return ApiResponse.error(res, 500, 'Failed to register farmer', { error: err.message });
    } finally {
        if (connection) {
            await closeConnection(connection);
            console.log('Database connection closed');
        }
    }
};

exports.getDistricts = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { lang } = req.query;
        const sql = `SELECT DISTINCT DISTRICT AS name, DISTRICTCODE AS code FROM KSNDMC.DISTRICT_MASTER ORDER BY DISTRICT`;
        const result = await connection.execute(sql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });

        // Get Kannada translations
        let kannadaMap = new Map();
        try {
            const kannadaSql = `SELECT DISTINCT DISTRICT_EN, DISTRICT_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER`;
            const kannadaResult = await connection.execute(kannadaSql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
            kannadaMap = new Map(kannadaResult.rows.map(row => [row.DISTRICT_EN, row.DISTRICT_KN]));
        } catch (transErr) {
            console.warn('Kannada translation view MSTVW2_HOBLI_GP_MASTER not available. Falling back to English names.', transErr.message);
        }

        const districts = result.rows.map(row => {
            const districtEn = row.NAME;
            const districtKn = kannadaMap.get(row.NAME) || row.NAME;
            return {
                district_en: districtEn,
                district_kn: districtKn,
                code: row.CODE
            };
        });

        // Alphabetical sorting based on selected language
        const activeLang = lang || 'en';
        districts.sort((a, b) => {
            const nameA = activeLang === 'kn' ? a.district_kn : a.district_en;
            const nameB = activeLang === 'kn' ? b.district_kn : b.district_en;
            return nameA.localeCompare(nameB, activeLang === 'kn' ? 'kn' : 'en');
        });

        return ApiResponse.collection(res, 'Districts retrieved successfully', districts);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve districts', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getTaluks = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { districtCode, lang } = req.query;

        let sql = `SELECT DISTINCT TALUKNAME AS name, TALUKCODE AS code FROM KSNDMC.TALUK_MASTER`;
        let binds = [];

        if (districtCode) {
            sql += ' WHERE DISTRICTCODE = :districtCode';
            binds.push(districtCode);
        }

        sql += ` ORDER BY TALUKNAME`;

        const result = await connection.execute(
            sql,
            binds,
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // Get Kannada translations
        let kannadaMap = new Map();
        try {
            const kannadaSql = `SELECT DISTINCT TALUKNAME_EN, TALUKNAME_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER`;
            const kannadaResult = await connection.execute(kannadaSql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
            kannadaMap = new Map(kannadaResult.rows.map(row => [row.TALUKNAME_EN, row.TALUKNAME_KN]));
        } catch (transErr) {
            console.warn('Kannada translation view MSTVW2_HOBLI_GP_MASTER not available. Falling back to English names.', transErr.message);
        }

        const taluks = result.rows.map(row => {
            const talukEn = row.NAME;
            const talukKn = kannadaMap.get(row.NAME) || row.NAME;
            return {
                taluk_en: talukEn,
                taluk_kn: talukKn,
                code: row.CODE || row.NAME // fallback if no code
            };
        });

        // Alphabetical sorting based on selected language
        const activeLang = lang || 'en';
        taluks.sort((a, b) => {
            const nameA = activeLang === 'kn' ? a.taluk_kn : a.taluk_en;
            const nameB = activeLang === 'kn' ? b.taluk_kn : b.taluk_en;
            return nameA.localeCompare(nameB, activeLang === 'kn' ? 'kn' : 'en');
        });

        return ApiResponse.collection(res, 'Taluks retrieved successfully', taluks);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve taluks', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getHoblis = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { districtCode, talukCode, lang } = req.query;

        let sql = `SELECT DISTINCT HOBLINAME AS name, HOBLICODE AS code FROM KSNDMC.HOBLI_MASTER WHERE LENGTH(HOBLICODE) <= 6`;
        let binds = [];

        if (districtCode) {
            sql += ' AND DISTRICTCODE = :districtCode';
            binds.push(districtCode);
        }

        if (talukCode) {
            sql += ' AND TALUKCODE = :talukCode';
            binds.push(talukCode);
        }

        sql += ` ORDER BY HOBLINAME`;

        const result = await connection.execute(
            sql,
            binds,
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // Get Kannada translations - try multiple approaches
        let kannadaMapByName = new Map();
        let kannadaMapByCode = new Map();
        try {
            const kannadaSql = `
                SELECT DISTINCT HOBLINAME_EN, HOBLINAME_KN, HOBLICODE
                FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER
                WHERE HOBLINAME_EN IS NOT NULL AND HOBLINAME_KN IS NOT NULL
            `;
            const kannadaResult = await connection.execute(kannadaSql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
            console.log('Kannada translations found:', kannadaResult.rows.length);
            kannadaMapByName = new Map(kannadaResult.rows.map(row => [row.HOBLINAME_EN, row.HOBLINAME_KN]));
            kannadaMapByCode = new Map(kannadaResult.rows.map(row => [row.HOBLICODE, row.HOBLINAME_KN]));
        } catch (transErr) {
            console.warn('Kannada translation view MSTVW2_HOBLI_GP_MASTER not available. Falling back to English names.', transErr.message);
        }

        const hoblis = result.rows.map(row => {
            const hobliEn = row.NAME;
            // Try to find Kannada translation by name first, then by code
            const hobliKn = kannadaMapByName.get(row.NAME) || kannadaMapByCode.get(row.CODE) || row.NAME;
            console.log(`Hobli: ${row.NAME} (${row.CODE}) -> KN: ${hobliKn}`);
            return {
                hobli_en: hobliEn,
                hobli_kn: hobliKn,
                code: row.CODE
            };
        });

        // Alphabetical sorting based on selected language
        const activeLang = lang || 'en';
        hoblis.sort((a, b) => {
            const nameA = activeLang === 'kn' ? a.hobli_kn : a.hobli_en;
            const nameB = activeLang === 'kn' ? b.hobli_kn : b.hobli_en;
            return nameA.localeCompare(nameB, activeLang === 'kn' ? 'kn' : 'en');
        });

        return ApiResponse.collection(res, 'Hoblis retrieved successfully', hoblis);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve hoblis', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getGPs = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { districtCode, talukCode, hobliCode, lang } = req.query;

        let sql = `SELECT DISTINCT HOBLINAME AS name, HOBLICODE AS code, TRGCODE AS trgCode FROM KSNDMC.HOBLI_MASTER WHERE LENGTH(HOBLICODE) > 6`;
        let binds = [];

        if (districtCode && talukCode && hobliCode) {
            const likePattern = `${hobliCode}__`;
            sql += ' AND HOBLICODE LIKE :likePattern';
            binds.push(likePattern);
        }

        sql += ` ORDER BY HOBLINAME`;

        const result = await connection.execute(
            sql,
            binds,
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // Get Kannada translations from MSTVW2_HOBLI_GP_MASTER
        // For GPs, we need to match by the GP name which is stored in HOBLINAME_EN column
        let kannadaMapByName = new Map();
        let kannadaMapByCode = new Map();
        try {
            const kannadaSql = `
                SELECT DISTINCT HOBLINAME_EN, HOBLINAME_KN, HOBLICODE
                FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER
                WHERE HOBLINAME_EN IS NOT NULL AND HOBLINAME_KN IS NOT NULL
            `;
            const kannadaResult = await connection.execute(kannadaSql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
            console.log('GP Kannada translations found:', kannadaResult.rows.length);
            kannadaMapByName = new Map(kannadaResult.rows.map(row => [row.HOBLINAME_EN, row.HOBLINAME_KN]));
            kannadaMapByCode = new Map(kannadaResult.rows.map(row => [row.HOBLICODE, row.HOBLINAME_KN]));
        } catch (transErr) {
            console.warn('Kannada translation view MSTVW2_HOBLI_GP_MASTER not available. Falling back to English names.', transErr.message);
        }

        const gps = result.rows.map(row => {
            const gpEn = row.NAME;
            // Try to find Kannada translation by name first, then by code
            const gpKn = kannadaMapByName.get(row.NAME) || kannadaMapByCode.get(row.CODE) || row.NAME;
            console.log(`GP: ${row.NAME} (${row.CODE}) -> KN: ${gpKn}`);
            return {
                gp_en: gpEn,
                gp_kn: gpKn,
                code: row.CODE,
                trgCode: row.TRGCODE
            };
        });

        // Alphabetical sorting based on selected language
        const activeLang = lang || 'en';
        gps.sort((a, b) => {
            const nameA = activeLang === 'kn' ? a.gp_kn : a.gp_en;
            const nameB = activeLang === 'kn' ? b.gp_kn : b.gp_en;
            return nameA.localeCompare(nameB, activeLang === 'kn' ? 'kn' : 'en');
        });

        return ApiResponse.collection(res, 'Gram Panchayats retrieved successfully', gps);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve gram panchayats', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getCrops = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { lang, mobileNo, region } = req.query;

        // Resolve farmer's region if mobileNo is provided
        let resolvedRegion = null;
        if (region) {
            resolvedRegion = region.trim();
        } else if (mobileNo) {
            const farmerSql = `SELECT DISTRICT FROM KSNDMC.REWARD_FARMER_DETAILS WHERE MOBILE_NO = :mobileNo`;
            const farmerRes = await connection.execute(farmerSql, { mobileNo }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (farmerRes.rows.length > 0) {
                const district = farmerRes.rows[0].DISTRICT;
                const regionSql = `SELECT REGION_CODE FROM KSNDMC.REWARD_REGION_MASTER WHERE UPPER(DISTRICT) = UPPER(:district) AND rownum <= 1`;
                const regionRes = await connection.execute(regionSql, { district }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
                if (regionRes.rows.length > 0) {
                    resolvedRegion = regionRes.rows[0].REGION_CODE;
                }
            }
        }

        // Fetch crops filtered by resolved region if present
        let sql = `SELECT DISTINCT CROP_NAME, CROP_NAME_KN, CROP_ID FROM KSNDMC.REWARD_CROP_MASTER`;
        const binds = {};
        if (resolvedRegion) {
            let cleanRegion = resolvedRegion.toUpperCase();
            if (cleanRegion.includes('SIK')) {
                cleanRegion = 'SIK';
            } else if (cleanRegion.includes('NIK')) {
                cleanRegion = 'NIK';
            }
            sql = `
                SELECT DISTINCT m.CROP_NAME, m.CROP_NAME_KN, m.CROP_ID 
                FROM KSNDMC.REWARD_CROP_MASTER m
                WHERE UPPER(m.REGION_CODE) LIKE '%' || :region || '%'
                  AND (
                      EXISTS (
                          SELECT 1 FROM KSNDMC.BLOCKING_PERIOD b
                          WHERE UPPER(b.REGION_CODE) LIKE '%' || :region || '%'
                            AND b.IS_ACTIVE = 'Y'
                            AND (
                                UPPER(b.CROP_NAME) = UPPER(m.CROP_NAME)
                                OR (UPPER(m.CROP_NAME) = 'RAGI' AND UPPER(b.CROP_NAME) = 'FINGER MILLET')
                                OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(b.CROP_NAME) = 'PADDY')
                                OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(b.CROP_NAME) = 'RICE (IR)')
                            )
                      )
                      OR
                      EXISTS (
                          SELECT 1 FROM KSNDMC.FIELD_CROPS_ADVISORY f
                          WHERE UPPER(f.REGION_CODE) LIKE '%' || :region || '%'
                            AND f.IS_ACTIVE = 'Y'
                            AND (
                                UPPER(f.CROP_NAME) = UPPER(m.CROP_NAME)
                                OR (UPPER(m.CROP_NAME) = 'RAGI' AND UPPER(f.CROP_NAME) = 'FINGER MILLET')
                                OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(f.CROP_NAME) = 'PADDY')
                                OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(f.CROP_NAME) = 'RICE')
                            )
                      )
                      OR
                      EXISTS (
                          SELECT 1 FROM KSNDMC.HORTI_WEEKS_CROPS_ADVISORY hw
                          WHERE (UPPER(hw.CROP_NAME) = UPPER(m.CROP_NAME) OR UPPER(hw.CROP_NAME) LIKE UPPER(m.CROP_NAME) || '%')
                            AND UPPER(hw.REGION_CODE) LIKE '%' || :region || '%'
                            AND hw.IS_ACTIVE = 'Y'
                      )
                      OR
                      EXISTS (
                          SELECT 1 FROM KSNDMC.HORTI_MONTHS_CROPS_ADVISORY hm
                          WHERE (UPPER(hm.CROP_NAME) = UPPER(m.CROP_NAME) OR UPPER(hm.CROP_NAME) LIKE UPPER(m.CROP_NAME) || '%')
                            AND UPPER(hm.REGION_CODE) LIKE '%' || :region || '%'
                            AND hm.IS_ACTIVE = 'Y'
                      )
                  )
            `;
            binds.region = cleanRegion;
        }

        sql += ` ORDER BY CROP_NAME`;

        const result = await connection.execute(sql, binds, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        const crops = result.rows.map(row => {
            const name = lang === 'kn' ? (row.CROP_NAME_KN || row.CROP_NAME) : row.CROP_NAME;
            return {
                name: name,
                id: row.CROP_ID
            };
        });

        // Alphabetical sorting based on active language
        const activeLang = lang || 'en';
        crops.sort((a, b) => a.name.localeCompare(b.name, activeLang === 'kn' ? 'kn' : 'en'));

        return ApiResponse.collection(res, 'Crops retrieved successfully', crops);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve crops', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getCropMaster = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();

        const regionCodeRaw = req.query.region_code || req.query.REGION_CODE;
        const cropTypeRaw = req.query.crop_type || req.query.CROP_TYPE;
        const lang = req.query.lang || req.query.LANG || 'en';

        let regionCode = null;
        if (regionCodeRaw) {
            const val = String(regionCodeRaw).trim();
            if (val && val.toLowerCase() !== 'null' && val.toLowerCase() !== 'undefined') {
                regionCode = val;
            }
        }

        let cropType = null;
        if (cropTypeRaw) {
            const val = String(cropTypeRaw).trim();
            if (val && val.toLowerCase() !== 'null' && val.toLowerCase() !== 'undefined') {
                cropType = val;
            }
        }

        let region = null;
        if (regionCode) {
            const cleanReg = regionCode.toUpperCase();
            if (cleanReg.includes('SIK')) {
                region = 'SIK';
            } else if (cleanReg.includes('NIK')) {
                region = 'NIK';
            }
        }

        let sql = `SELECT DISTINCT m.CROP_NAME_KN AS name, m.CROP_ID AS id, m.CROP_NAME AS english_name, m.REGION_CODE AS region_code, m.CROP_TYPE AS crop_type FROM KSNDMC.REWARD_CROP_MASTER m WHERE 1=1`;
        const binds = {};

        if (regionCode) {
            sql += ` AND UPPER(m.REGION_CODE) LIKE '%' || UPPER(:region_code) || '%'`;
            binds.region_code = regionCode;
        }

        if (cropType) {
            sql += ` AND UPPER(m.CROP_TYPE) = UPPER(:crop_type)`;
            binds.crop_type = cropType;
        }

        if (region) {
            sql += `
              AND (
                  EXISTS (
                      SELECT 1 FROM KSNDMC.BLOCKING_PERIOD b
                      WHERE UPPER(b.REGION_CODE) LIKE '%' || :region_filter || '%'
                        AND b.IS_ACTIVE = 'Y'
                        AND (
                            UPPER(b.CROP_NAME) = UPPER(m.CROP_NAME)
                            OR (UPPER(m.CROP_NAME) = 'RAGI' AND UPPER(b.CROP_NAME) = 'FINGER MILLET')
                            OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(b.CROP_NAME) = 'PADDY')
                            OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(b.CROP_NAME) = 'RICE (IR)')
                        )
                  )
                  OR
                  EXISTS (
                      SELECT 1 FROM KSNDMC.FIELD_CROPS_ADVISORY f
                      WHERE UPPER(f.REGION_CODE) LIKE '%' || :region_filter || '%'
                        AND f.IS_ACTIVE = 'Y'
                        AND (
                            UPPER(f.CROP_NAME) = UPPER(m.CROP_NAME)
                            OR (UPPER(m.CROP_NAME) = 'RAGI' AND UPPER(f.CROP_NAME) = 'FINGER MILLET')
                            OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(f.CROP_NAME) = 'PADDY')
                            OR (UPPER(m.CROP_NAME) = 'RICE (IR)' AND UPPER(f.CROP_NAME) = 'RICE')
                        )
                  )
                  OR
                  EXISTS (
                      SELECT 1 FROM KSNDMC.HORTI_WEEKS_CROPS_ADVISORY hw
                      WHERE (UPPER(hw.CROP_NAME) = UPPER(m.CROP_NAME) OR UPPER(hw.CROP_NAME) LIKE UPPER(m.CROP_NAME) || '%')
                        AND UPPER(hw.REGION_CODE) LIKE '%' || :region_filter || '%'
                        AND hw.IS_ACTIVE = 'Y'
                  )
                  OR
                  EXISTS (
                      SELECT 1 FROM KSNDMC.HORTI_MONTHS_CROPS_ADVISORY hm
                      WHERE (UPPER(hm.CROP_NAME) = UPPER(m.CROP_NAME) OR UPPER(hm.CROP_NAME) LIKE UPPER(m.CROP_NAME) || '%')
                        AND UPPER(hm.REGION_CODE) LIKE '%' || :region_filter || '%'
                        AND hm.IS_ACTIVE = 'Y'
                  )
              )
            `;
            binds.region_filter = region;
        }

        sql += ` ORDER BY CROP_NAME_KN`;

        const result = await connection.execute(sql, binds, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        const crops = result.rows.map(row => {
            const name = lang === 'kn' ? (row.NAME || row.ENGLISH_NAME) : row.ENGLISH_NAME;
            return {
                name: name,
                id: row.ID,
                english_name: row.ENGLISH_NAME,
                region_code: row.REGION_CODE,
                crop_type: row.CROP_TYPE
            };
        });

        // Alphabetical sorting based on active language
        crops.sort((a, b) => a.name.localeCompare(b.name, lang === 'kn' ? 'kn' : 'en'));

        return ApiResponse.collection(res, 'Crop master retrieved successfully', crops);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve crop master', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getFarmerLocationDetails = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { mobileNo } = req.query;

        if (!mobileNo) {
            return ApiResponse.error(res, 400, 'Mobile number is required');
        }

        // Get farmer's location details
        const farmerSql = `
            SELECT DISTRICTCODE, TALUKCODE, HOBLI_CODE, GPCODE, DISTRICT, TALUK, HOBLINAME, GP_NAME
            FROM KSNDMC.REWARD_FARMER_DETAILS
            WHERE MOBILE_NO = :mobileNo
        `;
        const farmerResult = await connection.execute(farmerSql, { mobileNo }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        if (!farmerResult.rows.length) {
            return ApiResponse.error(res, 404, 'Farmer details not found');
        }

        const farmerData = farmerResult.rows[0];

        // Get Kannada translations for each location component
        const translations = {};

        // District translation
        if (farmerData.DISTRICTCODE) {
            const districtSql = `SELECT DISTRICT_EN, DISTRICT_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER WHERE DISTRICTCODE = :code`;
            const districtResult = await connection.execute(districtSql, { code: farmerData.DISTRICTCODE }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (districtResult.rows.length) {
                translations.district = {
                    en: districtResult.rows[0].DISTRICT_EN,
                    kn: districtResult.rows[0].DISTRICT_KN
                };
            }
        }

        // Taluk translation
        if (farmerData.TALUKCODE) {
            const talukSql = `SELECT TALUKNAME_EN, TALUKNAME_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER WHERE TALUKCODE = :code`;
            const talukResult = await connection.execute(talukSql, { code: farmerData.TALUKCODE }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (talukResult.rows.length) {
                translations.taluk = {
                    en: talukResult.rows[0].TALUKNAME_EN,
                    kn: talukResult.rows[0].TALUKNAME_KN
                };
            }
        }

        // Hobli translation
        if (farmerData.HOBLI_CODE) {
            const hobliSql = `SELECT HOBLINAME_EN, HOBLINAME_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER WHERE HOBLICODE = :code`;
            const hobliResult = await connection.execute(hobliSql, { code: farmerData.HOBLI_CODE }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (hobliResult.rows.length) {
                translations.hobli = {
                    en: hobliResult.rows[0].HOBLINAME_EN,
                    kn: hobliResult.rows[0].HOBLINAME_KN
                };
            }
        }

        // GP translation
        if (farmerData.GPCODE) {
            const gpSql = `SELECT HOBLINAME_EN, HOBLINAME_KN FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER WHERE HOBLICODE = :code`;
            const gpResult = await connection.execute(gpSql, { code: farmerData.GPCODE }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
            if (gpResult.rows.length) {
                translations.gp = {
                    en: gpResult.rows[0].HOBLINAME_EN,
                    kn: gpResult.rows[0].HOBLINAME_KN
                };
            }
        }

        const locationDetails = {
            district: translations.district || { en: farmerData.DISTRICT, kn: farmerData.DISTRICT },
            taluk: translations.taluk || { en: farmerData.TALUK, kn: farmerData.TALUK },
            hobli: translations.hobli || { en: farmerData.HOBLINAME, kn: farmerData.HOBLINAME },
            gp: translations.gp || { en: farmerData.GP_NAME, kn: farmerData.GP_NAME }
        };

        return ApiResponse.collection(res, 'Farmer location details retrieved successfully', [locationDetails]);
    } catch (err) {
        console.log('Error in getFarmerLocationDetails:', err);
        return ApiResponse.error(res, 500, 'Failed to retrieve farmer location details', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.getHobliTranslation = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { hobliName } = req.query;

        if (!hobliName) {
            return ApiResponse.error(res, 400, 'Hobli name is required');
        }

        // Query to get Kannada translation for the hobli - try multiple matching strategies
        let sql = `
            SELECT DISTINCT HOBLINAME_EN, HOBLINAME_KN
            FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER
            WHERE UPPER(HOBLINAME_EN) LIKE UPPER(:hobliName)
        `;

        let result = await connection.execute(sql, {
            hobliName: `%${hobliName}%`
        }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        // If no exact match found, try normalizing the hobli name (remove underscores, numbers, etc.)
        if (result.rows.length === 0) {
            const normalizedHobli = hobliName.replace(/[_0-9]/g, '').toUpperCase();
            sql = `
                SELECT DISTINCT HOBLINAME_EN, HOBLINAME_KN
                FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER
                WHERE UPPER(REPLACE(REPLACE(HOBLINAME_EN, '_', ''), REGEXP_REPLACE(HOBLINAME_EN, '[0-9]', ''), '')) LIKE :normalizedHobli
            `;
            result = await connection.execute(sql, {
                normalizedHobli: `%${normalizedHobli}%`
            }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
        }

        // If still no match, try partial matching
        if (result.rows.length === 0) {
            const partialMatch = hobliName.split('_')[0].toUpperCase(); // Take first part before underscore
            sql = `
                SELECT DISTINCT HOBLINAME_EN, HOBLINAME_KN
                FROM KSNDMC.MSTVW2_HOBLI_GP_MASTER
                WHERE UPPER(HOBLINAME_EN) LIKE :partialMatch
            `;
            result = await connection.execute(sql, {
                partialMatch: `${partialMatch}%`
            }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
        }

        if (result.rows.length > 0) {
            const translation = result.rows[0];
            return ApiResponse.collection(res, 'Hobli translation retrieved successfully', [{
                hobli_en: translation.HOBLINAME_EN,
                hobli_kn: translation.HOBLINAME_KN
            }]);
        } else {
            return ApiResponse.collection(res, 'Hobli translation retrieved successfully', [{
                hobli_en: hobliName,
                hobli_kn: hobliName // fallback to English if no translation found
            }]);
        }
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve hobli translation', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

exports.updateFarmerCrop = async (req, res) => {
    console.log('updateFarmerCrop called with body:', req.body);
    let connection;
    try {
        connection = await getConnection();
        const { mobileNo, cropName, sowingDate, surveyNo } = req.body;
        console.log('Parsed data:', { mobileNo, cropName, sowingDate, surveyNo });
        const sql = `
            UPDATE KSNDMC.REWARD_FARMER_DETAILS
            SET CROP_NAME = :cropName, SOWING_DATE = TO_DATE(:sowingDate, 'DD/MM/YYYY'), SURVEY_NO = :surveyNo
            WHERE MOBILE_NO = :mobileNo
        `;
        console.log('Executing SQL:', sql);
        const result = await connection.execute(sql, {
            cropName,
            sowingDate,
            surveyNo,
            mobileNo
        });
        console.log('SQL execution result:', result);
        await connection.commit();
        console.log('Commit successful');
        return ApiResponse.ok(res, 'Farmer crop updated successfully');
    } catch (err) {
        console.log('Error in updateFarmerCrop:', err);
        if (connection) await connection.rollback();
        return ApiResponse.error(res, 500, 'Failed to update farmer crop', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};
exports.getVillages = async (req, res) => {
    let connection;
    try {
        connection = await getConnection();
        const { talukName } = req.query;

        if (!talukName) {
            return ApiResponse.error(res, 400, 'Taluk name is required');
        }

        console.log('getVillages called with talukName:', talukName);

        // Normalize input
        let normalizedTaluk = talukName.trim().toLowerCase();

        // Explicit Bangalore taluk mapping
        if (normalizedTaluk.includes('north')) {
            normalizedTaluk = 'Bangalore-North';
        } else if (normalizedTaluk.includes('south')) {
            normalizedTaluk = 'Bangalore-South';
        } else if (normalizedTaluk.includes('east')) {
            normalizedTaluk = 'Bangalore-East';
        } else if (normalizedTaluk.includes('west')) {
            normalizedTaluk = 'Bangalore-West';
        } else {
            // Optional: Title-case fallback
            normalizedTaluk =
                normalizedTaluk.charAt(0).toUpperCase() + normalizedTaluk.slice(1);
        }

        console.log('Normalized taluk name:', normalizedTaluk);

        const sql = `
            SELECT KGIS_VILLAGE_NAME
            FROM KSNDMC.KSRSAC_VILLAGE_MASTER
            WHERE UPPER(KGIS_TALUK_NAME) = UPPER(:talukName)
            ORDER BY KGIS_VILLAGE_NAME
        `;

        const bindParams = {
            talukName: normalizedTaluk
        };

        console.log('Executing village query with params:', bindParams);

        const result = await connection.execute(
            sql,
            bindParams,
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        const villages = result.rows.map(row => ({
            name: row.KGIS_VILLAGE_NAME
        }));

        return ApiResponse.collection(res, 'Villages retrieved successfully', villages);
    } catch (err) {
        console.error('Error in getVillages:', err);
        return ApiResponse.error(res, 500, 'Failed to retrieve villages', { error: err.message });
    } finally {
        if (connection) await closeConnection(connection);
    }
};

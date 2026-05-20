// src/models/cropAdvisory.js
const oracledb = require('oracledb');
const axios = require('axios');
const { getConnection, closeConnection } = require('../config/database');

const CropAdvisory = {
  async getAdvisory({ crop, mobileNo, showing_date, sowing_period, sowing_period_unit, trg_code, hobli_code, hobli, region, prevRainfall, nextRainfall }) {
    const isSIK = region.includes('SIK');
    const isNIK = region.includes('NIK');

    let connection = null;
    let cropType, CROP_DURATION, CROP_CYCLE;
    let das;
    let rainCategory, nextWeekRainCategory;
    let needDB = false;

    // Determine if we need database connection
    if (!prevRainfall || !nextRainfall) needDB = true;

    try {
      if (needDB) {
        connection = await getConnection();
      }

      // Determine crop type and duration
      if (sowing_period_unit) {
        cropType = sowing_period_unit.toUpperCase() === 'AGRI' ? 'AGRICULTURE' : 'HORTICULTURE';
        CROP_DURATION = 0;
        CROP_CYCLE = sowing_period_unit.toUpperCase();
        if (CROP_CYCLE === 'MONTHS') CROP_CYCLE = 'MONTH';
      } else {
        console.log("Step 1: Fetching crop details...");
        let dbCrop = crop;
        if (dbCrop.toUpperCase() === 'FRENCH BEANS') {
          dbCrop = 'BEANS';
        }
const cropQuery = `
  SELECT CROP_TYPE, CROP_DURATION, SOWING_MONTH
  FROM KSNDMC.REWARD_CROP_VARIETY_DURATION
  WHERE CROP_NAME = :dbCrop
    AND REGION_CODE LIKE '%' || :region_code || '%'
`;
        console.log("Step 1 Query:", cropQuery);
        console.log("Step 1 Params:", { dbCrop, region });
        const cropResult = await connection.execute(cropQuery, [dbCrop, region], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        console.log("Step 1 Result:", cropResult.rows);

        if (!cropResult.rows.length) {
          throw new Error(`Crop not found for crop: ${crop}, region: ${region}`);
        }
        const { CROP_TYPE, CROP_DURATION: dur, SOWING_MONTH } = cropResult.rows[0];
        cropType = CROP_TYPE.trim();
        CROP_DURATION = dur;
        CROP_CYCLE = undefined; // not fetched

        // Special case: Force Bajra to AGRICULTURE for NIK region
        if (crop.toUpperCase() === 'BAJRA' && isNIK) {
          cropType = 'AGRICULTURE';
        }
      }

      // Determine DAS
      if (sowing_period) {
        das = Number(sowing_period);
        console.log("Step 2: DAS from sowing_period:", das);
      } else {
        console.log("Step 2: Calculating DAS...");
        const sowingDate = new Date(showing_date);
        const today = new Date();
        das = Math.floor((Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()) - Date.UTC(sowingDate.getUTCFullYear(), sowingDate.getUTCMonth(), sowingDate.getUTCDate())) / (1000 * 60 * 60 * 24));
        console.log("Step 2 DAS:", das);
      }

      function fixKannadaGarbage(str) {
        if (!str) return str;

        try {
          // 1️⃣ Undo Latin-1 corruption
          let decoded = Buffer.from(str, "latin1").toString("utf8");

          // 2️⃣ Remove invalid UTF-8 control bytes
          decoded = decoded.replace(/[\u0000-\u001F\u007F-\u009F]/g, "");

          // 3️⃣ Replace sequences of garbage characters with a placeholder
          decoded = decoded.replace(/[\uFFFD�]+/g, "");   // remove � replacement chars

          // 4️⃣ Remove obvious mojibake patterns
          decoded = decoded.replace(/[^\u0C80-\u0CFF\s.,0-9\-\/]+/g, "");

          // (Kannada Unicode range is U+0C80–U+0CFF)

          return decoded.trim();
        } catch (err) {
          return str;
        }
      }

      function convertDASToMonthRange(das) {
        const months = Math.ceil(das / 30);
        if (months === 1) {
          return '1';
        } else {
          // Return comma-separated list of months: 1,2,3,...,months
          const monthList = [];
          for (let i = 1; i <= months; i++) {
            monthList.push(i);
          }
          return monthList.join(',');
        }
      }

      // Determine rainfall categories
      if (prevRainfall && nextRainfall) {
        rainCategory = prevRainfall;
        nextWeekRainCategory = nextRainfall;
        console.log("Step 3: Rainfall categories from parameters:", rainCategory, nextWeekRainCategory);
      } else {
        // Calculate rainfall categories
        rainCategory = 'NIL';
        nextWeekRainCategory = 'NIL';

        function normalizeHobliCode(code) {
          if (!code) return '';
          let hobli = code;
          if (hobli.length >= 8) hobli = hobli.substring(0, 8);
          if (hobli.length > 6) hobli = hobli.substring(0, hobli.length - 2);
          return hobli;
        }

        async function getNormalRainForPeriod(startDate, endDate, hobli_code) {
          let HOBLICODE = normalizeHobliCode(hobli_code);
          if (HOBLICODE === '250702') HOBLICODE = '250703';

          // Generate date range for the query
          const dates = [];
          const currentDate = new Date(startDate);
          while (currentDate <= endDate) {
            dates.push(currentDate.toLocaleDateString('en-US', { day: '2-digit', month: 'long' }));
            currentDate.setDate(currentDate.getDate() + 1);
          }

          const placeholders = dates.map((_, i) => `:date${i}`).join(', ');
          const query = `
            SELECT SUM(SUM_RAIN) AS TOTAL_RAIN
            FROM KSNDMC.NORMAL_RAIN_HOBLI_SUM
            WHERE DAY_MONTH IN (${placeholders})
            AND HOBLICODE = :hobli_code
          `;

          const params = [...dates, HOBLICODE];
          console.log("Step 3: Fetching 3-day normal rain...");
          console.log("Step 3 Query:", query);
          console.log("Step 3 Params:", params);
          const result = await connection.execute(query, params, { outFormat: oracledb.OUT_FORMAT_OBJECT });
          if (result.rows.length && result.rows[0].TOTAL_RAIN != null) {
            return Number(result.rows[0].TOTAL_RAIN);
          }
          return 0;
        }

        function convertDASToWeekRange(das) {
          const weeks = Math.ceil(das / 7);
          if (weeks === 1) {
            return '1-1';
          } else {
            return `1-${weeks}`;
          }
        }

        // Step 3: Calculate 3-day cumulative normal rainfall
        const today = new Date();
        const normalRainStart = new Date(today);
        normalRainStart.setDate(today.getDate() - 2); // 3 days back including today
        const normalRainEnd = new Date(today);
        const normalRain = await getNormalRainForPeriod(normalRainStart, normalRainEnd, hobli_code);
        console.log("Step 3 3-day Normal Rain:", normalRain);

        // Step 4: Last week's rainfall
        // Ensure trg_code is a number for TRGCODE column
        const trgCodeNum = Number(trg_code);
        if (isNaN(trgCodeNum)) {
          throw new Error(`Invalid trg_code: ${trg_code}. Must be a number for TRGCODE column.`);
        }
        const lastWeekStart = new Date(today);
        lastWeekStart.setDate(today.getDate() - 3);
        const lastWeekEnd = today;
        const rainQuery = `SELECT RAIN, RAINDATE FROM KSNDMC.DAILYRAIN WHERE TRGCODE = :trg_code AND HOBLICODE = :hobli_code AND RAINDATE BETWEEN :start_date AND :end_date`;

        // Print the query with actual parameter values
        const rainQueryWithValues = `
          SELECT RAIN, RAINDATE FROM KSNDMC.DAILYRAIN
          WHERE TRGCODE = ${trgCodeNum}
            AND HOBLICODE = '${hobli_code}'
            AND RAINDATE BETWEEN TO_DATE('${lastWeekStart.toISOString().slice(0,10)}', 'YYYY-MM-DD')
            AND TO_DATE('${lastWeekEnd.toISOString().slice(0,10)}', 'YYYY-MM-DD')
        `;
        console.log("Step 4 Query (with values):", rainQueryWithValues);

        console.log("Step 4 Params:", {
          trg_code: trgCodeNum,
          hobli_code,
          start_date: lastWeekStart,
          end_date: lastWeekEnd
        });

        const rainResult = await connection.execute(
          rainQuery,
          [trgCodeNum, hobli_code, lastWeekStart, lastWeekEnd],
          { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        const lastWeekRain = rainResult.rows.map(r => r.RAIN);
        const sumLastWeekRain = lastWeekRain.length ? lastWeekRain.reduce((a, b) => a + b, 0) : 0;
        console.log("Step 4 Last Week Rain:", sumLastWeekRain);

        // Step 4: Calculate rainfall deviation and determine category
        let deviation = 0;
        if (normalRain > 0) {
          deviation = ((sumLastWeekRain - normalRain) / normalRain) * 100;
        }
        console.log("Step 4 Rainfall Deviation:", deviation);

        // Determine rainfall category based on deviation
        if (deviation > 59) {
          rainCategory = 'ABOVE NORMAL';
        } else if (deviation > 19) {
          rainCategory = 'ABOVE NORMAL';
        } else if (deviation >= -19) {
          rainCategory = 'NORMAL';
        } else if (deviation >= -59) {
          rainCategory = 'BELOW NORMAL';
        } else {
          rainCategory = 'NIL';
        }
        console.log("Step 4 Rain Category:", rainCategory);

        // Step 5: Prepare forecastDatetimes array
        function formatForecastDatetime(date, suffix) {
          const day = date.getDate();
          const month = date.toLocaleString('en-US', { month: 'short' }).toUpperCase();
          const year = date.getFullYear();
          return `${day}${month}${year} 0530 IST ${suffix}`;
        }
        const suffixes = ['(24 hr FCST)', '(48 hr FCST)', '(72 hr FCST)'];
        const forecastDatetimes = suffixes.map(suffix => formatForecastDatetime(today, suffix));

        // Step 5: Next week's forecast
        // Ensure trg_code is a number for TRGCODE column
        const forecastQuery = `
          SELECT RAIN, BASE_DATE, FORECAST_DATETIME
          FROM KSNDMC.FORECAST_SAC_TST110316
          WHERE REFERENCE_NO = :trg_code AND
          FORECAST_DATETIME IN (:dt1, :dt2, :dt3)
        `;
        console.log("Step 5: Fetching next week's forecast...");
        console.log("Step 5 Query:", forecastQuery);
        console.log("Step 5 Params:", { trg_code: trgCodeNum, dt1: forecastDatetimes[0], dt2: forecastDatetimes[1], dt3: forecastDatetimes[2] });
        const forecastResult = await connection.execute(
          forecastQuery,
          [trgCodeNum, ...forecastDatetimes],
          { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        const nextWeekRain = forecastResult.rows.map(r => r.RAIN);
        if (forecastResult.rows.length === 0) {
          nextWeekRainCategory = 'NO';
        } else if (nextWeekRain.some(rain => rain > 0.0)) {
          nextWeekRainCategory = 'YES';
        } else {
          nextWeekRainCategory = 'NO';
        }

        // Override nextWeekRainCategory to YES if rainCategory is NORMAL
        if (rainCategory === 'NORMAL') {
          nextWeekRainCategory = 'YES';
        }

        console.log("Step 5 Next Week Rain Category:", nextWeekRainCategory);
      }

      // Determine cropCycle for horticulture
      let cropCycle;
      if (sowing_period_unit) {
        cropCycle = sowing_period_unit.toUpperCase();
        if (cropCycle === 'MONTHS') cropCycle = 'MONTH';
      } else {
        const monthCycleCrops = [
          'CARDAMOM', 'BETELVINE', 'JACKFRUIT', 'CASHEWNUT', 'TURMERIC', 'PAPAYA',
          'CAULIFLOWER', 'MANGO', 'GINGER', 'POMEGRANATE', 'GUAVA', 'BLACK PEPPER',
          'ARECANUT', 'CABBAGE', 'LEMON', 'COCONUT', 'GRAPES', 'SAPOTA', 'DRUMSTICK'
        ];
        const dailyCycleCrops = ['TOMATO'];
        if (dailyCycleCrops.includes(crop.toUpperCase())) {
          cropCycle = 'DAYS';
        } else if (monthCycleCrops.includes(crop.toUpperCase())) {
          cropCycle = 'MONTH';
        } else {
          cropCycle = 'WEEKS';
        }
        // Special case: Force certain crops to use WEEKS API
        if (crop.toUpperCase() === 'CABBAGE' || crop.toUpperCase() === 'CAULIFLOWER') {
          cropCycle = 'WEEKS';
        }
        // Special case: Force PUMPKIN in SIK to use DAYS API
        if (crop.toUpperCase() === 'PUMPKIN' && isSIK) {
          cropCycle = 'DAYS';
        }
      }

      // Step 6: Fetch advisory
      let advisory = null;

      if (cropType === 'AGRICULTURE') {
        console.log("Step 6: Fetching advisory for AGRICULTURE via API...");
        const url = isSIK ? 'http://104.37.188.140:3000/sikCropAdvisory' : 'http://104.37.188.140:3000/nikCropAdvisory';
        try {
          const apiResponse = await axios.post(url, {
            cropName: crop,
            nextRainfall: nextWeekRainCategory,
            prevRainfall: rainCategory,
            das: das
          });

          if (!apiResponse.data || !apiResponse.data.advisory) {
            advisory = { error: `Advisory not found for crop: ${crop}` };
          } else {
            const adv = apiResponse.data.advisory;
            advisory = {
              AGRICULTURE_MEASURES_KN: adv.agricultureMeasuresKn,
              PLANT_PROTECTION_MEARURES_KN: fixKannadaGarbage(adv.plantProtectionMearuresKn),
              AGRICULTURE_MEASURES_ENG: adv.agricultureMeasuresEng,
              PLANT_PROTECTION_MEARURES_ENG: adv.plantProtectionMearuresEng,
              AGRICULTURE_MEASURES_KN2: '',
              PLANT_PROTECTION_MEARURES_KN2: '',
              CROP_NAME: adv.cropName,
              DAS_OF_CROP: adv.dasOfCrop
            };
          }
        } catch (error) {
          if (error.response && error.response.status === 404) {
            advisory = { error: error.response.data.error || 'No matching advisory found' };
          } else {
            throw error;
          }
        }

        console.log("Step 6 Advisory Result (from API):", advisory);
      } else if (cropType === 'HORTICULTURE') {
        console.log("Determined cropCycle:", cropCycle);

        // For horticulture, select API based on cropCycle
        if (cropCycle === 'DAYS') {
          console.log("Step 6: Fetching horticulture advisory by DAYS via API...");
          const url = isSIK ? 'http://104.37.188.140:3000/hortAdvDays' : 'http://104.37.188.140:3000/hortAdvDaysNik';
          const apiResponse = await axios.post(url, {
            cropName: crop,
            nextRainfall: nextWeekRainCategory,
            prevRainfall: rainCategory,
            das: das
          });

          if (!apiResponse.data || !apiResponse.data.advisory) {
            throw new Error(`Advisory not found for crop: ${crop}`);
          }

          const adv = apiResponse.data.advisory;
          advisory = {
            AGRICULTURE_MEASURES_KN: adv.agricultureMeasuresKn,
            PLANT_PROTECTION_MEARURES_KN: fixKannadaGarbage(adv.plantProtectionMearuresKn),
            AGRICULTURE_MEASURES_ENG: adv.agricultureMeasuresEng,
            PLANT_PROTECTION_MEARURES_ENG: adv.plantProtectionMearuresEng,
            AGRICULTURE_MEASURES_KN2: '',
            PLANT_PROTECTION_MEARURES_KN2: '',
            CROP_NAME: adv.cropName,
            DEFINED_CROP_DAS: adv.definedCropDas
          };

          console.log("Step 6 Horti Days Result (from API):", advisory);
        } else if (cropCycle === 'WEEKS') {
          const week = (sowing_period_unit && cropCycle === 'WEEKS') ? sowing_period : Math.ceil(das / 7);
          console.log('>>>>>>> Week:', week);

          console.log("Step 6: Fetching horticulture advisory by WEEKS via API...");
          const url = isSIK ? 'http://104.37.188.140:3000/hortiCropAdvisoryWeeks' : 'http://104.37.188.140:3000/hortiCropAdvisoryWeeksNik';
          const apiResponse = await axios.post(url, {
            cropName: crop,
            nextRainfall: nextWeekRainCategory,
            prevRainfall: rainCategory,
            week: week
          });

          if (!apiResponse.data || !apiResponse.data.advisory) {
            throw new Error(`Advisory not found for crop: ${crop}`);
          }

          const adv = apiResponse.data.advisory;
          advisory = {
            AGRICULTURE_MEASURES_KN: adv.agricultureMeasuresKn,
            PLANT_PROTECTION_MEARURES_KN: fixKannadaGarbage(adv.plantProtectionMearuresKn),
            AGRICULTURE_MEASURES_ENG: adv.agricultureMeasuresEng,
            PLANT_PROTECTION_MEARURES_ENG: adv.plantProtectionMearuresEng,
            AGRICULTURE_MEASURES_KN2: '',
            PLANT_PROTECTION_MEARURES_KN2: '',
            CROP_NAME: adv.cropName,
            WEEKS_IN_NUMBER: adv.weeksInNumber
          };

          console.log("Step 6 Horti Weeks Result (from API):", advisory);
        } else if (cropCycle === 'MONTH') {
          const monthRange = (sowing_period_unit && cropCycle === 'MONTH') ? sowing_period.toString() : convertDASToMonthRange(das);
          console.log('>>>>>>> Month Range:', monthRange);

          console.log("Step 6: Fetching horticulture advisory by MONTH via API...");
          const url = isSIK ? 'http://104.37.188.140:3000/hortiCropAdvisory' : 'http://104.37.188.140:3000/hortiCropAdvisoryNik';
          const apiResponse = await axios.post(url, {
            cropName: crop,
            nextRainfall: nextWeekRainCategory,
            prevRainfall: rainCategory,
            month: monthRange
          });

          if (!apiResponse.data || !apiResponse.data.advisory) {
            throw new Error(`Advisory not found for crop: ${crop}`);
          }

          const adv = apiResponse.data.advisory;
          advisory = {
            AGRICULTURE_MEASURES_KN: adv.agricultureMeasuresKn,
            PLANT_PROTECTION_MEARURES_KN: fixKannadaGarbage(adv.plantProtectionMearuresKn),
            AGRICULTURE_MEASURES_ENG: adv.agricultureMeasuresEng,
            PLANT_PROTECTION_MEARURES_ENG: adv.plantProtectionMearuresEng,
            AGRICULTURE_MEASURES_KN2: '',
            PLANT_PROTECTION_MEARURES_KN2: '',
            CROP_NAME: adv.cropName,
            MONTH_IN_NUMBER: adv.monthInNumber
          };

          console.log("Step 6 Horti Month Result (from API):", advisory);
        }

      } else {
        console.log("NO CROP TYPE=>");
      }

      if (!advisory) {
        throw new Error(`Advisory not found for crop: ${crop}, region: ${region}, rainCategory: ${rainCategory}, nextWeekRainCategory: ${nextWeekRainCategory}`);
      }

      advisory.CROP_DURATION = CROP_DURATION;
      return advisory;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },
};

module.exports = CropAdvisory;
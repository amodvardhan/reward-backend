// src/models/contingencyCropPlan.js
const oracledb = require('oracledb');
const { getConnection, closeConnection } = require('../config/database');

const SCENARIO_RULES = [
  // --- Group 1: Fortnightly Scenarios ---
  {
    name: 'June 1 - 15',
    match: (month, day) => month === 6 && day >= 1 && day <= 15
  },
  {
    name: 'June 15 - 30',
    match: (month, day) => month === 6 && day >= 16 && day <= 30
  },
  {
    name: 'July 1 - 15',
    match: (month, day) => month === 7 && day >= 1 && day <= 15
  },
  {
    name: 'July 15 - 30',
    match: (month, day) => month === 7 && day >= 16 && day <= 31
  },
  {
    name: 'August 1 - 15',
    match: (month, day) => month === 8 && day >= 1 && day <= 15
  },
  {
    name: 'August 15 - 30',
    match: (month, day) => month === 8 && day >= 16 && day <= 31
  },

  // --- Group 2: Custom Ranges ---
  {
    name: 'June 20 - July 10',
    match: (month, day) => (month === 6 && day >= 20) || (month === 7 && day <= 10)
  },
  {
    name: 'July 11- July 31',
    match: (month, day) => month === 7 && day >= 11 && day <= 31
  },
  {
    name: 'August 1 - August 20',
    match: (month, day) => month === 8 && day >= 1 && day <= 20
  },
  {
    name: 'August 21 - September 30',
    match: (month, day) => (month === 8 && day >= 21) || (month === 9 && day <= 30)
  },
  {
    name: '> September 30',
    match: (month, day) => month >= 10 || month <= 5 || (month === 9 && day > 30)
  }
];

const ContingencyCropPlan = {
  /**
   * Determine the monsoon aberration scenarios based on month and day
   * @param {Date} date 
   * @returns {string[]} The scenario strings matching database values
   */
  getScenariosFromDate(date) {
    const month = date.getMonth() + 1; // 1-12
    const day = date.getDate();
    return SCENARIO_RULES
      .filter(rule => rule.match(month, day))
      .map(rule => rule.name);
  },

  /**
   * Fetch contingency crop plan by district and date
   * @param {Object} params
   * @param {string} params.district
   * @param {Date} params.date
   * @returns {Promise<Object|null>} Mapped plan with English and Kannada text or null if not found
   */
  async getPlanByDistrictAndDate({ district, date }) {
    const scenarios = this.getScenariosFromDate(date);
    if (scenarios.length === 0) {
      console.log(`[${new Date().toISOString()}] No scenarios matched for date: ${date.toISOString()}`);
      return null;
    }

    console.log(`[${new Date().toISOString()}] Querying contingency crop plan for district: ${district}, scenarios: ${scenarios.join(', ')}`);
    let connection = null;

    try {
      connection = await getConnection();
      
      // Build dynamic IN clause bind parameters safely
      const bindParams = { district: district };
      const inClauseParts = scenarios.map((scenario, index) => {
        const paramName = `scenario_${index}`;
        bindParams[paramName] = scenario;
        return `:${paramName}`;
      });

      const sql = `
        SELECT *
        FROM ksndmc.contingency_crop_plan
        WHERE UPPER(district) = UPPER(:district)
          AND scenario IN (${inClauseParts.join(', ')})
          AND is_active = 'Y'
      `;

      const result = await connection.execute(
        sql,
        bindParams,
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );

      if (result.rows.length === 0) {
        console.log(`[${new Date().toISOString()}] No plan found in database for district: ${district}, scenarios: ${scenarios.join(', ')}`);
        return null;
      }

      const row = result.rows[0];
      const plan = {};
      Object.keys(row).forEach(key => {
        plan[key] = row[key];
        plan[key.toLowerCase()] = row[key];
      });

      // Return contingency_plan_en only if it is not empty or null
      if (plan.contingency_plan_en && plan.contingency_plan_en.trim() === '') {
        delete plan.contingency_plan_en;
        delete plan.CONTINGENCY_PLAN_EN;
      }

      return plan;
    } catch (error) {
      console.error(`[${new Date().toISOString()}] Error querying contingency crop plan:`, error.message);
      throw error;
    } finally {
      if (connection) {
        await closeConnection(connection);
      }
    }
  },

  /**
   * Helper to fetch farmer details from KSNDMC.REWARD_FARMER_DETAILS by mobileNo
   */
  async getFarmerByMobileNo(mobileNo) {
    let connection = null;
    try {
      connection = await getConnection();
      const sql = `
        SELECT * 
        FROM KSNDMC.REWARD_FARMER_DETAILS 
        WHERE MOBILE_NO = :mobileNo
          AND rownum <= 1
      `;
      const result = await connection.execute(sql, [mobileNo], { outFormat: oracledb.OUT_FORMAT_OBJECT });
      if (result.rows.length === 0) return null;
      
      const row = result.rows[0];
      const farmer = {};
      Object.keys(row).forEach(key => {
        farmer[key] = row[key];
        farmer[key.toLowerCase()] = row[key];
      });
      return farmer;
    } catch (error) {
      console.error(`Error in getFarmerByMobileNo:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to query REWARD_CROP_VARIETY_DURATION for a given crop and region
   */
  async getCropVarietyDuration(crop, regionCode) {
    let connection = null;
    try {
      connection = await getConnection();
      
      let dbCrop = crop;
      if (dbCrop.toUpperCase() === 'FRENCH BEANS') {
        dbCrop = 'BEANS';
      }

      const sql = `
        SELECT COALESCE(m.CROP_TYPE, vd.CROP_TYPE) AS CROP_TYPE, vd.CROP_DURATION, vd.SOWING_MONTH, vd.CROP_ID
        FROM KSNDMC.REWARD_CROP_VARIETY_DURATION vd
        LEFT JOIN (
          SELECT DISTINCT CROP_ID, CROP_TYPE 
          FROM KSNDMC.REWARD_CROP_MASTER
        ) m ON m.CROP_ID = vd.CROP_ID
        WHERE UPPER(vd.CROP_NAME) = UPPER(:dbCrop)
          AND UPPER(vd.REGION_CODE) LIKE '%' || UPPER(:regionCode) || '%'
          AND rownum <= 1
      `;
      
      const result = await connection.execute(sql, [dbCrop, regionCode], { outFormat: oracledb.OUT_FORMAT_OBJECT });
      if (result.rows.length === 0) return null;
      
      const row = result.rows[0];
      const cropDetails = {};
      Object.keys(row).forEach(key => {
        cropDetails[key] = row[key];
        cropDetails[key.toLowerCase()] = row[key];
      });
      return cropDetails;
    } catch (error) {
      console.error(`Error in getCropVarietyDuration:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to fetch blocking period records from BLOCKING_PERIOD
   */
  async getBlockingPeriod(crop, regionCode) {
    let connection = null;
    try {
      connection = await getConnection();
      const sql = `
        SELECT SOWING_PERIOD, OPENPERIOD_MSG, OPEN_PERIOD_EN, OPEN_PERIOD_KN 
        FROM KSNDMC.BLOCKING_PERIOD 
        WHERE UPPER(CROP_NAME) = UPPER(:crop) 
          AND UPPER(REGION_CODE) LIKE '%' || UPPER(:regionCode) || '%'
          AND IS_ACTIVE = 'Y'
          AND rownum <= 1
      `;
      const result = await connection.execute(sql, [crop, regionCode], { outFormat: oracledb.OUT_FORMAT_OBJECT });
      if (result.rows.length === 0) return null;
      
      const row = result.rows[0];
      const blocking = {};
      Object.keys(row).forEach(key => {
        blocking[key] = row[key];
        blocking[key.toLowerCase()] = row[key];
      });
      return blocking;
    } catch (error) {
      console.error(`Error in getBlockingPeriod:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to query REWARD_REGION_MASTER to find REWARD_REGION
   */
  async getRegionByDistrict({ district, districtCode }) {
    let connection = null;
    try {
      connection = await getConnection();
      let sql = `
        SELECT REWARD_REGION 
        FROM KSNDMC.REWARD_REGION_MASTER 
        WHERE 1=0
      `;
      const params = {};
      if (districtCode) {
        sql += ` OR DISTRICTCODE = :districtCode`;
        params.districtCode = districtCode;
      }
      if (district) {
        sql += ` OR UPPER(DISTRICT) = UPPER(:district)`;
        params.district = district;
      }
      
      if (Object.keys(params).length === 0) return null;
      
      sql = sql.replace('WHERE 1=0 OR', 'WHERE');
      
      const result = await connection.execute(sql, params, { outFormat: oracledb.OUT_FORMAT_OBJECT });
      if (result.rows.length === 0) return null;
      
      return result.rows[0].REWARD_REGION;
    } catch (error) {
      console.error(`Error in getRegionByDistrict:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to fetch cumulative actual rain, normal rain, and forecast rain
   */
  async getRainfallMetrics({ hobliCode, trgCode }) {
    let connection = null;
    try {
      connection = await getConnection();
      const today = new Date();
      
      // 1. 3-day actual cumulative rainfall (today - 2 to today)
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 2);
      startDate.setHours(0, 0, 0, 0);
      const endDate = new Date(today);
      endDate.setHours(23, 59, 59, 999);
      
      const trgCodeNum = Number(trgCode);
      
      let sumActualRain = 0;
      if (!isNaN(trgCodeNum) && hobliCode) {
        const actualRainSql = `
          SELECT RAIN 
          FROM KSNDMC.DAILYRAIN 
          WHERE TRGCODE = :trgCode 
            AND HOBLICODE = :hobliCode 
            AND RAINDATE BETWEEN :startDate AND :endDate
        `;
        const actualRes = await connection.execute(actualRainSql, [trgCodeNum, hobliCode, startDate, endDate], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        sumActualRain = actualRes.rows.reduce((sum, r) => sum + (Number(r.RAIN) || 0), 0);
      }
      
      // 2. 3-day normal cumulative rainfall
      let sumNormalRain = 0;
      let hobliCodeClean = hobliCode || '';
      if (hobliCodeClean.length >= 8) hobliCodeClean = hobliCodeClean.substring(0, 8);
      if (hobliCodeClean.length > 6) hobliCodeClean = hobliCodeClean.substring(0, hobliCodeClean.length - 2);
      if (hobliCodeClean === '250702') hobliCodeClean = '250703';
      
      if (hobliCodeClean) {
        const MONTH_NAMES = [
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'
        ];
        const dayMonths = [];
        for (let i = 0; i < 3; i++) {
          const d = new Date(today);
          d.setDate(today.getDate() - 2 + i);
          const day = d.getDate();
          const month = MONTH_NAMES[d.getMonth()];
          dayMonths.push(`${day} ${month}`);
        }
        
        const normalRainSql = `
          SELECT SUM(SUM_RAIN) AS TOTAL_RAIN 
          FROM KSNDMC.NORMAL_RAIN_HOBLI_SUM 
          WHERE DAY_MONTH IN (:dm1, :dm2, :dm3) 
            AND HOBLICODE = :hobliCode
        `;
        const normalRes = await connection.execute(normalRainSql, [...dayMonths, hobliCodeClean], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        if (normalRes.rows.length && normalRes.rows[0].TOTAL_RAIN != null) {
          sumNormalRain = Number(normalRes.rows[0].TOTAL_RAIN) || 0;
        }
      }
      
      // 3. 3-day rain forecast
      let hasForecastRain = 'NO';
      if (!isNaN(trgCodeNum)) {
        const suffixes = ['(24 hr FCST)', '(48 hr FCST)', '(72 hr FCST)'];
        
        function formatForecastDatetime(date, suffix) {
          const day = String(date.getDate()).padStart(2, '0');
          const MONTH_MAP_SHORT = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
          const month = MONTH_MAP_SHORT[date.getMonth()];
          const year = date.getFullYear();
          return `${day}${month}${year} 0530 IST ${suffix}`;
        }
        
        const forecastDates = suffixes.map((suffix, idx) => {
          const d = new Date(today);
          d.setDate(today.getDate() + 1 + idx);
          return formatForecastDatetime(d, suffix);
        });
        
        const forecastSql = `
          SELECT RAIN 
          FROM KSNDMC.FORECAST_SAC_TST110316 
          WHERE REFERENCE_NO = :trgCode 
            AND FORECAST_DATETIME IN (:dt1, :dt2, :dt3)
        `;
        const forecastRes = await connection.execute(forecastSql, [trgCodeNum, ...forecastDates], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        if (forecastRes.rows.length > 0) {
          const forecastRains = forecastRes.rows.map(r => Number(r.RAIN) || 0);
          if (forecastRains.some(rain => rain > 0.0)) {
            hasForecastRain = 'YES';
          }
        }
      }
      
      return {
        actualRain: sumActualRain,
        normalRain: sumNormalRain,
        forecastRain: hasForecastRain
      };
    } catch (error) {
      console.error(`Error in getRainfallMetrics:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to fetch advisory from FIELD_CROPS_ADVISORY
   */
  async fetchFieldCropAdvisory({ cropName, cropId, sowingMonth, prevRainfall, nextRainfall, regionCode }) {
    let connection = null;
    try {
      connection = await getConnection();
      
      const cropIdNum = Number(cropId);
      
      const sql = `
        SELECT 
          AGRICULTURE_MEASURES_KN,
          PLANT_PROTECTION_MEARURES_KN,
          AGRICULTURE_MEASURES_EN,
          PLANT_PROTECTION_MEARURES_EN,
          DEFINED_DAS_OF_CROP,
          DAS_OF_CROP
        FROM KSNDMC.FIELD_CROPS_ADVISORY
        WHERE UPPER(CROP_NAME) = UPPER(:cropName)
          AND CROP_ID = :cropId
          AND SOWING_MONTH = :sowingMonth
          AND PREVIOUS_WEEK_RAINFALL = :prevRainfall
          AND NEXT_WEEK_RAINFALL_FORECAST = :nextRainfall
          AND REGION_CODE = :regionCode
          AND IS_ACTIVE = 'Y'
      `;
      const result = await connection.execute(
        sql, 
        { cropName, cropId: cropIdNum, sowingMonth, prevRainfall, nextRainfall, regionCode }, 
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      return result.rows.map(row => {
        const mapped = {};
        Object.keys(row).forEach(key => {
          mapped[key] = row[key];
          mapped[key.toLowerCase()] = row[key];
        });
        return mapped;
      });
    } catch (error) {
      console.error(`Error in fetchFieldCropAdvisory:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to fetch advisory from HORTI_WEEKS_CROPS_ADVISORY
   */
  async fetchHortiWeekAdvisory({ cropName, prevRainfall, nextRainfall, regionCode }) {
    let connection = null;
    try {
      connection = await getConnection();
      
      const sql = `
        SELECT *
        FROM KSNDMC.HORTI_WEEKS_CROPS_ADVISORY
        WHERE (UPPER(CROP_NAME) = UPPER(:cropName) OR UPPER(CROP_NAME) LIKE UPPER(:cropName) || '%')
          AND PREVIOUS_WEEK_RAINFALL = :prevRainfall
          AND NEXT_WEEK_RAINFALL_FORECAST = :nextRainfall
          AND UPPER(REGION_CODE) LIKE '%' || UPPER(:regionCode) || '%'
          AND IS_ACTIVE = 'Y'
      `;
      const result = await connection.execute(
        sql,
        { cropName, prevRainfall, nextRainfall, regionCode },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      return result.rows.map(row => {
        const mapped = {};
        Object.keys(row).forEach(key => {
          mapped[key] = row[key];
          mapped[key.toLowerCase()] = row[key];
        });
        return mapped;
      });
    } catch (error) {
      console.error(`Error in fetchHortiWeekAdvisory:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  },

  /**
   * Helper to fetch advisory from HORTI_MONTHS_CROPS_ADVISORY
   */
  async fetchHortiMonthAdvisory({ cropName, prevRainfall, nextRainfall, regionCode, ageOfCrop }) {
    let connection = null;
    try {
      connection = await getConnection();
      
      const sql = `
        SELECT *
        FROM KSNDMC.HORTI_MONTHS_CROPS_ADVISORY
        WHERE (UPPER(CROP_NAME) = UPPER(:cropName) OR UPPER(CROP_NAME) LIKE UPPER(:cropName) || '%')
          AND AGE_OF_THE_CROP = :ageOfCrop
          AND PREVIOUS_MONTH_RAINFALL = :prevRainfall
          AND NEXT_MONTH_RAINFALL_FORECAST = :nextRainfall
          AND UPPER(REGION_CODE) LIKE '%' || UPPER(:regionCode) || '%'
          AND IS_ACTIVE = 'Y'
      `;
      const result = await connection.execute(
        sql,
        { cropName, ageOfCrop, prevRainfall, nextRainfall, regionCode },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      return result.rows.map(row => {
        const mapped = {};
        Object.keys(row).forEach(key => {
          mapped[key] = row[key];
          mapped[key.toLowerCase()] = row[key];
        });
        return mapped;
      });
    } catch (error) {
      console.error(`Error in fetchHortiMonthAdvisory:`, error.message);
      throw error;
    } finally {
      if (connection) await closeConnection(connection);
    }
  }
};

module.exports = ContingencyCropPlan;

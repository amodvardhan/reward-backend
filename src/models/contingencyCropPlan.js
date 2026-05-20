// src/models/contingencyCropPlan.js
const oracledb = require('oracledb');
const { getConnection, closeConnection } = require('../config/database');

const ContingencyCropPlan = {
  /**
   * Determine the monsoon aberration scenarios based on month and day
   * @param {Date} date 
   * @returns {string[]} The scenario strings matching database values
   */
  getScenariosFromDate(date) {
    const month = date.getMonth() + 1; // 1-12
    const day = date.getDate();
    const matched = [];

    // --- Group 1: Fortnightly Scenarios ---
    // June 1 - 15
    if (month === 6 && day >= 1 && day <= 15) {
      matched.push("June 1 - 15");
    }
    // June 15 - 30 (typically June 16 - 30)
    if (month === 6 && day >= 16 && day <= 30) {
      matched.push("June 15 - 30");
    }
    // July 1 - 15
    if (month === 7 && day >= 1 && day <= 15) {
      matched.push("July 1 - 15");
    }
    // July 15 - 30 (typically July 16 - 31)
    if (month === 7 && day >= 16 && day <= 31) {
      matched.push("July 15 - 30");
    }
    // August 1 - 15
    if (month === 8 && day >= 1 && day <= 15) {
      matched.push("August 1 - 15");
    }
    // August 15 - 30 (typically August 16 - 31)
    if (month === 8 && day >= 16 && day <= 31) {
      matched.push("August 15 - 30");
    }

    // --- Group 2: Custom Ranges ---
    // June 20 - July 10
    if ((month === 6 && day >= 20) || (month === 7 && day <= 10)) {
      matched.push("June 20 - July 10");
    }
    // July 11- July 31
    if (month === 7 && day >= 11 && day <= 31) {
      matched.push("July 11- July 31");
    }
    // August 1 - August 20
    if (month === 8 && day >= 1 && day <= 20) {
      matched.push("August 1 - August 20");
    }
    // August 21 - September 30
    if ((month === 8 && day >= 21) || (month === 9 && day <= 30)) {
      matched.push("August 21 - September 30");
    }
    // > September 30
    if (month > 9 || (month === 9 && day > 30)) {
      matched.push("> September 30");
    }

    return matched;
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
        SELECT 
          contingency_plan_id,
          district,
          scenario,
          contingency_plan_en,
          contingency_plan_kn,
          region_code,
          is_active,
          created_date,
          updated_date,
          created_by,
          updated_by
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
      const plan = {
        contingency_plan_id: row.CONTINGENCY_PLAN_ID,
        district: row.DISTRICT,
        scenario: row.SCENARIO,
        contingency_plan_kn: row.CONTINGENCY_PLAN_KN,
        region_code: row.REGION_CODE,
        is_active: row.IS_ACTIVE,
        created_date: row.CREATED_DATE,
        updated_date: row.UPDATED_DATE,
        created_by: row.CREATED_BY,
        updated_by: row.UPDATED_BY
      };

      // Return contingency_plan_en only if it is not empty or null
      if (row.CONTINGENCY_PLAN_EN && row.CONTINGENCY_PLAN_EN.trim() !== '') {
        plan.contingency_plan_en = row.CONTINGENCY_PLAN_EN;
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
  }
};

module.exports = ContingencyCropPlan;

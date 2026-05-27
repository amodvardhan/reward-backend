// src/check_reward_horti.js
const path = require('path');
const fs = require('fs');

const envPath = path.resolve(__dirname, '../.env');
if (fs.existsSync(envPath)) {
  require('dotenv').config({ path: envPath });
} else {
  require('dotenv').config();
}

const { initialize, getConnection, closeConnection } = require('./config/database');

async function run() {
  let connection;
  try {
    await initialize();
    connection = await getConnection();

    console.log('--- Crops in KSNDMC.REWARD_HORTI_ADVISORY_BY_WEEKS ---');
    const weeksCrops = await connection.execute(
      `SELECT DISTINCT CROP_NAME FROM KSNDMC.REWARD_HORTI_ADVISORY_BY_WEEKS`,
      [],
      { outFormat: 4002 }
    );
    console.log(weeksCrops.rows.map(r => r.CROP_NAME));

    console.log('--- Columns in KSNDMC.REWARD_HORTI_ADVISORY_BY_WEEKS ---');
    const weeksCols = await connection.execute(
      `SELECT column_name, data_type FROM all_tab_columns WHERE owner = 'KSNDMC' AND table_name = 'REWARD_HORTI_ADVISORY_BY_WEEKS'`,
      [],
      { outFormat: 4002 }
    );
    console.log(JSON.stringify(weeksCols.rows, null, 2));

    console.log('--- Crops in KSNDMC.REWARD_HORTI_ADVISORY_BY_MONTH ---');
    const monthsCrops = await connection.execute(
      `SELECT DISTINCT CROP_NAME FROM KSNDMC.REWARD_HORTI_ADVISORY_BY_MONTH`,
      [],
      { outFormat: 4002 }
    );
    console.log(monthsCrops.rows.map(r => r.CROP_NAME));

    console.log('--- Columns in KSNDMC.REWARD_HORTI_ADVISORY_BY_MONTH ---');
    const monthsCols = await connection.execute(
      `SELECT column_name, data_type FROM all_tab_columns WHERE owner = 'KSNDMC' AND table_name = 'REWARD_HORTI_ADVISORY_BY_MONTH'`,
      [],
      { outFormat: 4002 }
    );
    console.log(JSON.stringify(monthsCols.rows, null, 2));

  } catch (err) {
    console.error('Database query failed:', err);
  } finally {
    if (connection) {
      await closeConnection(connection);
    }
  }
}

run();

const oracledb = require('oracledb');
const { getConnection, closeConnection } = require('../config/database');

class RainForecast {
  /**
   * Gets actual rainfall for the last N days from the dailyrain table.
   * @param {string} trgCode - The TRG code for the location.
   * @param {number} days - The number of past days to retrieve.
   * @returns {Promise<Array>} A list of objects with date and rainfall.
   */
  static async getPastRainfall(trgCode, days) {
    let connection;
    const results = [];

    try {
      connection = await getConnection();
      for (let i = 1; i <= days; i++) {
        const targetDate = new Date();
        targetDate.setDate(targetDate.getDate() - i);

        // This query mimics the C# logic to get a specific daily reading
        const query = `
          SELECT rain, raindate FROM dailyrain
          WHERE raindate = :targetDate
          AND raintime = '08:30:00+05:30' 
          AND trgcode = :trgCode`;


          console.log("******getPastRainfall*******");
          console.log("query=>",query);
          console.log("todayDate=>",targetDate);
          console.log("trgCode=>",trgCode);

        const result = await connection.execute(query, {
          targetDate,
          trgCode,
        }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        results.push({
          date: targetDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
          rainfall: result.rows.length > 0 ? result.rows[0].RAIN || 0 : 0,
          cloudiness: 0,
          humidity: 0,
          temperature: 0,
          wind_direction: 0,
          wind_speed: 0,
        });
      }
      return results.sort((a, b) => new Date(a.date) - new Date(b.date));
    } finally {
      if (connection) await closeConnection(connection);
    }
  }

  /**
   * Gets forecasted rainfall for today and the next N days.
   * @param {string} trgCode - The TRG code (used as REFERENCE_NO).
   * @param {number} days - The number of future days to retrieve (including today).
   * @returns {Promise<Array>} A list of objects with date and forecasted rainfall.
   */
   static async getFutureForecast(trgCode, days) {
    let connection;
    const results = [];

    try {
      connection = await getConnection();

             // Get today's date and format it for BASE_DATE
       const todayDate = new Date();
       const todayFormatted = todayDate.getDate().toString().padStart(2, '0') + '-' +
                             (todayDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                             todayDate.getFullYear().toString().slice(-2);

       // Get yesterday's date for fallback
       const yesterdayDate = new Date(todayDate);
       yesterdayDate.setDate(todayDate.getDate() - 1);
       const yesterdayFormatted = yesterdayDate.getDate().toString().padStart(2, '0') + '-' +
                                 (yesterdayDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                                 yesterdayDate.getFullYear().toString().slice(-2);

      console.log("******getFutureForecast*******");
      console.log("todayFormatted=>", todayFormatted);
      console.log("yesterdayFormatted=>", yesterdayFormatted);
      console.log("trgCode=>", trgCode);

      // Create results for the requested number of days
      for (let i = 0; i < days; i++) {
        const date = new Date();
        date.setDate(date.getDate() + (i + 1)); // Start from tomorrow

        const forecastDate = new Date(todayDate);
        forecastDate.setDate(todayDate.getDate() + (i + 1));

        const monthName = forecastDate.toLocaleDateString('en-US', { month: 'short' }).toUpperCase();
        const year = forecastDate.getFullYear();
        const day = forecastDate.getDate().toString().padStart(2, '0');

        const forecastPeriod = (i + 1) === 1 ? '24 hr FCST' : (i + 1) === 2 ? '48 hr FCST' : '72 hr FCST';
        const forecastDateTime = `${day}${monthName}${year} 0530 IST (${forecastPeriod})`;

        console.log(`forecastDateTime for day ${i+1}=>`, forecastDateTime);

                                                       // First try with today's BASE_DATE
         let query = `
           SELECT
             RAIN AS TOTAL_RAIN,
             CLOUDINESS AS AVG_CLOUDINESS,
             HUMIDITY AS AVG_HUMIDITY,
             TEMPERATURE AS AVG_TEMPERATURE,
             WIND_DIRECTION AS AVG_WIND_DIRECTION,
             WIND_SPEED AS AVG_WIND_SPEED
           FROM KSNDMC.FORECAST_SAC_TST110316
           WHERE REFERENCE_NO = :trgCode
           AND BASE_DATE = TO_DATE(:baseDate, 'DD-MM-YY')
           AND FORECAST_DATETIME = :forecastDateTime`;

        console.log("query=>", query);
        console.log("baseDate=>", todayFormatted);
        console.log("forecastDateTime=>", forecastDateTime);

                 let result = await connection.execute(query, {
           trgCode,
           baseDate: todayFormatted,
           forecastDateTime
         }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

      let forecastData = result.rows.length > 0 ? result.rows[0] : null;
      let usedBaseDate = todayFormatted;

      // If no data found with today's BASE_DATE, try with yesterday's BASE_DATE
      if (!forecastData || (forecastData.TOTAL_RAIN === null && forecastData.AVG_CLOUDINESS === null)) {
        console.log("No data found with today's BASE_DATE, trying yesterday's BASE_DATE...");

        const yesterdayForecastDate = new Date(yesterdayDate);
        yesterdayForecastDate.setDate(yesterdayDate.getDate() + (i + 1));

        const yesterdayMonthName = yesterdayForecastDate.toLocaleDateString('en-US', { month: 'short' }).toUpperCase();
        const yesterdayYear = yesterdayForecastDate.getFullYear();
        const yesterdayDay = yesterdayForecastDate.getDate().toString().padStart(2, '0');

        const yesterdayForecastDateTime = `${yesterdayDay}${yesterdayMonthName}${yesterdayYear} 0530 IST (${forecastPeriod})`;

        console.log("yesterdayForecastDateTime=>", yesterdayForecastDateTime);

                                                                       result = await connection.execute(query, {
             trgCode,
             baseDate: yesterdayFormatted,
             forecastDateTime: yesterdayForecastDateTime
           }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

        forecastData = result.rows.length > 0 ? result.rows[0] : {};
        usedBaseDate = yesterdayFormatted;
      }

        results.push({
          date: date.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
          rainfall: forecastData ? forecastData.TOTAL_RAIN || 0 : 0,
          cloudiness: forecastData ? forecastData.AVG_CLOUDINESS || 0 : 0,
          humidity: forecastData ? forecastData.AVG_HUMIDITY || 0 : 0,
          temperature: forecastData ? forecastData.AVG_TEMPERATURE || 0 : 0,
          wind_direction: forecastData ? forecastData.AVG_WIND_DIRECTION || 0 : 0,
          wind_speed: forecastData ? forecastData.AVG_WIND_SPEED || 0 : 0,
          base_date_used: usedBaseDate
        });
      }

      return results;
    } finally {
      if (connection) await closeConnection(connection);
    }
  }


  /**
    * Gets 24 hour weather data.
    * @param {string} trgCode - The TRG code (used as REFERENCE_NO).
    * @returns {Promise<Array>} A list of weather data for the past 24 hours.
    */
  static async get24HourWeather(trgCode) {
    let connection;

    try {
      connection = await getConnection();

      // Query to get recent weather data, ordered by most recent first
      const query = `
        SELECT REFERENCE_NO, DISTRICT, TALUK, HOBLI, BASE_DATE, FORECAST_DATETIME,
               CLOUDINESS, HUMIDITY, RAIN, TEMPERATURE, WIND_DIRECTION, WIND_SPEED
        FROM KSNDMC.FORECAST_SAC_TST110316
        WHERE REFERENCE_NO = :trgCode
        ORDER BY BASE_DATE DESC, FORECAST_DATETIME DESC
        FETCH FIRST 24 ROWS ONLY
      `;

      console.log("******get24HourWeather*******");
      console.log("query=>", query);
      console.log("trgCode=>", trgCode);

      const result = await connection.execute(query, {
        trgCode
      }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

      console.log("24 hour weather result rows:", result.rows.length);

      return result.rows.map(row => ({
        reference_no: row.REFERENCE_NO,
        district: row.DISTRICT,
        taluk: row.TALUK,
        hobli: row.HOBLI,
        base_date: row.BASE_DATE,
        forecast_datetime: row.FORECAST_DATETIME,
        cloudiness: row.CLOUDINESS || 0,
        humidity: row.HUMIDITY || 0,
        rain: row.RAIN || 0,
        temperature: row.TEMPERATURE || 0,
        wind_direction: row.WIND_DIRECTION || 0,
        wind_speed: row.WIND_SPEED || 0,
      }));
    } finally {
      if (connection) await closeConnection(connection);
    }
  }

  /**
    * Gets forecasted weather for today.
    * @param {string} trgCode - The TRG code (used as STATION).
    * @returns {Promise<Object>} An object with today's weather data.
    */

  static async getInstantWeatherInfo(mobileNumber) {
  let connection;

  try {
    console.log("✅ getInstantWeatherInfo() called");
    console.log("📲 Mobile Number:", mobileNumber);

    connection = await getConnection();
    console.log("✅ DB Connection established");

    // ---------------- Query 1: Get HOBLI_CODE ----------------
    const query1 = `
      SELECT HOBLI_CODE
      FROM KSNDMC.REWARD_FARMER_DETAILS
      WHERE MOBILE_NO = :mobileNo
    `;

    console.log("🟡 Running Query1 (Fetch HOBLI_CODE)...");
    const result1 = await connection.execute(query1, { mobileNo: mobileNumber });

    console.log("✅ Query1 result:", result1.rows);

    if (!result1.rows || result1.rows.length === 0) {
      console.log("❌ No HOBLI_CODE found for mobile:", mobileNumber);
      return null;
    }

    let hobli_code = result1.rows[0][0];
    console.log("✅ Raw HOBLI_CODE:", hobli_code);

    // ✅ Trim hobli_code to first 6 digits if more than 6
    if (hobli_code !== null && hobli_code !== undefined) {
      hobli_code = hobli_code.toString();
      console.log("🔍 HOBLI_CODE as string:", hobli_code);

      if (hobli_code.length > 6) {
        hobli_code = hobli_code.substring(0, 6);
        console.log("✂️ Trimmed HOBLI_CODE to 6 digits:", hobli_code);
      } else {
        console.log("✅ HOBLI_CODE already <= 6 digits:", hobli_code);
      }
    } else {
      console.log("❌ HOBLI_CODE is null/undefined");
      return null;
    }

    // ---------------- Query 2: Get STATION_NUMBERS ----------------
    const query2 = `
      SELECT DISTINCT STATION_NUMBER
      FROM KSNDMC.DAILY_WEATHER_STAIONWISE
      WHERE HOBLI_CODE = :hobliCode
    `;

    console.log("🟡 Running Query2 (Fetch STATION_NUMBER)...");
    console.log("📌 Using HOBLI_CODE:", hobli_code);

    const result2 = await connection.execute(query2, { hobliCode: hobli_code });

    console.log("✅ Query2 result:", result2.rows);

    if (!result2.rows || result2.rows.length === 0) {
      console.log("❌ No station found for hobli:", hobli_code);
      return hobli_code;
    }

    // ✅ Convert station list
    const stationNumbers = result2.rows.map((row) => row[0]);
    console.log("✅ Station Numbers found:", stationNumbers);

    // ---------------- Query 3: Try each station until weather found ----------------
    const query3 = `
      SELECT *
      FROM KSNDMC.TWS_2026
      WHERE STATION_NUMBER = :stationNumber
      ORDER BY INSERTED_DATE DESC, INSERTED_TIME DESC
      FETCH FIRST 1 ROW ONLY
    `;

    for (let i = 0; i < stationNumbers.length; i++) {
      const station_number = stationNumbers[i];

      console.log(`🟡 Trying station (${i + 1}/${stationNumbers.length}):`, station_number);

      const result3 = await connection.execute(
        query3,
        { stationNumber: station_number },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );

      console.log(
        `✅ Weather rows count for station ${station_number}:`,
        result3.rows?.length || 0
      );

      if (result3.rows && result3.rows.length > 0) {
        const instantWeather = result3.rows[0];

        console.log("✅ Weather data FOUND for station:", station_number);
        console.log("📦 Latest weather row:", instantWeather);

        const response = {
          temperature: instantWeather.TEMPERATURE || 0,
          humidity: instantWeather.HUMIDITY || 0,
          wind_speed: instantWeather.WIND_SPEED || 0,
          wind_direction: instantWeather.WIND_DIRECTION || 0,
          rain: instantWeather.RAIN || 0,
          recorded_time: instantWeather.RECORDED_TIME || null,
          station_number: station_number, // ✅ optional (useful for debugging)
        };

        console.log("✅ Final Response:", response);
        return response;
      }

      console.log("❌ No weather data for station:", station_number);
    }

    console.log("❌ No weather data found for any station:", stationNumbers);
    return null;
  } catch (err) {
    console.error("🔥 ERROR OCCURRED in getInstantWeatherInfo:", err);
    return null;
  } finally {
    console.log("🔚 Closing DB connection...");
    if (connection) await closeConnection(connection);
    console.log("✅ Connection closed");
  }
}


  static async getTodayForecast(trgCode) {
    let connection;

    try {
      connection = await getConnection();
      const todayDate = new Date();
      const yesterdayDate = new Date(todayDate);
      yesterdayDate.setDate(todayDate.getDate() - 1);

      // Format dates for tables (DD-MM-YY format)
      const todayFormatted = todayDate.getDate().toString().padStart(2, '0') + '-' +
                            (todayDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                            todayDate.getFullYear().toString().slice(-2);

      const yesterdayFormatted = yesterdayDate.getDate().toString().padStart(2, '0') + '-' +
                                (yesterdayDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                                yesterdayDate.getFullYear().toString().slice(-2);

      console.log("******getTodayForecast*******");
      console.log("todayFormatted=>", todayFormatted);
      console.log("yesterdayFormatted=>", yesterdayFormatted);
      console.log("trgCode=>", trgCode);
      
                          // First try to get today's data
       let query = `SELECT * FROM KSNDMC.DAILYRAIN WHERE TO_CHAR(RAINDATE, 'DD-MM-YY') = :rainDate AND trgcode = :trgCode`;
       console.log("rainDate=>", todayFormatted);

       console.log("query=>", query);
        let result = await connection.execute(query, {
          rainDate: todayFormatted,
          trgCode: trgCode
        }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

       let forecastData = result.rows.length > 0 ? result.rows[0] : null;
       let usedDate = todayFormatted;
       let displayDate = todayDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });

        console.log("forecastData=>", forecastData);

              // If today's data not found, try yesterday's data
                 if (!forecastData) {
           console.log("Today's data not found, trying yesterday's data...");
           query = `SELECT * FROM KSNDMC.DAILYRAIN WHERE TO_CHAR(RAINDATE, 'DD-MM-YY') = :rainDate AND trgcode = :trgCode`;

           result = await connection.execute(query, {
              rainDate: yesterdayFormatted,
              trgCode: trgCode
           }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

          forecastData = result.rows.length > 0 ? result.rows[0] : {};
          usedDate = yesterdayFormatted;
          displayDate = yesterdayDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
        }

                 // Get additional weather data from DAILY_WEATHER_STAIONWISE table
         let weatherStationData = {};
         if (forecastData && forecastData.HOBLICODE) {
           // Process hobli_code: if more than 6 digits, remove last 2 digits
           let processedHobliCode = forecastData.HOBLICODE;
           if (processedHobliCode.toString().length > 6) {
             processedHobliCode = parseInt(processedHobliCode.toString().substring(0, 6));
             console.log("Original hobli_code:", forecastData.HOBLICODE, "Processed to:", processedHobliCode);
           }
           
           console.log("Getting weather station data for hobli_code:", processedHobliCode);
           
          const weatherQuery = `SELECT * FROM KSNDMC.DAILY_WEATHER_STAIONWISE WHERE TO_CHAR(r_date, 'DD-MM-YY') = :weatherDate AND hobli_code = :hobliCode`;
          //const weatherQuery = `SELECT * FROM KSNDMC.DAILY_WEATHER_STAIONWISE FETCH FIRST 1 ROWS ONLY`;
          
           console.log("Weather station query:", weatherQuery);
           console.log("weatherDate:", usedDate);
           console.log("hobliCode:", processedHobliCode);
           
           const weatherResult = await connection.execute(weatherQuery, {
             weatherDate: usedDate,
             hobliCode: processedHobliCode
           }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
           
           weatherStationData = weatherResult.rows.length > 0 ? weatherResult.rows[0] : {};
           console.log("Weather station data found:", weatherStationData);
         }

       return {
         date: displayDate,
         rainfall: forecastData ? forecastData.RAIN || 0 : 0,
         cloudiness: forecastData ? forecastData.CLOUDINESS || 0 : 0,
         humidity: forecastData ? forecastData.HUMIDITY || 0 : 0,
         temperature: forecastData ? forecastData.TEMPERATURE || 0 : 0,
         wind_direction: forecastData ? forecastData.WIND_DIRECTION || 0 : 0,
         wind_speed: forecastData ? forecastData.WIND_SPEED || 0 : 0,
         hobli: forecastData ? forecastData.HOBLI || "" : "",
         actual_date_used: usedDate,
         // Additional weather station data flattened
         district: weatherStationData.DISTRICT || "",
         taluk: weatherStationData.TALUK || "",
         weather_hobli: weatherStationData.HOBLI || "",
         weather_hobli_code: weatherStationData.HOBLI_CODE || "",
         weather_r_date: weatherStationData.R_DATE || "",
         min_temp: weatherStationData.MIN_TEMP || 0,
         max_temp: weatherStationData.MAX_TEMP || 0,
         avg_temp: weatherStationData.AVG_TEMP || 0,
         remarks_temp: weatherStationData.REMARKS_TEMP || "",
         min_rh: weatherStationData.MIN_RH || 0,
         max_rh: weatherStationData.MAX_RH || 0,
         avg_rh: weatherStationData.AVG_RH || 0,
         remarks_rh: weatherStationData.REMARKS_RH || "",
         min_ws: weatherStationData.MIN_WS || 0,
         max_ws: weatherStationData.MAX_WS || 0,
         avg_ws: weatherStationData.AVG_WS || 0,
         remarks_ws: weatherStationData.REMARKS_WS || "",
         min_wd: weatherStationData.MIN_WD || 0,
         max_wd: weatherStationData.MAX_WD || 0,
         avg_wd: weatherStationData.AVG_WD || 0,
         remarks_wd: weatherStationData.REMARKS_WD || "",
         weather_rain: weatherStationData.RAIN || 0,
         remarks_rain: weatherStationData.REMARKS_RAIN || "",
         remarks_tws: weatherStationData.REMARKS_TWS || "",
         station_name: weatherStationData.STATION_NAME || "",
         station_number: weatherStationData.STATION_NUMBER || ""
       };
    } finally {
      if (connection) await closeConnection(connection);
    }
  }
}

module.exports = RainForecast;


// const oracledb = require('oracledb');
// const { getConnection, closeConnection } = require('../config/database');

// class RainForecast {
//   /**
//    * Gets actual rainfall for the last N days from the dailyrain table.
//    * @param {string} trgCode - The TRG code for the location.
//    * @param {number} days - The number of past days to retrieve.
//    * @returns {Promise<Array>} A list of objects with date and rainfall.
//    */
//   static async getPastRainfall(trgCode, days) {
//     let connection;
//     const results = [];

//     try {
//       connection = await getConnection();
//       for (let i = 1; i <= days; i++) {
//         const targetDate = new Date();
//         targetDate.setDate(targetDate.getDate() - i);

//         // This query mimics the C# logic to get a specific daily reading
//         const query = `
//           SELECT rain, raindate FROM KSNDMC.dailyrain
//           WHERE raindate = :targetDate
//           AND raintime = '08:30:00+05:30' 
//           AND trgcode = :trgCode`;


//           console.log("******getPastRainfall*******");
//           console.log("query=>",query);
//           console.log("todayDate=>",targetDate);
//           console.log("trgCode=>",trgCode);

//         const result = await connection.execute(query, {
//           targetDate,
//           trgCode,
//         }, { outFormat: oracledb.OUT_FORMAT_OBJECT });

//         results.push({
//           date: targetDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
//           rainfall: result.rows.length > 0 ? result.rows[0].RAIN || 0 : 0,
//           cloudiness: 0,
//           humidity: 0,
//           temperature: 0,
//           wind_direction: 0,
//           wind_speed: 0,
//         });
//       }
//       return results.sort((a, b) => new Date(a.date) - new Date(b.date));
//     } finally {
//       if (connection) await closeConnection(connection);
//     }
//   }

//   /**
//    * Gets forecasted rainfall for today and the next N days.
//    * @param {string} trgCode - The TRG code (used as REFERENCE_NO).
//    * @param {number} days - The number of future days to retrieve (including today).
//    * @returns {Promise<Array>} A list of objects with date and forecasted rainfall.
//    */
//   static async getFutureForecast(trgCode, days) {
//     let connection;
//     const results = [];

//     try {
//       connection = await getConnection();
//       for (let i = 0; i < days; i++) {
//         const date = new Date();
//         date.setDate(date.getDate() + i);

//         const targetDate = date.getDate().toString().padStart(2, '0') + 
//                            date.toLocaleDateString('en-US', { month: 'long' }).toUpperCase() + 
//                            date.getFullYear() + 
//                            ' 0530 IST (24 hr FCST)';

//         // Updated query to get averages for other weather metrics
//         const query = `
//           SELECT
//             SUM(RAIN) AS TOTAL_RAIN,
//             AVG(CLOUDINESS) AS AVG_CLOUDINESS,
//             AVG(HUMIDITY) AS AVG_HUMIDITY,
//             AVG(TEMPERATURE) AS AVG_TEMPERATURE,
//             AVG(WIND_DIRECTION) AS AVG_WIND_DIRECTION,
//             AVG(WIND_SPEED) AS AVG_WIND_SPEED
//           FROM KSNDMC.FORECAST_SAC_TST110316
//           WHERE REFERENCE_NO = :trgCode
//           AND FORECAST_DATETIME = :targetDate`;
        
//           console.log("******getFutureForecast*******");
//           console.log("query=>",query);
//           console.log("todayDate=>",targetDate);
//           console.log("trgCode=>",trgCode);

//         const result = await connection.execute(query, {
//           trgCode,
//           targetDate
//         }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
        
//         const forecastData = result.rows.length > 0 ? result.rows[0] : {};

//         results.push({
//           date: date.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
//           rainfall: forecastData.TOTAL_RAIN || 0,
//           cloudiness: forecastData.AVG_CLOUDINESS || 0,
//           humidity: forecastData.AVG_HUMIDITY || 0,
//           temperature: forecastData.AVG_TEMPERATURE || 0,
//           wind_direction: forecastData.AVG_WIND_DIRECTION || 0,
//           wind_speed: forecastData.AVG_WIND_SPEED || 0,
//         });
//       }
//       return results;
//     } finally {
//       if (connection) await closeConnection(connection);
//     }
//   }

//   /**
//    * Gets forecasted weather for today.
//    * @param {string} trgCode - The TRG code (used as REFERENCE_NO).
//    * @returns {Promise<Object>} An object with today's weather data.
//    */
//   static async getTodayForecast(trgCode) {
//     let connection;

//     try {
//       connection = await getConnection();
//       const todayDate = new Date(); //25JULY2025 0530 IST (24 hr FCST)
//       const targetDate = todayDate.getDate().toString().padStart(2, '0') + 
//                            todayDate.toLocaleDateString('en-US', { month: 'long' }).toUpperCase() + 
//                            todayDate.getFullYear() + 
//                            ' 0530 IST (24 hr FCST)';

//       // Query to get averages for today's weather metrics
//       const query = `
//         SELECT
//           hobli,
//           SUM(RAIN) AS TOTAL_RAIN,
//           AVG(CLOUDINESS) AS AVG_CLOUDINESS,
//           AVG(HUMIDITY) AS AVG_HUMIDITY,
//           AVG(TEMPERATURE) AS AVG_TEMPERATURE,
//           AVG(WIND_DIRECTION) AS AVG_WIND_DIRECTION,
//           AVG(WIND_SPEED) AS AVG_WIND_SPEED
//         FROM KSNDMC.FORECAST_SAC_TST110316
//         WHERE REFERENCE_NO = :trgCode
//         AND FORECAST_DATETIME = :targetDate
//         GROUP BY hobli`;
      
//         // AND TRUNC(TO_DATE(SUBSTR(FORECAST_DATETIME, 1, 9), 'DDMONYYYY', 'NLS_DATE_LANGUAGE=AMERICAN')) = TRUNC(:targetDate)
//          console.log("query=>",query);
//           console.log("todayDate=>",targetDate);
//           console.log("trgCode=>",trgCode);

//       const result = await connection.execute(query, {
//         trgCode,
//         targetDate
//       }, { outFormat: oracledb.OUT_FORMAT_OBJECT });
      
//       const forecastData = result.rows.length > 0 ? result.rows[0] : {};

//       return {
//         date: todayDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
//         rainfall: forecastData.TOTAL_RAIN || 0,
//         cloudiness: forecastData.AVG_CLOUDINESS || 0,
//         humidity: forecastData.AVG_HUMIDITY || 0,
//         temperature: forecastData.AVG_TEMPERATURE || 0,
//         wind_direction: forecastData.AVG_WIND_DIRECTION || 0,
//         wind_speed: forecastData.AVG_WIND_SPEED || 0,
//         hobli: forecastData.HOBLI || "",
//       };
//     } finally {
//       if (connection) await closeConnection(connection);
//     }
//   }
// }

// module.exports = RainForecast;

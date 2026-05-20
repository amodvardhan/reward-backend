const oracledb = require('oracledb');

// Set NLS_LANG for proper Unicode handling
process.env.NLS_LANG = ".AL32UTF8";

// Ensure all CLOB/NCLOB values are returned as UTF-8 strings
oracledb.fetchAsString = [ oracledb.CLOB, oracledb.NCLOB ];

// Print test Unicode to verify Node runtime
console.log("UTF8 Self-Test → Kannada:", "ಹಲೋ ನೀವು ಹೇಗಿದ್ದೀರಾ");


// Database configuration
const dbConfig = {
    user: process.env.DB_USER || 'system',
    password: process.env.DB_PASSWORD || 'oracle',
    connectString: `${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_SERVICE_NAME}`,

};

// Initialize Oracle client
async function initialize() {
    try {
        await oracledb.createPool(dbConfig);
        console.log('Database pool created successfully');
    } catch (err) {
        console.error('Error creating database pool:', err);
        throw err;
    }
}

// Get connection from pool
async function getConnection() {
    try {
        const connection = await oracledb.getConnection();
        return connection;
    } catch (err) {
        console.error('Error getting connection from pool:', err);
        throw err;
    }
}


// Close connection
async function closeConnection(connection) {
    try {
        if (connection) {
            await connection.close();
        }
    } catch (err) {
        console.error('Error closing connection:', err);
        throw err;
    }
}

module.exports = {
    initialize,
    getConnection,
    closeConnection
}; 
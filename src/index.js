const path = require('path');
const fs = require('fs');

// Try to load .env from parent directory first, then current directory
const envPath = path.resolve(__dirname, '../.env');
if (fs.existsSync(envPath)) {
  require('dotenv').config({ path: envPath });
} else {
  require('dotenv').config();
}
const express = require('express');
const cors = require('cors');
const { initialize } = require('./config/database');
const userRoutes = require('./routes/userRoutes');
const rewardFarmerDetailsRoutes = require('./routes/rewardFarmerDetailsRoutes');
const rainForecastRoutes = require('./routes/rainForecastRoutes');
const cropAdvisoryRoutes = require('./routes/cropAdvisoryRoutes');
const masterDataRoutes = require('./routes/masterDataRoutes');
const ApiResponse = require('./utils/ApiResponse');

// Global middleware to force JSON UTF-8 for all responses
function enforceUTF8(req, res, next) {
    res.setHeader("Content-Type", "application/json; charset=utf-8");
    next();
}

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(enforceUTF8); // Force UTF-8 for all responses
app.use(express.json({ limit: '10mb' })); // Increase JSON payload limit
app.use(express.urlencoded({ extended: true, limit: '10mb' })); // Increase URL-encoded payload limit

// Routes
app.use('/reward-api/api/users', userRoutes);
app.use('/reward-api/api/farmer-details', rewardFarmerDetailsRoutes);
app.use('/reward-api/api/rain-forecast', rainForecastRoutes);
app.use('/reward-api/api/crop-advisory', cropAdvisoryRoutes);
app.use('/reward-api/api/master-data', masterDataRoutes);

// Health check endpoint
app.get('/health', (req, res) => {
    return ApiResponse.ok(res, 'API health check successful', { status: 'OK', timestamp: new Date() });
});

app.get('/check', (req, res) => {
    const now = new Date();
    const month = now.getMonth() + 1; // getMonth() returns 0-11
    const day = now.getDate();
    const hours = now.getHours();
    const minutes = now.getMinutes();
    const seconds = now.getSeconds();
    
    const timestamp = `live:${month},${day}:${hours}:${minutes}:${seconds}`;
    res.send(timestamp);
});

// Initialize database asss nd start server
async function startServer() {
    try {
        await initialize();
        app.listen(port, '0.0.0.0', () => {
            console.log(`Server is running on 0.0.0.0:${port}`);
        });
    } catch (err) {
        console.error('Failed to start server:', err);
        process.exit(1);
    }
}

startServer(); 
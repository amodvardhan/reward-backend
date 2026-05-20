# Node.js API with Oracle SQL Database

This is a RESTful API built with Node.js and Express, using Oracle SQL as the database.

## Prerequisites

- Node.js (v14 or higher)
- Oracle Database (local or remote)
- Oracle Instant Client

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file in the root directory with the following variables:
```
DB_USER=your_username
DB_PASSWORD=your_password
DB_CONNECTION_STRING=localhost:1521/XEPDB1
PORT=3000
```

3. Create the users table in your Oracle database:
```sql
CREATE TABLE users (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT SYSDATE
);
```

## Running the Application

Development mode:
```bash
npm run dev
```

Production mode:
```bash
npm start
```

## API Endpoints

### Users

- `POST /api/users` - Create a new user
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user by ID
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Health Check

- `GET /health` - Check API health status

### Farmer Details

- `GET /api/farmer-details/:mobileNo` - Get farmer details by mobile number

## Example Requests

Create a user:
```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'
```

Get all users:
```bash
curl http://localhost:3000/api/users
```

Get farmer details by mobile number:
```bash
curl http://localhost:3000/api/farmer-details/YOUR_MOBILE_NUMBER
``` 
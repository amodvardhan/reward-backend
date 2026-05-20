const { getConnection, closeConnection } = require('../config/database');

class User {
    static async create(userData) {
        let connection;
        try {
            connection = await getConnection();
            const sql = `
                INSERT INTO users (name, email, created_at)
                VALUES (:name, :email, SYSDATE)
                RETURNING id INTO :id
            `;
            const result = await connection.execute(sql, {
                name: userData.name,
                email: userData.email,
                id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
            });
            await connection.commit();
            return result.outBinds.id[0];
        } catch (err) {
            if (connection) await connection.rollback();
            throw err;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async findAll() {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                'SELECT * FROM users ORDER BY created_at DESC',
                [],
                { outFormat: oracledb.OUT_FORMAT_OBJECT }
            );
            return result.rows;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async findById(id) {
        let connection;
        try {
            connection = await getConnection();
            const result = await connection.execute(
                'SELECT * FROM users WHERE id = :id',
                [id],
                { outFormat: oracledb.OUT_FORMAT_OBJECT }
            );
            return result.rows[0];
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async update(id, userData) {
        let connection;
        try {
            connection = await getConnection();
            const sql = `
                UPDATE users 
                SET name = :name, email = :email
                WHERE id = :id
            `;
            await connection.execute(sql, {
                name: userData.name,
                email: userData.email,
                id: id
            });
            await connection.commit();
            return true;
        } catch (err) {
            if (connection) await connection.rollback();
            throw err;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }

    static async delete(id) {
        let connection;
        try {
            connection = await getConnection();
            await connection.execute('DELETE FROM users WHERE id = :id', [id]);
            await connection.commit();
            return true;
        } catch (err) {
            if (connection) await connection.rollback();
            throw err;
        } finally {
            if (connection) await closeConnection(connection);
        }
    }
}

module.exports = User; 
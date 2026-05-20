const User = require('../models/user');
const ApiResponse = require('../utils/ApiResponse');

exports.createUser = async (req, res) => {
    try {
        const userId = await User.create(req.body);
        return ApiResponse.created(res, 'User created successfully', { id: userId });
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to create user', { error: err.message });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll();
        return ApiResponse.collection(res, 'Users retrieved successfully', users);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve users', { error: err.message });
    }
};

exports.getUserById = async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
        if (!user) {
            return ApiResponse.error(res, 404, 'User not found');
        }
        return ApiResponse.ok(res, 'User retrieved successfully', user);
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to retrieve user', { error: err.message });
    }
};

exports.updateUser = async (req, res) => {
    try {
        const success = await User.update(req.params.id, req.body);
        if (!success) {
            return ApiResponse.error(res, 404, 'User not found or nothing to update');
        }
        return ApiResponse.ok(res, 'User updated successfully');
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to update user', { error: err.message });
    }
};

exports.deleteUser = async (req, res) => {
    try {
        const success = await User.delete(req.params.id);
        if (!success) {
            return ApiResponse.error(res, 404, 'User not found');
        }
        return ApiResponse.ok(res, 'User deleted successfully');
    } catch (err) {
        return ApiResponse.error(res, 500, 'Failed to delete user', { error: err.message });
    }
}; 
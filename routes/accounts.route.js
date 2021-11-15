const express = require('express');
const db = require('../utils/db')
const StudentModel = require('../models/students.model')

const router = express.Router();


// router.get('/login', async function(req, res) { 
//     res.render('vwAccount/login'),
// });

// router.get('/profile', async function(req, res) {
//     res.render('vwAccount/profile');
// });

module.exports = router;
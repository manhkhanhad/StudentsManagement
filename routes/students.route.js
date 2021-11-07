const express = require('express');
const router = express.Router();
const db = require('../utils/db')
const StudentModel = require('../models/students.model')

router.get('/', async function(req, res) {
    const list = await StudentModel.all();

    console.log(list);
    
    res.render('vwStudents/list',
    {
        students: list,
        empty : list.length === 0
    });
});

router.get('/add', function(req, res) {
    res.render('vwStudents/add');
});

router.post('/add', async function(req, res) {
    const entity = {
        MaHS: req.body.txtStudentID,
        MaTK: req.body.txtAccount,
        HoTen: req.body.txtName,
        GioiTinh: req.body.txtGender,
        NgaySinh: req.body.txtBirth,
        DiaChi: req.body.txtAddress,
        Email: req.body.txtEmail,
        MaLop: req.body.txtClass,
    }
    const rs = await model.add(entity);
    console.log(entity);
    res.render('vwStudents/add');
});

module.exports = router;
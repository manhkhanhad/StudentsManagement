const express = require('express');
const router = express.Router();
const db = require('../utils/db')
const StudentModel = require('../models/students.model')

router.get('/', async function(req, res) {
    const list = await StudentModel.all();

    console.log(list);
    
    res.send(list);
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
    const rs = await StudentModel.add(entity);
    console.log(entity);
    res.render('vwStudents/add');
});


router.get('/edit', async function(req, res) {
    const id = +req.query.id || -1;
    const row = await StudentModel.single(id);
    if (row.length === 0) {
        // throw new Error('Invalid Student ID');
        res.send('Invalid Student ID');
    }
    const students = row[0];
    res.render('vwStudents/edit',{students});
});


router.post('/update', async function(req, res) {
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
    const rs = await StudentModel.patch(entity);
    //console.log(entity);
    res.redirect('/admin/students/');
});


router.post('/del', async function(req, res) {
    const entity = {
        MaHS: req.body.txtStudentID,
    }
    const rs = await StudentModel.del(entity);
    console.log(rs);
    res.redirect('/admin/students/');
});

router.get('/searchclass', function(req, res) {
    res.render('vwStudents/searchclass', {empty: 1});
});

router.post('/searchclass', async function(req, res) {
    const lop =  req.body.txtLop;
    const result = await StudentModel.searchclass(lop);
    
    console.log(result);
    res.render('vwStudents/searchclass',
    {
        students: result,
        empty : result.length === 0
    });
});

module.exports = router;
const express = require('express');
const router = express.Router();
const db = require('../utils/db')
const StudentModel = require('../models/students.model')

router.get('/', async function(req, res) {
    const list = await StudentModel.all();

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

router.get('/searchclass', async function(req, res) {
    const searchque = {
        MaLop: req.body.txtClass,
    }
    const results = await StudentModel.searchClass(searchque);

    console.log(results);

    res.send(results);
});

module.exports = router;
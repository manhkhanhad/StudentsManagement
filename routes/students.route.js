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
        MaHS: req.body.MaHS,
        MaTK: req.body.MaHS,
        HoTen: req.body.HoTen,
        GioiTinh: req.body.GioiTinh,
        NgaySinh: req.body.NgaySinh,
        DiaChi: req.body.DiaChi,
        Email: req.body.Email,
        MaLop: req.body.MaLop,
    }
    const rs = await StudentModel.add(entity);
    res.send("done");
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
        MaHS: req.body.MaHS,
        HoTen: req.body.HoTen,
        DiaChi: req.body.DiaChi,
        Email: req.body.Email,
        MaLop: req.body.MaLop,
    }
    const rs = await StudentModel.patch(entity);

    res.send("done");
});


router.post('/del', async function(req, res) {
    const entity = {
        MaHS: req.body.MaHS,
    }
    const rs = await StudentModel.del(entity);

    res.send("done");
});

router.post('/searchclass', async function(req, res) {
    const lop =  req.body.Lop;
    console.log(lop);
    const result = await StudentModel.searchClass(lop);
    res.send(result);
});

module.exports = router;
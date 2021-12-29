const express = require('express');
const router = express.Router();
const db = require('../utils/db')
const GradeModel = require('../models/grades.model')

// Tra cuu bang diem lop hoc
// url example = http://localhost:3000/grade/gradeTable

router.post('/gradeTable', async function(req, res) {
    const entity = 
    {
        Lop: req.body.Lop,
        HocKy: req.body.HocKy,
        Mon: req.body.Mon
    }
    console.log(entity)
    
    const MaBangDiem = await GradeModel.getGradeTableID(entity)
    console.log(MaBangDiem.length)
    if (MaBangDiem.length > 0) {
        const MaChiTietBangDiem = MaBangDiem[0].MaBangDiem

        const gradeListClass = await GradeModel.getGradeTabel(MaChiTietBangDiem)
        gradeListClass.push({"MaBangDiem":MaChiTietBangDiem})
        console.log(gradeListClass);
        res.send(gradeListClass)
    }
    else {
        res.send([])
    }
});

// Tao moi bang diem lop hoc
// url example = http://localhost:3000/grade/addNewGradeTable
router.post('/addNewGradeTable', async function(req, res) {
    const entity = 
    {
        MaLop: req.body.Lop,
        MaHK: req.body.HocKy,
        TenMon: req.body.Mon
    }
    //Get MaMon
    const MaMon = await GradeModel.getSubjectID(entity)
    console.log(MaMon)
    entity["MaMon"] = MaMon[0].MaMon
    delete entity["TenMon"]
    console.log(entity)
    // Create new entry in table BangDiem
    const MaBangDiem = await GradeModel.insertIntoTable(entity, 'BangDiem')//.insertId
    // Get student ID list by Class ID
    const studentList = await GradeModel.getStudentListByClassID(entity.MaLop)
    // Create empty entry in table ChiTietBangDiem

    let chiTietBangDiemList = [];
    for (const student of studentList) 
    {
        console.log(student.MaHS);
        chiTietBangDiemList.push([MaBangDiem.insertId, student.MaHS])
    }
    const rs = await GradeModel.insertEmptyGradeList(chiTietBangDiemList)
    res.send(rs)
});


// Edit chi tiet bang diem
// url example = http://localhost:3000/grade/editGradeTabel
router.post('/editGradeTabel', async function(req, res) {
    for (const entity of req.body.ChiTietBangDiem) 
    {
        const condition = {MaBangDiem: req.body.MaBangDiem, MaHS: entity.MaHS}
        const values = {Diem15p: entity.Diem15p, Diem1Tiet: entity.Diem1Tiet, DiemHK: entity.DiemHK}
        console.log(condition);
        console.log(values);
        const rs = await GradeModel.updateGradeEntry(values, condition)
    }
    res.send("done")
});

// Lap Bao Cao Tong Ket Mon Hoc
// url example = http://localhost:3000/grade/createSubjectReport
router.get('/createSubjectReport', async function(req, res) {
    const entity = {
        MaMon: req.body.MaMon,
        MaHK: req.body.MaHK,
    }
    const rs = await GradeModel.createSubjectReport(entity)
    res.send(rs)
});

// Lap Bao Cao Tong Ket Lop Hoc
// url example = http://localhost:3000/grade/createClassReport
router.get('/createClassReport', async function(req, res) {
    const entity = {
        MaHK: req.body.MaHK,
    }
    const rs = await GradeModel.createClassReport(entity)
    res.send(rs)
});


module.exports = router;
const db = require("../utils/db");

module.exports = {
    getGradeTableID: async function (entity) {
        return db.load(`select MaBangDiem from bangdiem join monhoc on bangdiem.MaMon = monhoc.MaMon where TenMH = '${entity.Mon}' and MaHK = '${entity.HocKy}' and MaLop = '${entity.Lop}'`);
    },
    
    getGradeTabel: function (entity) {
        return db.load(`select HoTen,HOCSINH.MaHS, Diem15p, Diem1Tiet, DiemHK, DiemTB from ChiTietBangDiem join HOCSINH on ChiTietBangDiem.MaHS = HOCSINH.MaHS where MaBangDiem = '${entity}'`);
    },

    insertIntoTable: function (entity, tabel_name) {
        return db.add(tabel_name, entity);
    },

    getStudentListByClassID: function (entity) {
        return db.load(`select MaHS from hocsinh where MaLop = '${entity}'`);
    },

    insertEmptyGradeList: function (entity) {
        return db.addMultiEntry("chiTietBangDiem",["MaBangDiem","MaHS"],entity);
    },
    
    updateGradeEntry: function (entity, condition) {
        sql = `update chiTietBangDiem set Diem15p = ${entity.Diem15p}, Diem1Tiet = ${entity.Diem1Tiet}, DiemHK = ${entity.DiemHK} where MaBangDiem = '${condition.MaBangDiem}' and MaHS = '${condition.MaHS}'`;
        return db.customQuery(sql);
    },

    createSubjectReport: function (entity) {
        return db.load(`select * from bangdiem where MaMon = '${entity.MaMon}' and MaHK = '${entity.MaHK}'`);
    },

    createClassReport: function (entity) {
        return db.load(`select * from ttlop where MaHK = '${entity.MaHK}'`);
    },

    getSubjectID: function (entity) {
        return db.load(`select MaMon from monhoc where TenMH = '${entity.TenMon}'`);
    }
};
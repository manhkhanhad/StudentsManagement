const db = require("../utils/db");

module.exports = {
    all: function(){
        return db.load("select * from hocsinh")
    },
    
    add: function(entity){
        return db.add("hocsinh", entity);
    },
    single: function(id){
        return db.load(`select * from hocsinh where MaHS = ${id}`);
    },
    patch: function(entity){
        sql = `update hocsinh set HoTen = ${entity.HoTen}, DiaChi = ${entity.DiaChi}, Email = ${entity.Email}, MaLop = ${entity.MaLop} where MaHS = ${entity.MaHS}`
        return db.customQuery(sql);
    },
    del: function(entity){
        const condition = {
            MaHS: entity.MaHS
        }
        return db.del("hocsinh", condition);
    },
    searchClass: function(lop){
        return db.load(`select * from hocsinh where MaLop = "${lop}"`);
    },
}
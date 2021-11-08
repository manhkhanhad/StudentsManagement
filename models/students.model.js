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
        const condition = {
            MaHS: entity.MaHS
        }
        delete entity.MaHS;
        delete entity.NgaySinh; // BUG: datatime ==> do not update ngaysinh
        return db.patch("hocsinh", entity, condition);
    },
    del: function(entity){
        const condition = {
            MaHS: entity.MaHS
        }
        return db.del("hocsinh", condition);
    },
}
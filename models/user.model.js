const db = require("../utils/db");

module.exports = {
    all: function(){
        return db.load("select * from taikhoan");
    },
    
    add: function(entity){
        return db.add("taikhoan", entity);
    },
    single: async function(name){
        const rows = await db.load(`select * from taikhoan where TenDN = '${name}'`);
        if(rows.length === 0)
            return null;
        return rows[0];
    },
    patch: function(entity){
        const condition = {
            TenDN: entity.TenDN
        }
        delete entity.MaTK;
        return db.patch("taikhoan", entity, condition);
    },
    
    del: function(entity){
        const condition = {
            MaHS: entity.TenDN
        }
        return db.del("taikhoan", condition);
    }
}
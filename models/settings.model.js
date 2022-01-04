const db = require("../utils/db");

module.exports = {
    getPara: function(){
        return db.load(`select * from thamso`)
    },
    getSub: function(){
        return db.load(`select * from monhoc`)
    },
    updatePara: function(value, condition){
        sql = `update thamso set GiaTri=${value.GiaTri} where MaThamSo=${condition.MaThamSo}`
        return db.customQuery(sql)
    },
    addSub: function (value) {
        return db.add("monhoc", value);
    },
    removeSub: function(entity){
        const condition = {
            TenMH: entity.TenMH
        }
        return db.del("monhoc", condition);
    },
};
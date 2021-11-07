const db = require("../utils/db");

module.exports = {
    all: function(){
        return db.load("select * from hocsinh")
    },
    
    add: function(entity){
        return db.add("hocsinh", entity);
    }
}
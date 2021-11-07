const mysql      = require('mysql');
const config = require('../config/default.json');


const pool = mysql.createPool(config.mysql);

module.exports = {

     load: function(sql)
     {
       return new Promise(function(resolve, reject){
          pool.query(sql, function(error, results, fields){
            if(error)
            {
              reject(error);
            }
            else
            {
              resolve(results);
            }
          });
       });
     },

     add: function(table, entity){
        return new Promise(function(resolve, reject){
          const sql = `insert into ${table} set ?`;
          pool.query(sql,entity, function(error, results, fields){
            if(error)
            {
              reject(error);
            }
            else
            {
              resolve(results);
            }
          });
      });
    },
  // load: function(sql, fn_done, fn_fail)
  // {
  //   pool.query(sql, function(error, results, fields) {
  //     if (error) {
  //       return fn_fail(error);
  //     } else {
  //       fn_done(results);
  //     }
  //   });
    
  // }

//     load: function(sql, fn_done, fn_fail) {
//     {
//         var connection = mysql.createConnection(config.mysql);
//         connection.connect();

//         connection.query(sql, function process(error, results, fields){
//             if (error) {
//               connection.end();
//               //throw error;
//               fn_fail(error);
//               return;
//             }
//             //console.log(results);
//             fn_done(results);
//           });
//     }
// }
}
const express = require('express');
const exphbs  = require('express-handlebars');


const app = express();
app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');
app.use(express.urlencoded({ extended: true }));



// app.get('/', function(req, res) {
//     //res.send('Hello World!');
//     res.render('home');
// });

// app.get('/bs', function(req, res) {
//     res.sendFile(__dirname + '/bs.html');
// });



app.use('/admin/students/', require('./routes/students.route'));

const PORT = 3000;
app.listen(PORT, function() {
    console.log(`Server is running on port ${PORT}`);
});
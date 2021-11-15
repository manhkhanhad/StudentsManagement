const express = require('express');
const exphbs  = require('express-handlebars');
const exp_hbs_sections = require('express-handlebars-sections');


const app = express();
app.engine('handlebars', exphbs({
    helpers: {
        section: exp_hbs_sections(),
    }
}));
app.set('view engine', 'handlebars');
app.use(express.urlencoded({ extended: true }));



app.get('/', function(req, res) {
    //res.send('Hello World!');
    res.render('home');
});

// app.get('/bs', function(req, res) {
//     res.sendFile(__dirname + '/bs.html');
// });



app.use('/admin/students/', require('./routes/students.route'));
app.use('/account', require('./routes/accounts.route'));

const PORT = 3000;
app.listen(PORT, function() {
    console.log(`Server is running on port ${PORT}`);
});
const express = require('express');
const cors = require('cors');


const app = express();

app.use(cors());
app.use(express.urlencoded({ extended: true }));

var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

require('./middlewares/session')(app)
require('./middlewares/view')(app)
require('./middlewares/locals')(app);


app.get('/', function(req, res) {
    res.render('home');
})

// app.get('/bs', function(req, res) {
//     res.sendFile(__dirname + '/bs.html');
// });


app.use('/admin/students/', require('./routes/students.route'));
app.use('/account', require('./routes/accounts.route'));
app.use('/grade', require('./routes/grades.route'));
app.use('/admin/settings', require('./routes/settings.route'));

app.use(function (req, res){
    res.render('404', {layout: false});
})



const PORT = 3000;
app.listen(PORT, function() {
    console.log(`Server is running on port ${PORT}`);
});
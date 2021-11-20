const exphbs  = require('express-handlebars');
const exp_hbs_sections = require('express-handlebars-sections');

module.exports = function(app){
    app.engine('handlebars', exphbs({
        helpers: {
            section: exp_hbs_sections(),
        }
    }));

    app.set('view engine', 'handlebars');
}
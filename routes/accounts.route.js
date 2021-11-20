const express = require('express');
const db = require('../utils/db')
const userModel = require('../models/user.model')
const auth = require('../middlewares/auth');
const locals = require('../middlewares/locals');

const router = express.Router();


router.get('/login', async function(req, res) { 
    res.render('vwAccounts/login', {layout: false});
});

router.post('/login', async function (req, res, next) {
    const user = await userModel.single(req.body.TenDN);
    if (user === null) {
        return res.render('vwAccounts/login', {
            layout: false,
            err: 'Invalid username or password.'
        })
    }

    if (!(user.MatKhau === req.body.MatKhau)) {
        return res.render('vwAccounts/login', {
            layout: false,
            err: 'Invalid username or password.'
        })
    }

    delete user.MatKhau;
    req.session.isAuthenticated = true;
    req.session.authUser = user;

    const url = req.query.retUrl || '/';
    res.redirect(url);
})
  


router.get('/register', async function(req, res) {
    res.render('vwAccounts/register');
});

router.post('/register', async function(req, res) {

        const entity = {
            TenDN: req.body.TenDN,
            MatKhau: req.body.MatKhau,
            ChucVu: req.body.ChucVu,
        }

    await userModel.add(entity);
    res.render('vwAccounts/login');
});

router.get('/logout', function (req, res) {
    req.session.isAuthenticated = false;
    req.session.authUser = null;
    // res.redirect(req.headers.referer);
    res.redirect('/');
})

router.get('/profile', auth, async function(req, res) {
    // res.render('vwAccount/profile');
    res.json('PROFILE')
});

module.exports = router;
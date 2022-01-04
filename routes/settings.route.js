const express = require('express');
const router = express.Router();
const db = require('../utils/db')
const SettingsModel = require('../models/settings.model')

router.get('/', async function(req, res) {
    const para = await SettingsModel.getPara();
    const subs = await SettingsModel.getSub();

    const merge = {
        thamso: para,
        monhoc: subs,
    }
    res.send(merge)
});

router.post('/editpara', async function(req, res) {
    for (const entity of req.body.para)
    {
        const condition = {
            MaThamSo: entity.MaThamSo
        }
        const value = {
            GiaTri: entity.GiaTri
        }
        const rs = await SettingsModel.updatePara(value, condition)
    }
    res.send("done");
});

router.post('/addsub', async function(req, res) {
    const value = {
        TenMH: req.body.TenMH
    }
    const rs = await SettingsModel.addSub(value, 'monhoc')
    
    res.send("done");
});

router.post('/removesub', async function(req, res) {
    const entity = {
        TenMH: req.body.TenMH
    }
    const rs = await SettingsModel.removeSub(entity)
    
    res.send("done");
});

module.exports = router;
const express = require('express');
const { getAllRoles, getRolesById } = require('../controllers/roleController');
const { getAllUnitBisnis, getUnitBisnisById } = require('../controllers/unitBisnisController');
const { getAllBank, getBankById } = require('../controllers/bankController');
const { getAllDepositoRate, getDepositoRateById, getDepositoRateByBankId } = require('../controllers/depositoRateController');
const router = express.Router();

router.get('/roles', getAllRoles);
router.get('/roles/:id', getRolesById);
router.get('/unit-bisnis', getAllUnitBisnis);
router.get('/unit-bisnis/:id', getUnitBisnisById);
router.get('/banks', getAllBank);
router.get('/banks/:id', getBankById);
router.get('/deposito-rates', getAllDepositoRate);
router.get('/deposito-rates-bank/:id', getDepositoRateByBankId);
router.get('/deposito-rates/:id', getDepositoRateById);

module.exports = router;
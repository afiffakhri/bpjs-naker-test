const express = require('express');
const { getAllUsers, getUserById, getUserByParams } = require('../controllers/userController');
const { getAllRoles, getRolesById, createRole, updateRole } = require('../controllers/roleController');
const { getAllUnitBisnis, getUnitBisnisById } = require('../controllers/unitBisnisController');
const { getAllBank, getBankById } = require('../controllers/bankController');
const { getAllDepositoRate, getDepositoRateById, getDepositoRateByBankId } = require('../controllers/depositoRateController');
const { getAllDeposito, getDepositoById, getDepositoByParams, create, update } = require('../controllers/depositoController');
const { getAllSettlementProcess, getSettlementProcessById, getSettlementProcessByDepositoID, getSettlementProcessByParams, updateSettlementProcess } = require('../controllers/settlementProcessController');
const router = express.Router();

router.post('/users-query', getUserByParams);
router.get('/users', getAllUsers);
router.get('/users/:id', getUserById);

router.post('/roles', createRole);
router.get('/roles', getAllRoles);
router.patch('/roles-update', updateRole);
router.get('/roles/:id', getRolesById);
router.get('/unit-bisnis', getAllUnitBisnis);
router.get('/unit-bisnis/:id', getUnitBisnisById);
router.get('/banks', getAllBank);
router.get('/banks/:id', getBankById);
router.get('/deposito-rates', getAllDepositoRate);
router.get('/deposito-rates-bank/:id', getDepositoRateByBankId);
router.get('/deposito-rates/:id', getDepositoRateById);
router.post('/depositos-query', getDepositoByParams);
router.get('/depositos', getAllDeposito);
router.get('/depositos/:id', getDepositoById);
router.post('/depositos', create);
router.patch('/depositos/:id', update);
router.post('/settlement-process-query', getSettlementProcessByParams);
router.patch('/settlement-process', updateSettlementProcess);
router.get('/settlement-process', getAllSettlementProcess);
router.get('/settlement-process-deposito/:id', getSettlementProcessByDepositoID);
router.get('/settlement-process/:id', getSettlementProcessById);

module.exports = router;
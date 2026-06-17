const express = require('express');

const {
  getPlatos,
  getPlatoById,
  createPlato,
  updatePlato,
  deletePlato,
} = require('../controllers/plato.controller');

const router = express.Router();

router.get('/', getPlatos);
router.get('/:id', getPlatoById);
router.post('/', createPlato);
router.put('/:id', updatePlato);
router.delete('/:id', deletePlato);

module.exports = router;
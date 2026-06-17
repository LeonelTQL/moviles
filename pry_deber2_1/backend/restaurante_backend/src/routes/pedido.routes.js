const express = require('express');

const {
  getPedidos,
  getPedidoById,
  createPedido,
  updatePedido,
  deletePedido,
} = require('../controllers/pedido.controller');

const router = express.Router();

router.get('/', getPedidos);
router.get('/:id', getPedidoById);
router.post('/', createPedido);
router.put('/:id', updatePedido);
router.delete('/:id', deletePedido);

module.exports = router;
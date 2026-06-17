const express = require('express');
const cors = require('cors');
const morgan = require('morgan');

const platoRoutes = require('./routes/plato.routes');
const pedidoRoutes = require('./routes/pedido.routes');

const notFoundMiddleware = require('./middlewares/notFound.middleware');
const errorMiddleware = require('./middlewares/error.middleware');

const app = express();

app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    message: 'API REST Restaurante funcionando correctamente',
  });
});

app.use('/api/platos', platoRoutes);
app.use('/api/pedidos', pedidoRoutes);

app.use(notFoundMiddleware);
app.use(errorMiddleware);

module.exports = app;
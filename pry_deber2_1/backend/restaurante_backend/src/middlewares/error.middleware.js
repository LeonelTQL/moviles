const errorMiddleware = (error, req, res, next) => {
  console.error(error);

  res.status(error.status || 500).json({
    message: error.message || 'Error interno del servidor',
  });
};

module.exports = errorMiddleware;
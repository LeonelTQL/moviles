function validate(schema) {
  return (req, res, next) => {
    const result = schema.safeParse(req.body);
    if (!result.success) {
      return res.status(400).json({
        message: 'Datos inválidos.',
        errors: result.error.errors.map((error) => ({ field: error.path.join('.'), message: error.message }))
      });
    }
    req.body = result.data;
    return next();
  };
}

module.exports = { validate };

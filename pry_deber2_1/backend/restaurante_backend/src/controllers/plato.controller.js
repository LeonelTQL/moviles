const pool = require('../config/database');

const getPlatos = async (req, res, next) => {
  try {
    const result = await pool.query(
      'SELECT * FROM platos ORDER BY id ASC'
    );

    res.json(result.rows);
  } catch (error) {
    next(error);
  }
};

const getPlatoById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      'SELECT * FROM platos WHERE id = $1',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: 'Plato no encontrado',
      });
    }

    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

const createPlato = async (req, res, next) => {
  try {
    const { nombre, descripcion, precio, disponible, imagen_url } = req.body;

    if (!nombre || !descripcion || precio === undefined) {
      return res.status(400).json({
        message: 'Nombre, descripción y precio son obligatorios',
      });
    }

    if (Number(precio) <= 0) {
      return res.status(400).json({
        message: 'El precio debe ser mayor a 0',
      });
    }

    const result = await pool.query(
      `INSERT INTO platos (nombre, descripcion, precio, disponible, imagen_url)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [
        nombre,
        descripcion,
        precio,
        disponible !== undefined ? disponible : true,
        imagen_url || null,
      ]
    );

    res.status(201).json({
      message: 'Plato creado correctamente',
      plato: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

const updatePlato = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { nombre, descripcion, precio, disponible, imagen_url } = req.body;

    if (!nombre || !descripcion || precio === undefined) {
      return res.status(400).json({
        message: 'Nombre, descripción y precio son obligatorios',
      });
    }

    if (Number(precio) <= 0) {
      return res.status(400).json({
        message: 'El precio debe ser mayor a 0',
      });
    }

    const result = await pool.query(
      `UPDATE platos
       SET nombre = $1,
           descripcion = $2,
           precio = $3,
           disponible = $4,
           imagen_url = $5,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = $6
       RETURNING *`,
      [
        nombre,
        descripcion,
        precio,
        disponible !== undefined ? disponible : true,
        imagen_url || null,
        id,
      ]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: 'Plato no encontrado',
      });
    }

    res.json({
      message: 'Plato actualizado correctamente',
      plato: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

const deletePlato = async (req, res, next) => {
  try {
    const { id } = req.params;

    const platoEnPedido = await pool.query(
      'SELECT * FROM pedido_detalles WHERE plato_id = $1 LIMIT 1',
      [id]
    );

    if (platoEnPedido.rows.length > 0) {
      return res.status(400).json({
        message: 'No se puede eliminar el plato porque ya está asociado a un pedido',
      });
    }

    const result = await pool.query(
      'DELETE FROM platos WHERE id = $1 RETURNING *',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: 'Plato no encontrado',
      });
    }

    res.json({
      message: 'Plato eliminado correctamente',
      plato: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getPlatos,
  getPlatoById,
  createPlato,
  updatePlato,
  deletePlato,
};
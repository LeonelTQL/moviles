const pool = require('../config/database');

const getPedidos = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT
          p.id,
          p.cliente,
          p.fecha,
          p.total,
          p.created_at,
          p.updated_at,
          COALESCE(
            (SELECT json_agg(json_build_object(
              'id', pd.id,
              'plato_id', pd.plato_id,
              'nombre_plato', pl.nombre,
              'cantidad', pd.cantidad,
              'precio_unitario', pd.precio_unitario,
              'subtotal', pd.subtotal
            ))
             FROM pedido_detalles pd
             INNER JOIN platos pl ON pd.plato_id = pl.id
             WHERE pd.pedido_id = p.id),
            '[]'
          ) AS detalles
       FROM pedidos p
       ORDER BY p.id DESC`
    );

    res.json(result.rows);
  } catch (error) {
    next(error);
  }
};

const getPedidoById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const pedidoResult = await pool.query(
      'SELECT * FROM pedidos WHERE id = $1',
      [id]
    );

    if (pedidoResult.rows.length === 0) {
      return res.status(404).json({
        message: 'Pedido no encontrado',
      });
    }

    const detallesResult = await pool.query(
      `SELECT
          pd.id,
          pd.pedido_id,
          pd.plato_id,
          pl.nombre AS nombre_plato,
          pd.cantidad,
          pd.precio_unitario,
          pd.subtotal
       FROM pedido_detalles pd
       INNER JOIN platos pl ON pd.plato_id = pl.id
       WHERE pd.pedido_id = $1
       ORDER BY pd.id ASC`,
      [id]
    );

    res.json({
      ...pedidoResult.rows[0],
      detalles: detallesResult.rows,
    });
  } catch (error) {
    next(error);
  }
};

const createPedido = async (req, res, next) => {
  const client = await pool.connect();

  try {
    const { cliente, platos } = req.body;

    if (!cliente || cliente.trim() === '') {
      return res.status(400).json({
        message: 'El nombre del cliente es obligatorio',
      });
    }

    if (!Array.isArray(platos) || platos.length === 0) {
      return res.status(400).json({
        message: 'Un pedido debe tener al menos un plato',
      });
    }

    await client.query('BEGIN');

    let total = 0;
    const detallesCalculados = [];

    for (const item of platos) {
      const { plato_id, cantidad } = item;

      if (!plato_id || !cantidad) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: 'Cada plato debe tener plato_id y cantidad',
        });
      }

      if (Number(cantidad) <= 0) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: 'La cantidad debe ser mayor a 0',
        });
      }

      const platoResult = await client.query(
        'SELECT * FROM platos WHERE id = $1',
        [plato_id]
      );

      if (platoResult.rows.length === 0) {
        await client.query('ROLLBACK');
        return res.status(404).json({
          message: `El plato con id ${plato_id} no existe`,
        });
      }

      const plato = platoResult.rows[0];

      if (!plato.disponible) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: `El plato "${plato.nombre}" no está disponible`,
        });
      }

      const precioUnitario = Number(plato.precio);
      const subtotal = precioUnitario * Number(cantidad);

      total += subtotal;

      detallesCalculados.push({
        plato_id,
        cantidad,
        precio_unitario: precioUnitario,
        subtotal,
        nombre_plato: plato.nombre
      });
    }

    const pedidoResult = await client.query(
      `INSERT INTO pedidos (cliente, fecha, total)
       VALUES ($1, CURRENT_TIMESTAMP, $2)
       RETURNING *`,
      [cliente, total]
    );

    const pedido = pedidoResult.rows[0];

    for (const detalle of detallesCalculados) {
      await client.query(
        `INSERT INTO pedido_detalles
         (pedido_id, plato_id, cantidad, precio_unitario, subtotal)
         VALUES ($1, $2, $3, $4, $5)`,
        [
          pedido.id,
          detalle.plato_id,
          detalle.cantidad,
          detalle.precio_unitario,
          detalle.subtotal,
        ]
      );
    }

    await client.query('COMMIT');

    res.status(201).json({
      message: 'Pedido creado correctamente',
      pedido: {
        ...pedido,
        detalles: detallesCalculados,
      },
    });
  } catch (error) {
    await client.query('ROLLBACK');
    next(error);
  } finally {
    client.release();
  }
};

const updatePedido = async (req, res, next) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { cliente, platos } = req.body;

    if (!cliente || cliente.trim() === '') {
      return res.status(400).json({
        message: 'El nombre del cliente es obligatorio',
      });
    }

    if (!Array.isArray(platos) || platos.length === 0) {
      return res.status(400).json({
        message: 'Un pedido debe tener al menos un plato',
      });
    }

    const pedidoExists = await client.query(
      'SELECT * FROM pedidos WHERE id = $1',
      [id]
    );

    if (pedidoExists.rows.length === 0) {
      return res.status(404).json({
        message: 'Pedido no encontrado',
      });
    }

    await client.query('BEGIN');

    let total = 0;
    const detallesCalculados = [];

    for (const item of platos) {
      const { plato_id, cantidad } = item;

      if (!plato_id || !cantidad) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: 'Cada plato debe tener plato_id y cantidad',
        });
      }

      if (Number(cantidad) <= 0) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: 'La cantidad debe ser mayor a 0',
        });
      }

      const platoResult = await client.query(
        'SELECT * FROM platos WHERE id = $1',
        [plato_id]
      );

      if (platoResult.rows.length === 0) {
        await client.query('ROLLBACK');
        return res.status(404).json({
          message: `El plato con id ${plato_id} no existe`,
        });
      }

      const plato = platoResult.rows[0];

      if (!plato.disponible) {
        await client.query('ROLLBACK');
        return res.status(400).json({
          message: `El plato "${plato.nombre}" no está disponible`,
        });
      }

      const precioUnitario = Number(plato.precio);
      const subtotal = precioUnitario * Number(cantidad);

      total += subtotal;

      detallesCalculados.push({
        plato_id,
        cantidad,
        precio_unitario: precioUnitario,
        subtotal,
        nombre_plato: plato.nombre
      });
    }

    const pedidoResult = await client.query(
      `UPDATE pedidos
       SET cliente = $1,
           total = $2,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = $3
       RETURNING *`,
      [cliente, total, id]
    );

    await client.query(
      'DELETE FROM pedido_detalles WHERE pedido_id = $1',
      [id]
    );

    for (const detalle of detallesCalculados) {
      await client.query(
        `INSERT INTO pedido_detalles
         (pedido_id, plato_id, cantidad, precio_unitario, subtotal)
         VALUES ($1, $2, $3, $4, $5)`,
        [
          id,
          detalle.plato_id,
          detalle.cantidad,
          detalle.precio_unitario,
          detalle.subtotal,
        ]
      );
    }

    await client.query('COMMIT');

    res.json({
      message: 'Pedido actualizado correctamente',
      pedido: {
        ...pedidoResult.rows[0],
        detalles: detallesCalculados,
      },
    });
  } catch (error) {
    await client.query('ROLLBACK');
    next(error);
  } finally {
    client.release();
  }
};

const deletePedido = async (req, res, next) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      'DELETE FROM pedidos WHERE id = $1 RETURNING *',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: 'Pedido no encontrado',
      });
    }

    res.json({
      message: 'Pedido eliminado correctamente',
      pedido: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getPedidos,
  getPedidoById,
  createPedido,
  updatePedido,
  deletePedido,
};

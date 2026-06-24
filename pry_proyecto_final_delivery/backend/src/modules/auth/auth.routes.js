const { Router } = require('express');
const bcrypt = require('bcryptjs');
const { z } = require('zod');
const db = require('../../config/db');
const { validate } = require('../../middlewares/validate.middleware');
const { requireAuth } = require('../../middlewares/auth.middleware');
const { signUserToken } = require('../../utils/token');

const router = Router();

const registerSchema = z.object({
  name: z.string().min(3, 'El nombre debe tener mínimo 3 caracteres.'),
  email: z.string().email('Correo inválido.').transform((value) => value.toLowerCase()),
  password: z.string().min(8, 'La contraseña debe tener mínimo 8 caracteres.'),
  phone: z.string().min(7, 'Teléfono inválido.'),
  role: z.enum(['cliente', 'repartidor']).default('cliente')
});

const loginSchema = z.object({
  email: z.string().email('Correo inválido.').transform((value) => value.toLowerCase()),
  password: z.string().min(1, 'La contraseña es obligatoria.')
});

function publicUser(row) {
  return {
    id: row.id,
    name: row.name,
    email: row.email,
    phone: row.phone,
    role: row.role,
    avatarUrl: row.avatar_url
  };
}

router.post('/register', validate(registerSchema), async (req, res, next) => {
  try {
    const { name, email, password, phone, role } = req.body;
    const exists = await db.query('SELECT id FROM users WHERE email = $1', [email]);
    if (exists.rowCount > 0) {
      return res.status(409).json({ message: 'Ya existe un usuario con este correo.' });
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const result = await db.query(
      `INSERT INTO users (name, email, password_hash, phone, role)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING id, name, email, phone, role, avatar_url`,
      [name, email, passwordHash, phone, role]
    );

    const user = publicUser(result.rows[0]);
    const token = signUserToken(user);
    return res.status(201).json({ token, user });
  } catch (error) {
    return next(error);
  }
});

router.post('/login', validate(loginSchema), async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const result = await db.query(
      `SELECT id, name, email, phone, role, avatar_url, password_hash, active
       FROM users
       WHERE email = $1`,
      [email]
    );

    if (result.rowCount === 0) {
      return res.status(401).json({ message: 'Credenciales incorrectas.' });
    }

    const row = result.rows[0];
    if (!row.active) {
      return res.status(403).json({ message: 'Usuario inactivo.' });
    }

    const ok = await bcrypt.compare(password, row.password_hash || '');
    if (!ok) {
      return res.status(401).json({ message: 'Credenciales incorrectas.' });
    }

    const user = publicUser(row);
    const token = signUserToken(user);
    return res.json({ token, user });
  } catch (error) {
    return next(error);
  }
});

router.get('/me', requireAuth, async (req, res, next) => {
  try {
    const result = await db.query(
      `SELECT id, name, email, phone, role, avatar_url
       FROM users
       WHERE id = $1 AND active = TRUE`,
      [req.user.id]
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Usuario no encontrado.' });
    }
    return res.json({ user: publicUser(result.rows[0]) });
  } catch (error) {
    return next(error);
  }
});

module.exports = router;

// controllers/auth.controller.js
import { LoginSchema, RegisterSchema } from "../models/auth.model.js";
import { authService } from "../services/auth.service.js";
import { clienteService } from "../services/cliente.service.js";

// ====== LOGIN (ya lo tenías, solo lo dejamos igual) ======
export const login = async (req, res, next) => {
  try {
    const payload = LoginSchema.parse(req.body);
    const result = await authService.login(payload);
    // result viene de auth.service.js → { token, user: { ... } }
    res.json(result);
  } catch (e) {
    next(e);
  }
};

// ====== REGISTER (nuevo) ======
export const register = async (req, res, next) => {
  try {
    // Validamos lo que viene del body (nombre, email, password)
    const payload = RegisterSchema.parse(req.body);

    // Usamos clienteService.crear → ya encripta la contraseña
    const cliente = await clienteService.crear({
      nombre: payload.nombre,
      email: payload.email,
      password: payload.password,
      activo: true
    });

    // Regresamos respuesta sin el hash
    res.status(201).json({
      message: "Cuenta creada",
      cliente: {
        id: cliente.id,
        nombre: cliente.nombre,
        email: cliente.email
      }
    });
  } catch (e) {
    next(e);
  }
};

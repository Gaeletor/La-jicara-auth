// models/auth.model.js
import { z } from "zod";

export const LoginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(6)
});

export const RegisterSchema = z.object({
  nombre: z.string().min(1, "El nombre es obligatorio"),
  email: z.string().email("Debe ser un correo válido"),
  password: z.string().min(6, "Mínimo 6 caracteres")
});

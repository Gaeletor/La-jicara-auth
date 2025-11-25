// routes/index.js
import { Router } from "express";
import clientesRoutes from "./clientes.routes.js";
import authRoutes from "./auth.routes.js";

const router = Router();

router.use("/clientes", clientesRoutes);
router.use("/auth", authRoutes);

export default router;

import express from "express";
import "dotenv/config";
import routes from "./routes/index.js";
import { notFound } from "./middlewares/notFound.js";
import { errorHandler } from "./middlewares/errorHandler.js";
import path from "path";
import { fileURLToPath } from "url";

const app = express();

// Necesario para usar __dirname con ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(express.json());

// 👉 SERVIR FRONTEND desde /public
app.use(express.static(path.join(__dirname, "public")));

// Rutas principales (API)
app.use("/api", routes);

// Health root (puedes dejarlo o quitarlo)
app.get("/", (_req, res) => res.json({ ok: true, msg: "API viva" }));

// 404 y errores
app.use(notFound);
app.use(errorHandler);

export default app;

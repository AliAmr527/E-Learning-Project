import { Router } from "express";
import * as UC from "./controller/auth.js"
const router = Router()

router.post("/register",UC.register)
router.post("/login",UC.login)

export default router
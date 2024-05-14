import { Router } from "express";
import * as UC from "./controller/auth.js"
const router = Router()

router.post("/register",UC.register)
router.get("/checkUser/:id",UC.checkUser)
router.get("/getUsers",UC.getUsers)
router.patch("/editUser/:id",UC.editUser)
router.post("/login",UC.login)

export default router
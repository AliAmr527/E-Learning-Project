import { Router } from "express";
import * as SC from "./controller/student.js"
const router = Router()

router.post("/apply",SC.applyCourse)
router.get("/",SC.getStudents)
router.patch("/editStudent",SC.editStudent)


export default router
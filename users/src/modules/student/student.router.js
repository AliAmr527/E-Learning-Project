import { Router } from "express";
import * as SC from "./controller/student.js"
const router = Router()

router.post("/apply",SC.applyCourse)
router.get("/",SC.getStudents)
router.post("/editStudent/:id",SC.editStudent)
router.post("/test",SC.test)


export default router
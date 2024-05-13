import { Router } from "express";
import * as SC from "./controller/student.js"
const router = Router()

router.post("/apply",SC.applyCourse)
router.get("/getUsers",SC.getUsers)
router.post("/pushCourses",SC.pushCourses)

export default router
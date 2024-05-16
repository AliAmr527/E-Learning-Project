import * as IC from "../instructor/controller/instructor.js"
import { Router } from "express"

const router = Router()

router.get("/viewCourses",IC.viewCourses)
router.get("/",IC.getInstructors)
router.post("/editInstructor/:id",IC.editInstructor)

export default router
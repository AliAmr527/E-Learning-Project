import * as IC from "../instructor/controller/instructor.js"
import { Router } from "express"

const router = Router()

router.get("/viewCourses",IC.viewCourses)

export default router
import { checkRole } from "../../utils/checkRole.js"
import * as CC from "../courses/controller/courses.js"
import { Router } from "express"

const router = Router()

router.get("/getAllCourses", CC.getAllCourses)
router.post("/create", checkRole("instructor"), CC.createCourse)
router.get("/getAllCourses", CC.getAllCourses)
router.get("/coursesForInstructor",checkRole("instructor"), CC.getCoursesForInstructor)
router.post("/apply", CC.applyCourse)
router.post("/cancel", CC.cancelCourseEnrollment)
router.post("/review", CC.reviewCourse)

export default router

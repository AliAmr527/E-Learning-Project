import { checkRole } from "../../utils/checkRole.js"
import * as CC from "../courses/controller/courses.js"
import { Router } from "express"

const router = Router()

router.post("/create", checkRole("instructor"), CC.createCourse)
router.get("/getAllCourses", CC.getAllCourses)
router.post("/coursesForInstructor",checkRole("instructor"), CC.getCoursesForInstructor)
//student
router.post("/apply", CC.applyCourse)
router.post("/cancel", CC.cancelCourseEnrollment)
router.get("/viewCurrentAndPast/:id",CC.viewCurrentAndPastCourses)
//instructor
router.post("/accept", CC.acceptRequest)
router.post("/reject", CC.rejectRequest)
//admin
router.post("/finishedCourse", CC.finishedCourse)
router.patch("/editCourse",CC.editCourse)
router.delete("/deleteCourse",CC.deleteCourse)
//notifications
router.post("/getAllNotifications", CC.getAllNotifications)
router.post("/markAsRead", CC.markAsRead)
router.post("/getAllUnreadNotifications",CC.getAllUnreadNotifications)
//review
router.post("/review", CC.reviewCourse)

export default router

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
router.post("/viewCurrentAndPast",CC.viewCurrentAndPastCourses)
//instructor
router.post("/accept", CC.acceptRequest)
router.post("/reject", CC.rejectRequest)
//admin
router.get("/",CC.getCourses)
router.post("/finishedCourse", CC.finishedCourse)
router.patch("/editCourse/:id",CC.editCourse)
router.delete("/deleteCourse/:id",CC.deleteCourse)
router.patch("/validateCourse/:id",CC.validateCourse)
router.get("/track",CC.trackStats)
//notifications
router.post("/getAllNotifications", CC.getAllNotifications)
router.post("/markAsRead", CC.markAsRead)
router.post("/getAllUnreadNotifications",CC.getAllUnreadNotifications)
router.post("/markAllAsRead",CC.markAllAsRead)
//review
router.post("/review", CC.reviewCourse)

export default router

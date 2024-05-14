import courseModel from "../../../../db/models/courses.model.js"
import axios from "axios"
import { checkUser } from "../../../utils/checkUser.js"
export const createCourse = async (req, res) => {
	const { name, duration, category, capacity, createdBy } = req.body
	try {
		const response = checkUser(createdBy)

		if (response.data == "doesn't exist") return res.status(404).send("instructor not found")

		const isExist = await courseModel.findOne({ name })
		if (isExist) return res.status(400).send("Course already exist")

		const course = await courseModel.create({ name, duration, category, capacity, createdBy })
		if (!course) return res.status(400).send("Course not created")

		res.status(200).json(course)
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

export const getAllCourses = async (req, res) => {
	let reqQuery = courseModel.find()
	if(req.query.sort == "name"){
		reqQuery.sort({ name: -1 })
	}
	if (req.query.sort == "rating") {
		reqQuery.sort({ rating: -1 })
	}
	if (req.query.name) {
		reqQuery.find({ name: { $regex: req.query.name || " ", $options: "i" } })
	}
	if (req.query.category) {
		reqQuery.find({ category: { $regex: req.query.category || " ", $options: "i" } })
	}
	const courses = await reqQuery.select("-__v -_id -createdBy -rateNo")
	let obj = JSON.parse(JSON.stringify(courses))
	obj.forEach((course) => {
		course.requestedStudents = undefined
		course.pastStudents = undefined
		course.enrolledStudents = course.enrolledStudents.length
		course.reviews.forEach((review)=>{
			review._id = undefined
		})
	})
	return res.status(200).json({courses:obj})
}

export const getCoursesForInstructor = async (req, res) => {
	const isExist = checkUser(req.body.id)
	if (isExist.data == "doesn't exist") return res.status(404).send("instructor not found")
	const courses = await courseModel.find({ createdBy: req.body.id }, { _id: 1, name: 1, requestedStudents: 1 })
	if (!courses) return res.status(404).send("no courses found")
	return res.status(200).json(courses)
}

//for student requesting enrollment
export const applyCourse = async (req, res) => {
	const { courseId, studentId } = req.body
	const response = checkUser(studentId)
	if (response.data == "doesn't exist") return res.status(404).send("student not found")
	const isExist = await courseModel.findOne({courseId:courseId, enrolledStudents: studentId })
	if (isExist) return res.status(409).send("you already are enrolled for this course")
	const course = await courseModel.updateOne({ _id: courseId }, { $addToSet: { requestedStudents: studentId } }, { new: true })
	if (!course.matchedCount) {
		return res.status(404).send("course not found")
	}
	if (!course.modifiedCount) {
		return res.status(409).send("you already applied for this course")
	}
	return res.status(200).send("applied successfully")
}

export const cancelCourseEnrollment = async (req, res) => {
	const { courseId, studentId } = req.body
	const response = checkUser(studentId)
	if (response.data == "doesn't exist") return res.status(404).send("student not found")
	const course = await courseModel.updateOne({ _id: courseId }, { $pull: { enrolledStudents: studentId } })
	if (!course.modifiedCount) return res.status(404).send("you aren't enrolled in this course" )
	return res.status(200).send("cancelled successfully")
}
//

//instructor stuff
export const acceptRequest = async (req, res) => {
	const { instructorId, courseId, studentId } = req.body
	const response = checkUser(instructorId)
	if (response.data == "doesn't exist") return res.status(404).send("instructor not found")
	const course = await courseModel.updateOne({ createdBy: instructorId, _id: courseId }, { $addToSet: { enrolledStudents: studentId } })
	const courseInfo = await courseModel.findOne({ createdBy: instructorId, _id: courseId })
	// await axios.post(`http://localhost:5001/student/pushCourses`,
	// 	{
	// 		_id:studentId,
	// 		name:courseInfo.name,
	// 		duration:courseInfo.duration,
	// 		category:courseInfo.category,
	// 		status:"current"
	// 	}
	// )

	if (!course.matchedCount) return res.status(404).send("you don't own this course or course doesn't exist")
	if(!course.modifiedCount) return res.status(404).send("request not found")
	await courseModel.findByIdAndUpdate(courseId, { $pull: { requestedStudents: studentId } })
	return res.status(200).send("request accepted")
}

export const rejectRequest = async (req, res) => {
	const { instructorId, courseId, studentId } = req.body
	const response = checkUser(instructorId)
	if (response.data == "doesn't exist") return res.status(404).send("instructor not found")
	const course = await courseModel.updateOne({ createdBy: instructorId, _id: courseId }, { $pull: { requestedStudents: studentId } })
	if (!course.matchedCount) return res.status(404).send("you don't own this course or this course doesn't exist")
	if(!course.modifiedCount) return res.status(404).send("request not found")
	return res.status(200).send("request rejected")
}
//

//for reviewing
export const reviewCourse = async (req, res) => {
	const { courseId, studentName, review, rating } = req.body
	const course = await courseModel.findByIdAndUpdate(courseId, { $addToSet: { reviews: { createdBy: studentName, review } } })
	const newRating = (course.rating * course.rateNo + rating) / (course.rateNo + 1)
	course.rating = newRating
	course.rateNo = course.rateNo + 1
	await course.save()
	return res.status(200).json(course)
}

export const finishedCourse = async (req, res) => {
	const { courseId, studentId } = req.body
	const course = await courseModel.updateOne({ _id: courseId }, { $addToSet: { pastStudents: studentId }, $pull: { enrolledStudents: studentId }})
	if (!course.matchedCount) return res.status(404).send("course not found")
	if (!course.modifiedCount) return res.status(409).send("student already added")
	return res.status(200).send("course finished")
}
export const viewCurrentAndPastCourses = async (req, res) => {
	const currentCourses = await courseModel.find({ enrolledStudents: req.params.id }, { name:1,duration:1,category:1,rating:1 })
	console.log(req.params.studentId)
	const currentCoursesObj = currentCourses.map((course) => {
		return{
			name:course.name,
			duration:course.duration,
			category:course.category,
			rating:course.rating,
			status:"current"
		}
	})
	const pastCourses = await courseModel.find({ pastStudents: req.params.id }, { name:1,duration:1,category:1,rating:1 })
	const pastCoursesObj = pastCourses.map((course) => {
		return{
			name:course.name,
			duration:course.duration,
			category:course.category,
			rating:course.rating,
			status:"done"
		}
	})
	const courses = currentCoursesObj.concat(pastCoursesObj)
	return res.status(200).json({courses})
}

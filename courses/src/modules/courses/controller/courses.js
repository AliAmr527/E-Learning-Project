import courseModel from "../../../../db/models/courses.model.js"

export const createCourse = async (req, res) => {
	const { name, description, category, capacity, createdBy } = req.body
	try {
		const course = await courseModel.create({ name, description, category, capacity, createdBy })
		if (!course) return res.status(400).json({ message: "Course not created" })
		res.status(201).json(course)
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

export const getAllCourses = async (req, res) => {
	let reqQuery = courseModel.find()
	if (req.query.sort == "sort") {
		reqQuery.sort({ rating: -1 })
	}
	if(req.query.name){
		reqQuery.find({name: { $regex: req.query.name || " ", $options: "i" }})
	}
	if(req.query.category){
		reqQuery.find({category: { $regex: req.query.category || " ", $options: "i" }})
	}
	const courses = await reqQuery.select("-__v -_id -createdBy -rateNo")
	let obj = JSON.parse(JSON.stringify(courses))
	obj.forEach((course) => {
		course.requestedStudents = course.requestedStudents.length
		course.enrolledStudents = course.enrolledStudents.length
	})
	return res.status(200).json(obj)
}

export const getCoursesForInstructor = async (req, res) => {
	const courses = await courseModel.find({ createdBy: req.params.id }).select("-__v _id name requestedStudents")
	res.status(200).json(courses)
}

//for student requesting enrollment
export const applyCourse = async (req, res) => {
	const { courseId, studentId } = req.body
	const course = await courseModel.findByIdAndUpdate(courseId, { $addToSet: { requestedStudents: studentId } },{new:true})
	res.status(200).json(course)
}

export const cancelCourse = async (req, res) => {
	const { courseId, studentId } = req.body
	const course = await courseModel.findByIdAndUpdate(courseId, { $pull: { requestedStudents: studentId } })
	res.status(200).json(course)
}
//

//for reviewing
export const reviewCourse = async (req, res) => {
	const { courseId, studentId, review, rating } = req.body
	const course = await courseModel.findByIdAndUpdate(courseId, { $addToSet: { reviews: { createdBy: studentId, review } } })
	const newRating = (course.rating * course.rateNo + rating) / course.rateNo + 1
	course.rating = newRating
	course.rateNo = course.rateNo + 1
	await course.save()
	res.status(200).json(course)
}

import axios from "axios"
import userModel from "../../../../db/model/user.model.js"

export const applyCourse = async (req, res) => {
	try {
		const user = await userModel.findById(req.body.studentId)
		if (!user) {
			return res.status(400).json({ message: "User not found" })
		}
		axios
			.post("http://localhost:5002/courses/apply", req.body)
			.then((response) => {
				return res.json(response.data)
			})
			.catch((error) => {
				return res.status(error.response.status).json(error.response.data)
			})
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

export const test = async (req, res) => {
	console.log(req.body);
	return res.json(req.body)
}

export const getStudents = async (req, res) => {
	try {
		const students = await userModel.find({ role: "student" },{__v:0})
		students.forEach((student) => {
			student.yearsOfExperience = "null"
		})
		return res.json({students})
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

export const editStudent = async (req, res) => {
	try {
		await userModel.findByIdAndUpdate(req.params.id, req.body)
		return res.send("instructor updated successfully")
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}
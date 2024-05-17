import axios from "axios"
import userModel from "../../../../db/model/user.model.js"

export const getStudents = async (req, res) => {
	try {
		const students = await userModel.find({ role: "student" },{__v:0})
		const obj = JSON.parse(JSON.stringify(students))
		obj.forEach((student) => {
			student.yearsOfExperience = -1
		})
		return res.json({students:obj})
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
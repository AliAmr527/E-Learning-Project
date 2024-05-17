import axios from "axios"
import userModel from "../../../../db/model/user.model.js"

export const getInstructors = async (req, res) => {
	try {
		const instructors = await userModel.find({ role: "instructor" },{__v:0})
		return res.json({instructors})
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

export const editInstructor = async (req, res) => {
	try {
		await userModel.findByIdAndUpdate(req.params.id, req.body)
		return res.send("instructor updated successfully")
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}
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

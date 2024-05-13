import axios from "axios"

export const viewCourses = async (req, res) => {
	try {
		const response = await axios.get("http://localhost:5002/courses/getAllCourses")
		return res.json(response.data)
	} catch (error) {
		return res.status(400).json({ message: error.message })
	}
}

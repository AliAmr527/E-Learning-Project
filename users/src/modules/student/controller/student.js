import axios from "axios"
import userModel from "../../../../db/model/user.model.js"

export const applyCourse = async (req, res) => {
    try {
        const user = await userModel.findById(req.body.studentId)
        if(!user){
            return res.status(400).json({ message: "User not found" })
        }
        const response = await axios.post(
            "http://localhost:5002/courses/apply",
            req.body
        )
        return res.json(response.data)
    } catch (error) {
        return res.status(400).json({ message: error.message })
    }
}

export const getUsers = async (req, res) => {
    try {
        const users = await userModel.find()
        return res.json(users)
    } catch (error) {
        return res.status(400).json({ message: error.message })
    }
}

export const editUsers = async (req, res) => {
    try {
        const user = await userModel.findByIdAndUpdate(req.body._id, req.body)
        return res.json(user)
    } catch (error) {
        return res.status(400).json({ message: error.message })
    }
}
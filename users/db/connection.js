import mongoose from "mongoose"

const dbConnection = () => mongoose.connect("mongodb+srv://reaper9027:ZYfH3T09JcNGb8MR@cluster0.vreqasy.mongodb.net/users?retryWrites=true&w=majority&appName=Cluster0")
	.then(() => console.log("Connected!"))
	.catch((e) => {
		console.log(e.message)
	})

export default dbConnection

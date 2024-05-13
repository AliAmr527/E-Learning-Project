import mongoose from "mongoose"

const dbConnection = () => mongoose.connect("mongodb://localhost:27017/microservices_users")
	.then(() => console.log("Connected!"))
	.catch((e) => {
		console.log(e.message)
	})

export default dbConnection

import mongoose from "mongoose"

const dbConnection = () => mongoose.connect(process.env.DB_NAME)
	.then(() => console.log("Connected!"))
	.catch((e) => {
		console.log(e.message)
	})

export default dbConnection

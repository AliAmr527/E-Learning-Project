import { Schema, model, Types } from "mongoose"

const userSchema = new Schema({
	name: {
		type: String,
		required: true,
        trim: true,
	},
	email: {
		type: String,
		required: true,
        unique:true,
        trim: true
	},
	password: {
		type: String,
		required: true,
        trim: true,
	},
	affiliation: {
		type: String,
		required: true
	},
	yearsOfExperience: {
		type: Number,
	},
    bio:{
        type: String,
        required: true
    },
    role:{
        type: String,
        enum: ['student', 'instructor'],
        required: true
    }
})

const userModel = model("User", userSchema)

export default userModel

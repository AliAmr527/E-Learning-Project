import { Schema, Types, model } from "mongoose"

const courseSchema = new Schema({
	name: {
		type: String,
		required: true,
	},
	duration: {
		type: Number,
		required: true,
	},
	category: {
		type: String,
		required: true,
	},
	rating: {
		type: Number,
		default: 0,
	},
	capacity: {
		type: Number,
		required: true,
	},
	requestedStudents: [
		{
			type: String,
		},
	],
	enrolledStudents: [
		{
			type: String,
		},
	],
	pastStudents: [
		{
			type: String,
		},
	],
	reviews: [
		{
			createdBy: { type: String },
			review: { type: String },
		},
	],
	createdBy:{
		type: String,
		required: true,
	},
	rateNo:{
		type: Number,
		default: 0
	}
})

const courseModel = model("Course", courseSchema)

export default courseModel

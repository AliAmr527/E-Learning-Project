import { Schema, model } from "mongoose";

const notificationSchema = new Schema({
    studentId: {
        type: String,
        required: true
    },
    title:{
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    },
    status: {
        type: String,
        enum:["unread", "read"],
    }
})

const notificationModel = model("Notification", notificationSchema)

export default notificationModel
import dbConnection from "../db/connection.js"
import authRouter from "./modules/auth/auth.router.js"
import instructorRouter from "./modules/instructor/instructor.router.js"
import studentRouter from "./modules/student/student.router.js"


const bootstrap = (app,express)=>{
    dbConnection()
    app.use(express.json())
    app.use("/auth",authRouter)
    app.use("/instructor",instructorRouter)
    app.use("/student",studentRouter)
    app.use("*",(_,res)=>{res.status(404).send("invalid url")})
}

export default bootstrap
import dbConnection from "../db/connection.js"
import courseRouter from "./modules/courses/courses.router.js"

const bootstrap = (app,express) => {
    app.use(express.json())
    app.use(express.urlencoded({ extended: true }))
    app.use(express.static('public'))
    dbConnection()
    app.use("/courses",courseRouter)
    app.use("*",(_,res)=>{
        res.send("invalid url")
    })
}

export default bootstrap
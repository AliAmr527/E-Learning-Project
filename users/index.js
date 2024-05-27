import express from "express"
import bootstrap from "./src/index.router.js"
import cors from "cors"
import path from 'path'
import { fileURLToPath } from 'url'
import dotenv from 'dotenv'
const __dirname = path.dirname(fileURLToPath(import.meta.url))
dotenv.config({ path: path.join(__dirname, '.env') })
const app = express()
const port = 5001

var corsOptions = {
	origin: "*",
	optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
}
app.use(cors(corsOptions))

bootstrap(app, express)
const server = app.listen(port, () => console.log(`User microservice listening on port ${port}!`))

export default server

import express from 'express'
import bootstrap from './src/index.router.js'
import cors from "cors"
import dotenv from 'dotenv'
dotenv.config({ path: "courses/.env" })

const app = express()
const port = 5002
var corsOptions = {
	origin: "*",
	optionsSuccessStatus: 200, 
}
app.use(cors(corsOptions))

bootstrap(app,express)
const server = app.listen(port, () => console.log(`Course microservice listening on port ${port}!`))

export default server
import express from 'express'
import bootstrap from './src/index.router.js'
import cors from "cors"
const app = express()
const port = 5002
var corsOptions = {
	origin: "*",
	optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
}
app.use(cors(corsOptions))

bootstrap(app,express)
const server = app.listen(port, () => console.log(`Course microservice listening on port ${port}!`))

export default server
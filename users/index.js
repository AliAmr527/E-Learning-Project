import express from 'express'
import bootstrap from './src/index.router.js'
const app = express()
const port = 5001

bootstrap(app,express)
const server = app.listen(port, () => console.log(`Example app listening on port ${port}!`))

export default server
import express from "express"

const app = express();
const PORT = process.env.PORT || 3000

app.get("/", (req, res) => {
  res.json({
    message: "Hello from a container!",
    service: "hello-node",
    pod: process.env.POD_NAME || 'unknown',
    time: new Date().toLocaleString()
  })
})

app.get("/readyz", (req, res) => {
  res.status(200).json({
    message: 'Ready!'
  })
})

app.get("/healthz", (req, res) => {
  res.status(200).json({
    message: 'OK!'
  })
})

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}!`)
})
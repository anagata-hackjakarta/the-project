import HTTP from 'http'
import { Server } from "socket.io"

const io = new Server()
const http = HTTP.createServer().listen(3000, '0.0.0.0')

io.on("connect", (socket) => {
  socket.on('connected', data => {
    console.log(data)
  })
})

console.log("Ready to serve on port 3000!")
io.listen(http)

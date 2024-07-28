import MySQL from 'mysql'
import Axios from 'axios'
import HTTP from 'http'
import { Server } from "socket.io"
import { THandshakerPayload, TMessageReturn } from './types'

const apiLocation = process.env.ANAGATA_API_URI ?? 'http://localhost:5000'
const conn = MySQL.createConnection({
  host: process.env.MARIADB_HOST,
  database: process.env.MARIADB_DATABASE,
  user: process.env.MARIADB_USERNAME,
  password: process.env.MARIADB_PASSWORD
})
const io = new Server()
const http = HTTP.createServer().listen(3000, '0.0.0.0')
const response: TMessageReturn = { message: "" }

conn.connect()
io.on('connect', (socket) => {
  // First handshaking
  socket.on('connected', (payload: string) => {
    const data = JSON.parse(payload) as THandshakerPayload
    if (!data.uuid) {
      response.message = 'Invalid UUID'
      socket.emit('connected', JSON.stringify(response))
      return
    }

    Axios.post(`${apiLocation}/v1/trip/start`, payload, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(res => {
        socket.emit('connected', res.data)
      })
      .catch(err => {
        socket.emit('connected', err)
      })
  })
})

console.log("Ready to serve on port 3000!")
io.listen(http)

const express = require('express')
var cors = require('cors')
const app = express()
const port = 3000

app.use(cors())

app.use(express.static('kepek'))

app.use(express.json())


app.get('/', (req, res) => {
  res.send('Hello World!')
})


app.get('/kotelezo', (req, res) => {

    var mysql = require('mysql')
    var connection = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '',
      database: 'konyvtarbl'
    })
    
    connection.connect()
    
    connection.query('SELECT * FROM `konyv` INNER JOIN iro ON konyv.konyv_iro = iro.iro_id INNER JOIN mufaj ON mufaj.mufaj_id = konyv.konyv_mufaj WHERE kotelezo = 1', function (err, rows, fields) {
      if (err) throw err
    
      console.log(rows)
      res.send(rows)
    })
    
    connection.end()


  })



app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
const express = require('express')
var cors = require('cors')
const app = express()
const port = 3000

var mysql = require('mysql')
    var connection
    
    function kapcsolat () {
      connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'library'
      })
      connection.connect()
    }
    
    

app.use(cors())

app.use(express.static('kepek'))
app.use(express.static('konyvkep'))
app.use(express.static('irokep'))

app.use(express.json())


app.get('/', (req, res) => {
  res.send('Hello World!')
})


app.get('/kotelezo', (req, res) => {
    
    kapcsolat()
    
    connection.query('SELECT `konyv_cime`,`kp_kep`,`kp_id` FROM `konyv_profil` WHERE `kotelezoolvasmany` = 1 ', function (err, rows, fields) {
      if (err) throw err
    
      console.log(rows)
      res.send(rows)
    })
    
    connection.end()


  })


  app.get('/osszes', (req, res) => {
    
    kapcsolat()
    
    connection.query('SELECT `kp_kep`,`konyv_cime`,`kp_id` FROM `konyv_profil`', function (err, rows, fields) {
      if (err) throw err
    
      console.log(rows)
      res.send(rows)
    })
    
    connection.end()


  })

  app.post('/osszeskereso', (req, res) => {
    kapcsolat()
    let parancs = 'SELECT * FROM `konyv_profil` INNER JOIN iro_profil ON iro_profil.iro_id = konyv_profil.iro_id INNER JOIN mufaj ON konyv_profil.mufaj1 = mufaj.mufaj_id WHERE iro_profil.iro_neve LIKE "%'+req.body.bevitel1+'%%" OR mufaj.mufaj_nev LIKE "%'+req.body.bevitel1+'%%" OR konyv_profil.konyv_cime LIKE "%'+req.body.bevitel1+'%%"'
    connection.query(parancs, function (err, rows, fields) {
      if (err) throw err
    
      console.log(rows)
      res.send(rows)
    })
    
    connection.end()
  
  
  })
  

  app.post('/kereso', (req, res) => {
    
    kapcsolat()
    let parancs = 'SELECT * FROM konyv_profil WHERE kotelezoolvasmany = 1 AND konyv_cime LIKE "%'+req.body.bevitel1+'%"'
    connection.query(parancs, function (err, rows, fields) {
      if (err) throw err
    
      console.log(rows)
      res.send(rows)
    })
    
    connection.end()


  })



  app.post('/konyvprofil', (req, res) => {
    kapcsolat()
        connection.query('SELECT * FROM konyv_profil WHERE konyv_profil.kp_id =  '+req.body.konyvid, function (err, rows, fields) {
          if (err) 
            console.log( err)
          else{
          console.log(rows)
          res.send(rows)}
          
        })
        
        connection.end()
        
      })



      app.post('/ujkolcsonzes', (req, res) => {

        kapcsolat()
        let parancs = "INSERT INTO kolcsonzes VALUES (NULL, '"+req.body.bevitel2+"', '1', '" + req.body.bevitel1  + "', '" + req.body.bevitel1  + "'+INTERVAL 14 DAY)";
        connection.query(parancs, function (err, rows, fields) {
          if (err) throw err
        
          console.log(rows)
          res.send(rows)
        })
        
        connection.end()
    
    
      })


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
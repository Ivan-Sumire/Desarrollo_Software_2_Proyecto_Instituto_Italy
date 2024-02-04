const mysql = require('mysql')

const pool = mysql.createPool({
    connectionLimit: 3,
    host: 'localhost',
    user: 'root',
    password: 'root12345',
    database: 'instituto',
})

module.exports= pool
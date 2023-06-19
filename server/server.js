
// SERVER-SIDE (Node JS & SQL)
// inporting an instance of 'express' library
const express = require('express'),
	backend = express()
const mysql = require('mysql')
const cors = require('cors')
backend.use(cors())
backend.use(express.json())

const db = mysql.createConnection({
    user: "root",
    host: "localhost",
    password: "password",
    database: "carSystem"
})

// executing 'post' requests to the server, from the frontend (react)

backend.post('/create', (req, res) => {
    const name = req.body.name
    const age = req.body.age
    const drivingYears = req.body.drivingYears
    const chooseRegion = req.body.chooseRegion
    const driveway = req.body.driveway
    const ncb = req.body.ncb
    const insuranceGroup = req.body.insuranceGroup

    // Executing SQL Query here
    db.query("DELETE FROM main_table")
    db.query("INSERT INTO main_table (name, age, drivingYears, chooseRegion, driveway, ncb, insuranceGroup) VALUES (?,?,?,?,?,?,?)", [name, age, drivingYears, chooseRegion, driveway, ncb, insuranceGroup], (error, res) => {
        if (error) {
            console.log(error)
        } else {
            console.log("success")
        }
    })
})

backend.get('/result', (req, res) => {
    db.query("SELECT m.userID, m.name, m.age, a.age_multiplier, m.drivingYears, dy.drivingYears_multiplier, m.chooseRegion, r.chooseRegion_multiplier, m.driveway, dw.driveway_multiplier, m.ncb, ncb_table.ncb_multiplier, m.insuranceGroup, ig.insuranceGroup_multiplier, a.age_multiplier * dy.drivingYears_multiplier * r.chooseRegion_multiplier * dw.driveway_multiplier * ncb_table.ncb_multiplier * ig.insuranceGroup_multiplier * 1.5 AS multiplier FROM age_table a INNER JOIN main_table m ON a.age = m.age INNER JOIN drivingYears_table dy ON m.drivingYears = dy.drivingYears INNER JOIN chooseRegion_table r ON m.chooseRegion = r.chooseRegion INNER JOIN driveway_table dw ON m.driveway = dw.driveway INNER JOIN ncb_table ON m.ncb = ncb_table.ncb INNER JOIN insuranceGroup_table ig ON m.insuranceGroup = ig.insuranceGroup;", (error, result) => {
        if (error) {
            console.log(error)
        }
        else {
            res.send(result)
        }
    })
})

backend.listen(3001, () => console.log("Your Backend server works!"))
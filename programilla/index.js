require('dotenv').config();


let lastCleaning = "No se conoce"

// PostgreSQL 

const { Client } = require('pg');
const client = new Client();
let DBConnected = false;

async function connectDB() {
    try {

        await client.connect()
        console.log('Connected to DB');
        DBConnected = true;

    }
    catch (err) {
        console.log('Connection failed');
        DBConnected = false;
        throw Error("Connection to Database Failed")
    }

}

async function deleteDoubles() {
    //throw new Error('Ouch')
    return await client.query("delete from users u where u.id in (select distinct u.id from public.users u, public.users v where u.uid=v.uid and u.id <>v.id and u.dni isnull)");
}


// Express Code
const app = require('express')();

app.set('view engine', 'ejs');

app.get('/', async (req, res) => {

    if (!DBConnected) {
        res.render('pages/connectDB', { lastCleaning: lastCleaning })
        connectDB().then(
            () => answer(res),
            (e) => res.render('pages/failed', { DBAnswer: e, lastCleaning: lastCleaning })
        );
    }
    answer(res);


    //res.send('hello world')
})


//---------------------------------------------------------

connectDB();
app.listen(process.env.PORT)

function answer(res) {
    deleteDoubles()
        .then((x) => {
            lastCleaning = new Date();
            res.render('pages/index', { DBAnswer: x, lastCleaning: lastCleaning });
            console.log("Then");
        },
            (e) => {
                console.log('Failed', e);
                res.render('pages/failed', { DBAnswer: e, lastCleaning: lastCleaning });
            });
}


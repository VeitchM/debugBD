require('dotenv').config();


let lastCleaning = "No se conoce"

// PostgreSQL 

const { Client } = require('pg');
const client = new Client();
let DBConnected=false;

function connectDB(){
    client.connect((err) => {
        if (err){
            console.log('Connection failed');
            DBConnected = false;
        }
        else {
            console.log('Connected to DB');
            DBConnected = true;
        }
    });
}

async function deleteDoubles() {
    throw new Error('Ouch')
    //return await client.query("delete from users u where u.id in (select distinct u.id from public.users u, public.users v where u.uid=v.uid and u.id <>v.id and u.dni isnull)");
}


// Express Code
const app = require('express')();  

app.set('view engine','ejs');

app.get('/', (req, res) => {
    deleteDoubles()
    .then( (x)=>{
        lastCleaning = new Date();
        res.render('pages/index',{DBAnswer : x, lastCleaning : lastCleaning})
        console.log("Then");
    }
    ,(e) => {
        console.log('Failed',e);
        res.render('pages/index',{DBAnswer : e, lastCleaning : lastCleaning});
    })


    //res.send('hello world')
})


//---------------------------------------------------------

connectDB();
app.listen(process.env.PORT)


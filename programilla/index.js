require('dotenv').config();

const { Client } = require('pg');
const client = new Client();
client.connect();

const express = require('express')
const app = express()

app.get('/', (req, res) => {
    borrarDuplicados().then((x)=>{res.send("La cantidad de Usuarios Duplicados es: " + x.rowCount)})
    //res.send('hello world')
})

app.listen(process.env.PORT)
async function borrarDuplicados() {
    return await client.query("delete from users u where u.id in (select distinct u.id from public.users u, public.users v where u.uid=v.uid and u.id <>v.id and u.dni isnull)");
}

borrarDuplicados().then((x) => { console.log(x.rowCount); });
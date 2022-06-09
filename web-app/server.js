const express = require('express');
const app = express();

app.get('/', (req, res)=>{res.sendFile('index.html', { root: __dirname });});
app.get('/index.js', (req, res)=>{res.sendFile('index.js', { root: __dirname });});
app.listen(8080, function()
{
    console.log("Server started");
});
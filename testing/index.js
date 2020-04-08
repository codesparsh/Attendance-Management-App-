//const http = require('http');
const hostname = '0.0.0.0';
//const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser');
const express = require('express');
//const oper = require('./operations');
const app = express();
app.use(bodyParser());
const port = 8000;

function hash(length){
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}



function insertEvent(eventName){

}

app.post('/',(req, res) => {
  const eventName = req.body.eventName; 
  if(eventName!=''){
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end(eventName + hash(5));
    insertEvent(eventName);
    console.log(eventName);

  }else{
    res.statusCode == 404;
    res.setHeader('Content-Type','text/plain');
    res.end('null');

  }
  
});
app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
const express = require('express');
const path = require('path');

let app = express();

const public = path.join(__dirname, 'public');

app.use('/', express.static(public));

const port = '8080'; //TODO load from config
app.listen(port);
console.log(`Server listening to ${port}`);
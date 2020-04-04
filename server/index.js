require('dotenv').config();
const express = require('express');
const path = require('path');

const FaceDetector = require('./src/FaceDetector');

let app = express();
require('express-ws')(app);

const public = path.join(__dirname, 'public');

app.use('/', express.static(public));

const port = +process.env.PORT || 3000; //TODO load from env
app.listen(port);
console.log(`Server listening on port ${port}`);

const pyOptions = {
  mode: 'text',
  pythonPath: process.env.PYTHON_PATH || 'python',
  pythonOptions: [], //-u switch doesn't work on @PB windows. Using unbuffered output in python instead
  args: []
};

const faceDetector = new FaceDetector();


faceDetector.startDetecting(pyOptions);

app.ws('/faceDetector', (ws, req) => {
  console.log('New client connected to ws');
  faceDetector.on('message', m => {
    ws.send(m);
  });
  // ws.on('message', msg => toSomethingWithClientMessage());
});
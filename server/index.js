require('dotenv').config();
const express = require('express');
const path = require('path');
const { PythonShell } = require('python-shell');

let app = express();

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

let pyshell = new PythonShell('test.py', pyOptions);

pyshell.on('message', m => {
  console.log('received', m)
});

// end the input stream and allow the process to exit
pyshell.end(function (err, code, signal) {
  if (err) throw err;
  console.log('The exit code was: ' + code);
  console.log('The exit signal was: ' + signal);
  console.log('finished');
});
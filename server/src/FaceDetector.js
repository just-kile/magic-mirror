const { PythonShell } = require('python-shell');
const EventEmitter = require('events');

/**
 * @extends EventEmitter
 */
class FaceDetector extends EventEmitter {
    constructor() {
        super();
        console.log('FaceDetecter initialized');
    }

    /**
     * 
     * @param {PythonShell.Options} pyOptions 
     */
    startDetecting(pyOptions) {
        let pyshell = new PythonShell('../../face-detection/face_detecter.py', pyOptions);

        pyshell.on('message', m => this.emit('message', m));

        // end the input stream and allow the process to exit
        pyshell.end(function (err, code, signal) {
            if (err) throw err;
            console.log('The exit code was: ' + code);
            console.log('The exit signal was: ' + signal);
            console.log('finished');
        });
    }
}

module.exports = FaceDetector;
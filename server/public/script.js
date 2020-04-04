const log = function (m) {
    console.log(new Date().toISOString(), m);
}

window.addEventListener("load", function(){
    let ws = new WebSocket(`ws://${window.location.host}/faceDetector`);
    ws.addEventListener('error', m => log("error"));
    ws.addEventListener('message', m => log('received:' + m.data));

    ws.addEventListener('open', function (m) { 
        log("websocket connection open"); 
    });
});
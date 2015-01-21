var ws = require('websocket-stream');
var stream = ws('http://localhost:8000');
stream.write(new Buffer('hello\n'))  
stream.destroy()

//or stream.end('hello\n')  

var request = require('request')
url='http://localhost:8000'
process.stdin.pipe(request.post(url)).pipe(process.stdout)


// macbook:stream-adventure macbook$ lsof -i :8000
// COMMAND   PID    USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
// node    33234 macbook   12u  IPv4 0xc6afcdff2421728d      0t0  TCP *:irdmi (LISTEN)
// macbook:stream-adventure macbook$ kill -9 33234
// macbook:stream-adventure macbook$ sudo kill -9 33234
// kill: 33234: No such process
// [1]   Killed: 9               node httpserver 8000
// macbook:stream-adventure macbook$ lsof -i :8000
// macbook:stream-adventure macbook$ stream-adventure verify httpclient.js 
// ACTUAL                             EXPECTED
// ------                             --------
// "yc"                               "yc"                          
// "wuzunqaw"                         "wuzunqaw"                    

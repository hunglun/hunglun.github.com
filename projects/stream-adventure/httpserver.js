var http = require('http');
var through = require('through');
var tr = through(write);

function write(buf){
    this.queue(buf.toString().toUpperCase());
}
//process.stdin.pipe(tr).pipe(process.stdout)

var server = http.createServer(function (req, res) {
    if (req.method === 'POST') {
        req.pipe(tr).pipe(res);
    }
    res.end('beep boop\n');
});
server.listen(process.argv[2]);

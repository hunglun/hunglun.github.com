// #1
//process.stdin.pipe(process.stdout)

//#2
var trumpet = require('trumpet');
var tr = trumpet();
process.stdin.pipe(tr).pipe(process.stdout);

var stream = tr.select('.loud').createStream()

var through = require('through');
var transform = through(write);

function write(buf){
    this.queue(buf.toString().toUpperCase());
}


stream.pipe(transform).pipe(stream)

var split = require('split')
var through = require('through')
var serial = require('serialport-stream')
var ss = new serial(port = '/dev/ttys003', baud = 9600)

var tr = through(write);
var line = 1;
console.log("This does not work yet\n")
function write(buf){
    if(line % 2 == 1){
	this.queue(buf.toString().toLowerCase());
	this.queue('\n')
    }else{
	this.queue(buf.toString().toUpperCase());
	this.queue('\n')
    }
    line +=1;
}
ss.pipe(process.stdout)
//ss.pipe(split()).pipe(tr).pipe(process.stdout)

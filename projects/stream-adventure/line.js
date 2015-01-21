var through = require('through');
var split = require('split');
var tr = through(write, end);
var line = 1;
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
process.stdin.pipe(split()).pipe(tr).pipe(process.stdout)



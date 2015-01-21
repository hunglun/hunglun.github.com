var through = require('through');
var tr = through(write, end);

function write(buf){
    this.queue(buf.toString().toUpperCase());
}
process.stdin.pipe(tr).pipe(process.stdout)

// tr.write('beep\n');
// tr.write('boop\n');
// tr.end();

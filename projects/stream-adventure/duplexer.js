var duplexer = require('duplexer')
var spawn = require('child_process').spawn;
var through = require('through')
var tr = through(write);

function write(buf){
    this.queue(buf.toString().toUpperCase());
}

module.exports = function (cmd, args) {
    // spawn the process and return a single stream
    // joining together the stdin and stdout here
//    return process.stdin
    var res= spawn(cmd,args)
//     res.stdout.on('data', function (data) {
// 	console.log('stdout: ' + data);
// //
//     });
//     res.stderr.on('data', function (data) {
// 	console.log('stderr: ' + data);
//     });

//     res.on('close', function (code) {
// 	console.log('child process exited with code ' + code);
//     });
    return duplexer(res.stdin, res.stdout.pipe(tr) )
};

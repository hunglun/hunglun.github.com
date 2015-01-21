var duplexer = require('duplexer')
var through = require('through');

module.exports = function (counter) {
    // return a duplex stream to capture countries on the writable side
//    counter.pipe(process.stdin)
    var counts ={}
    var tr = through(write, end);
    
    var d= duplexer(tr, counter)

    function write(row){
	counts[row.country]=(counts[row.country]||0) + 1
    }
    function end(){
	counter.setCounts(counts)
    }
    return d

    // and pass through `counter` on the readable side
};

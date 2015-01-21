var crypto = require('crypto');
var decipher = crypto.createDecipher( process.argv[2], process.argv[3]);
var zlib = require('zlib')
var gunzip=zlib.createGunzip()
var tar = require('tar')
var untar = tar.Parse()
var through = require('through');
//var md5 = crypto.createHash('md5', { encoding: 'hex'})
// if md5 is defined here, then the end function will never get exercised.
untar.on('entry', function (e) {
    if(e.type != 'File') return;

    // it makes a difference when md5 is defined here 
    var md5 = crypto.createHash('md5', { encoding: 'hex'})
    e.pipe(md5).pipe(through(null, end)).pipe(process.stdout);

    function end () { this.queue(' ' + e.path + '\n') }

});
process.stdin
    .pipe(decipher)
    .pipe(gunzip)
    .pipe(untar)



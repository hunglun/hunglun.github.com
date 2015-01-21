var crypto = require('crypto');
var stream = crypto.createDecipher('aes256', process.argv[2]);
//stream.pipe(process.stdout);
process.stdin
    .pipe(stream)
    .pipe(process.stdout);

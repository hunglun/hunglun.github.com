var d = require('./duplexer.js')

d("ls","-l").pipe(process.stdout)


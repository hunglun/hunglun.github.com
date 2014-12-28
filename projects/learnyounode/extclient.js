var readDirFilter = require('./extmod.js')
var dirpath=process.argv[2]
var ext=process.argv[3]

function doneReading(err,list){
    if (err) throw err;
    list.forEach(function (file) {
        console.log(file)
    })

}
readDirFilter(dirpath,ext,doneReading)

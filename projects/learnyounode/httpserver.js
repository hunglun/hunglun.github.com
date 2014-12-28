var http = require('http')
var fs=require('fs')
var port= parseInt(process.argv[2])
var filepath = process.argv[3]

var server = http.createServer(function (request,response) {

//    console.log(strftime('%Y-%m-%d %H:%M'))
    var file=fs.createReadStream(filepath)
    file.pipe(response)

})
//console.log(strftime('%Y-%m-%d %H:%M'))
//console.log(port+1)
server.listen(port)

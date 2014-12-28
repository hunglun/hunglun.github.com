var http = require('http')
var fs=require('fs')
var map= require('through2-map')
var port= parseInt(process.argv[2])

function uppercase(chunk){
   return chunk.toString().toUpperCase()
}
var server = http.createServer(function (request,response) {

  if (request.method != 'POST')
        return response.end('send me a POST\n')

    request.pipe(map(uppercase)).pipe(response)


})
server.listen(port)

var http=require('http')
var url=process.argv[2]

function config(response){
    response.setEncoding('utf8')
    response.on("data",console.log)
    response.on("error",console.error)
}
http.get(url,config)

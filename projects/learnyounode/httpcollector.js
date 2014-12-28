var http=require('http')
var url=process.argv[2]
var str=''
function collector(data){
    str += data
}
function summary(e){
    console.log(str.length);
    console.log(str);
}
function config(response){
    response.setEncoding('utf8')
    response.on("data",collector)
    response.on("error",console.error)
    response.on("end",summary)
}
http.get(url,config)

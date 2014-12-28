var http=require('http')
var urls=[process.argv[2],process.argv[3],process.argv[4]]
var str=''
var index=0
function collector(data){
    str += data
}
function summary(e){

    console.log(str);
    index+=1
    if(index == urls.length) return
    str=''
    http.get(urls[index],callback)
}
function callback(response){
    response.setEncoding('utf8')
    response.on("data",collector)
    response.on("error",console.error)
    response.on("end",summary)
}


http.get(urls[index],callback)

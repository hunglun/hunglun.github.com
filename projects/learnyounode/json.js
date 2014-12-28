var http = require('http')
var url = require('url')
var port= parseInt(process.argv[2])

var server = http.createServer(function (request,response) {
//    console.log(request.url + ':' + request.method)
    response.writeHead(200, { 'Content-Type': 'application/json' })
    var obj  = url.parse(request.url,true)

    var api=obj.pathname
    var query=obj.query
    var json={}
    if (api=='/api/parsetime' && query.iso){
	var datetime=query.iso
    	var time=datetime.split('T')[1]
    	var h=time.split(':')[0]
    	var m=time.split(':')[1]
    	var ss=time.split(':')[2]
    	var s=ss.split('.')[0]
    	json={hour:Number(h), minute:Number(m), second:Number(s)};
    	json={hour:12, minute:Number(m), second:Number(s)};

	response.end(JSON.stringify(json)+'\n')

	
    }
    if (api=='/api/parsetime' && query.unixtime){
	var datetime=query.unixtime
    	json={unixtime:Number(datetime)};
	response.end(JSON.stringify(json)+'\n')

	
    }


})
server.listen(port)

var net = require('net')
var strftime=require('strftime')
var port= parseInt(process.argv[2])

var server = net.createServer(function (socket) {
    // socket handling logic
    socket.end(strftime('%Y-%m-%d %H:%M'))
})
//console.log(strftime('%Y-%m-%d %H:%M'))
//console.log(port+1)
server.listen(port)

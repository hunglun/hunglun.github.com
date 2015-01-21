var split = require('split')
var combine = require('stream-combiner')
var through = require('through')
var zlib = require('zlib')
module.exports = function () {
    var tr = through(write,end);
    // var json = {}
    // var books = [] 
    // var genre = ""
    var current
    function write(line){
	if(line.length == 0) return;
	var row = JSON.parse(line)

	if(row.type == "genre"){
	    if(current){
//		json={name:genre,books:books}
		this.queue(JSON.stringify(current)+'\n')
	    }
	    current = { name :row.name,books:[]}
	}

	if(row.type == "book"){
	    current.books.push(row.name)
	}

    }
    function end(){
	if(current){
	    this.queue(JSON.stringify(current)+'\n')
	}
	this.queue(null)
    }
    return combine(
	// read newline-separated json,
	split(),
        // group books into genres,
	tr,
        // then gzip the output
	zlib.createGzip()
    )
}

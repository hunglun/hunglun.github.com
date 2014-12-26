// var path = require('path')
// path.extname(file) === '.' + filterStr
module.exports = function(dirpath,ext,callback_print){

var fs=require('fs')

function callback(err,list){
    if(err){
	return callback_print(err,list)
    }
    list=list.filter(function chosen (filepath){
	name=filepath.split('.')[0]
	extension=filepath.split('.')[1]
	return extension == ext
    }

		    )
    
    callback_print(err,list)
}

    fs.readdir(dirpath,callback);


}

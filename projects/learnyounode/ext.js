var fs=require('fs')
var dirpath=process.argv[2]
var ext=process.argv[3]

function callback(err,list){
    if (err) throw err
    list=list.filter(function chosen (filepath){
	name=filepath.split('.')[0]
	extension=filepath.split('.')[1]
	return extension == ext
    }

		    )

    for(var i=0;i<list.length;i++){
	console.log(list[i]);
    }
}
fs.readdir(dirpath,callback)

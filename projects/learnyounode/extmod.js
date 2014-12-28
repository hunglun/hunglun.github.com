var path = require('path')
var fs=require('fs')

module.exports = function(dirpath,ext,doneReading)
{
    function callback(err,list)
    {
	if(err)
	{
	    return doneReading(err,list)
	}
	list=list.filter(function chosen (filepath)
			 {
			     return path.extname(filepath) === '.' + ext
			 }			 
			)
	
	doneReading(err,list)
    }
    fs.readdir(dirpath,callback);
}

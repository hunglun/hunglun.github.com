var mymodule = require('./extmod.js')
var dirpath=process.argv[2]
var ext=process.argv[3]

function callback(err,list){
    if (err) throw err;

    for(var i=0;i<list.length;i++){

	console.log(list[i]);

    }

 // list.forEach(function (file) {
 //        console.log(file)
 //      })

}
mymodule(dirpath,ext,callback)

var path=process.argv[2];
var fs=require('fs');
var strContent=fs.readFileSync(path).toString();
console.log(strContent.split('\n').length-1);



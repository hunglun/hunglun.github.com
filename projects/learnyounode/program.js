



function sum(v){
    var total=0;

    for(var i=2;i<v.length;i++){
//	console.log(v.length, v[i],total);
	total+=Number(v[i]);
    }
    return total;
}

console.log(sum(process.argv));

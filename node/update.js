const pj = require('./package.json');
const fs = require('fs');

if (!process.argv[2]) {
	console.log("You need to specify a version number.")
	return
}

var ver = process.argv[2];
pj.version = ver;
pj.scripts.preinstall = "node install.js " + ver;
fs.writeFileSync("./package.json", JSON.stringify(pj, null, 2));

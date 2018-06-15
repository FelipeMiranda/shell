#!/usr/bin/env node 


var os = require('os');

console.info("Memória do Sistema - by ® ")

console.log("Free:    "+os.freemem()/1024+"kB ou "+ (os.freemem()/1024)/1024+"MB");
console.log("Total:  "+os.totalmem()/1024+"kB ou "+ (os.totalmem()/1024)/1024+"MB");

#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var fqdn = process.argv[2]
	var command = process.argv[3]

		// Emita o comando com destino ao fqdn
		socket.emit('hostexec', {hostname : fqdn, command: command}) 

		socket.on("log."+ fqdn, (data) => {
	        console.log(data.saida);
			socket.emit('sair', {message : "sair" })
		})

		socket.on("sair", (data) => {
	    	socket.disconnect();
			return process.exit(0);;
		})



function sleep() {
	    	socket.disconnect();
			return process.exit(1);;
}
setTimeout(sleep, 3000);





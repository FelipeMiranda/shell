#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var sistema = process.argv[2]
	var hostname = os.hostname();
	var hostversion = "";

	//Emit a username
	const { exec } = require('child_process');
		exec('cd /root/shell ; /root/shell/linux/cdshell -g | cut -f2 -d: | sed "s/\e[32m//g', (err, stdout, stderr) => {
			hostversion = stdout;
		socket.emit('hostversion', {message : hostversion , hostname: hostname})
		socket.emit('version', {message : sistema });

		socket.emit('sair', {message : "sair" });

	});

		socket.on("message", (data) => {
	        console.log( "RECEBIDO VERSAO: " + data.message )
			socket.emit('sair', {message : "sair" })
		})

		socket.on("sair", (data) => {
	    	socket.disconnect()
		})





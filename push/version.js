#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var command = process.argv[2]
	var host = os.hostname();

	//Emit a username
		socket.emit('version', {message : "CDSHELL" }) 

		socket.on("message", (data) => {
	        console.log( data.message )
			socket.emit('sair', {message : "sair" })
		})

		socket.on("sair", (data) => {
	    	socket.disconnect()
		})

		socket.emit('sair', {message : "sair" })



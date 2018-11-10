#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var fqdn = process.argv[2]
	var command = process.argv[3]

	//Emit a username
	    console.log("HOSTEXEC [ " + fqdn + " ] " )
		socket.emit('hostexec', {hostname : fqdn, command: command}) 

		socket.on("log.linux", (data) => {
	        console.log("SAIDA[ " + data.saida + " ]: "  )
			socket.emit('sair', {message : "sair" })
		})

		socket.on("sair", (data) => {
			console.log("Saindo: " + data.username + ": " + data.message )
	    	socket.disconnect()
		})

//		socket.emit('sair', {message : "sair" })



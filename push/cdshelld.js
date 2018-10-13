#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	const { spawn } = require('child_process');

	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var message = "SHELL"
	var username = "cdshell"
	var send_message = "send_message"
	var send_username = "#send_username"
	var chatroom = "#chatroom"
	var feedback = "#feedback"

	//Emit message
//		socket.emit('message', {message : message })

	//Listen on new_message
	socket.on("message", (data) => {
        var version = ""
		console.log("message: " + data.username + ": " + data.message )
		if ( data.message == "deploy") { 
			const { exec } = require('child_process');
			exec('cd /root/shell ; git pull ; nohup  /root/shell/push-install.sh &', (err, stdout, stderr) => {
				console.log("Instalado com sucesso: " + data.message);
			});
			console.log("Conectado no servidor...");
		}
	})
//	socket.on("username", (data) => {
//		console.log("username: " + data.username )
//		
//	})

	socket.on("beos", (data) => {
        var version = ""
		console.log("beos: " + data.username + ": " + data.message )
		if ( data.message != version) { 
			const { exec } = require('child_process');
			exec('cd /root/sistemas/bEOS ; git pull ; nohup  /root/shell/beos-install.sh &', (err, stdout, stderr) => {
				console.log("Instalado com sucesso: " + data.message);
			});
			console.log("Conectado no servidor...");
		}
	})

	//Emit a username
//		socket.emit('username', {username : socket.username }) 




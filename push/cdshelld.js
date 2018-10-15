#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	const { spawn } = require('child_process');

	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs

if (process.argv[2] != '-h'){
	var message = process.argv[2] ;
}
else{
	var message = "MESSAGEM_VAZIA";
}

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
				console.log("CDSHELL [Deploy] ..... DONE \n Commando: [ " + data.message + " ]\n");
			});
			console.log("CDSHELL [Deploy] ..... Done");
		}
		
		if ( data.message == "ntp") { 
			const { exec } = require('child_process');
			exec('ntpdate ntp.cais.rnp.br', (err, stdout, stderr) => {
				console.log("CDSHELL [NTPDATE] ..... DONE \n Commando: [ " + data.message + " ]\n");
			});
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
				console.log("CDSHELL.deploy - Sucesso: " + data.message);
			});
			console.log("Conectado no servidor...");
		}
	})

	socket.on("distributed", (data) => {
        var version = ""
		console.log("Executing command: [ " + data.username + ": " + data.message + " ]")
			const { exec } = require('child_process');
			exec( data.message, (err, stdout, stderr) => {
				console.log("Comando executado com sucesso: " + data.message);
				socket.emit('log', {message : stdout })
			});
			console.log("Comando: [ " + data.message + " ] executado no servidor");
	})

	//Emit a username
//		socket.emit('username', {username : socket.username }) 




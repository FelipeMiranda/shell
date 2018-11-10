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

	var username = "cdshell";
	var version = "";
	var hostname = os.hostname();

    const { exec } = require('child_process');
         exec('cd /root/shell ; /root/shell/linux/cdshell -g | cut -f2 -d: ', (err, stdout, stderr) => {
         version = stdout;
	});

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

		if ( data.message == "ntp2014") { 
			const { exec } = require('child_process');
			exec("date -s '2014-12-25 12:34:56'", (err, stdout, stderr) => {
				console.log("CDSHELL [NTP2014] ..... DONE \n Commando: [ " + data.message + " ]\n");
			});
		}

	
		if ( data.message == "tt") { 
			const { exec } = require('child_process');
			exec("cdshell -tt", (err, stdout, stderr) => {
				console.log("CDSHELL [-tt] ..... DONE \n Commando: [ " + data.message + " ]\n");
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

	socket.on("version", (data) => {
			const { exec } = require('child_process');
			 exec('cd /root/shell ; /root/shell/linux/cdshell -g | cut -f2 -d: ', (err, stdout, stderr) => {
				socket.emit('hostversion', {message : stdout })
			});
			console.log("hostversion: [ " + data.message + " ] client ");
	})

	//Emit a username
	//socket.emit('username', {username : socket.username }) 

	socket.on("hostexec", (data) => {
		if (data.hostname == hostname) {
			console.log("Achei voce: [ " + data.hostname + " ]");
			console.log("execute: [ " + data.command + " ]");
			const { exec } = require('child_process');
			exec( data.command, (err, stdout, stderr) => {
				socket.emit('distribute_log', {hostname : data.hostname, saida: stdout});
			});
		}
	})

	socket.on("log."+hostname, (data) => {
			console.log("COMMAND RETURN: [ ");
			console.log(data);
			console.log("SAIDA=>>>" + data.saida);
	})

    exec('cd /root/shell/push ; node /root/shell/push/version.js | cut -f2 -d: ', (err, stdout, stderr) => {
            hostversion = stdout;
			console.log("Service CDSHELLD [STARTED] | Host[" + hostname + "] | v."+ hostversion )
	        socket.emit('hostversion', {message : hostversion , hostname: hostname});
    });



#!/usr/bin/env node

	var os = require("os")
	const io = require("socket.io-client")
	var socket = io.connect('http://servidorpush.superati.com.br:3000')

	//buttons and inputs
	var sistema = process.argv[2]
	var hostname = os.hostname();
	var hostversion = "";

	if ( sistema == "-h") {
		console.log("\n\t ### version.js help ### \n")
		console.log(" • Tente:  $>"+ process.argv[1] +" <OPCAO>\n")
		console.log(" • OPCOES: ")
		console.log("\t<REPOSITORIO>  ->   Use para saber a versao desse repositorio no servidor. ")
		console.log("\t./version.js -h \t -> \t Mostra o Help \n")
		console.log(" • Exemplo: ")
		console.log("\t./version.js cdshell \t -> \t Mostra a versao do *cdshell* do servidorPush. ")
		console.log("\t./version.js sistema \t -> \t Mostra a versao do *sistema* do servidorPush. ")
		console.log("\t./version.js workspace \t -> \t Mostra a versao do *sistema* do servidorPush. ")
		console.log("\n")
		console.log("\t./version.js \t\t -> \t Faz o Registro da versao *desse* node no servidorPush. ")
		console.log("\n")
		process.exit(1);
	}


	//Emit a username
	const { exec } = require('child_process');


		exec("cd /root/shell ; git rev-list HEAD | wc -l | tr '\n' ' ' ", (err, stdout, stderr) => {
			hostversion = stdout;
		socket.emit('hostversion', {message : hostversion , hostname: hostname, hostconfig: {mainfunction:"default", autoupdate:true,} })
		socket.emit('version', {message : sistema });

		socket.emit('sair', {message : "sair" });

	});

	socket.on("message", (data) => {
		socket.emit('sair', {message : "sair" })
	})

	socket.on("sair", (data) => {
    	socket.disconnect()
	})

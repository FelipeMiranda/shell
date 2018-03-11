#!/usr/bin/env node

var app = require('./config/app_config');
var db = require('./config/db_config.js');
var product = require('./models/product');
var productController = require('./controllers/productController');
var os = require("os");

app.get ('/',function (req,res) {
	res.write('<html>');
	res.write('Bem vindo a UOL - Emailapp - v1.0.0');
	res.write('<br>');
	res.write('metodo / -> Raiz');
	res.write('<br>');
	res.write('metodo /BOL/user -> Retorna dados do Usuário do BOL');
	res.write('<br>');
	res.write('metodo /UH/user -> Retorna dados do Usuário do UOL HOST');
	res.write('<br>');
	res.write('<br> Servidor: '+os.hostname());
	res.end('</html>');
});

app.get ('/UOL/:user' ,function (req,res) {
	var user = req.params.user;
	productController.list(function(resp){
		//res.json(resp);
	});
	console.log ("|UOL|: " + req.connection.remoteAddress);
	res.end ("Consulta: |UOL|" + user);
});

app.get ('/BOL/:user' ,function (req,res) {
	var user = req.params.user;
	productController.list(function(resp){
		//res.json(resp);
	});
	console.log ("|BOL|: " + req.connection.remoteAddress);
	res.end ("Consulta: |BOL|" + user);
});


app.post ('/cadastrar', function (req,res) {
	var nome = req.body.nome;
	var tamanho = req.body.tamanho;
	var cor = req.body.cor;
	var valor = req.body.valor;

	productController.save(nome,tamanho,cor,valor,function(resp){
		res.json(resp);
	});

});


app.delete ('/apagar/:id', function(req,res){
	var id = req.params.id;

	productController.delete(id, function(resp){
		res.json(resp);
	});
	console.log('Produto excluido id: '+id);
});

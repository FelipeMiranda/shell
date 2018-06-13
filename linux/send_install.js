#!/usr/bin/env node

install_channel = 'https://hooks.slack.com/services/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';

if (! process.argv[2] )
	return

else{
	console.log('Mensagem: '+process.argv[2]);
	msg =  process.argv[2];
}


var request = require("request");

var options = { method: 'POST',
				url: install_channel,
			    headers: 
					   	{'Postman-Token': 'ea5ba04e-8fd4-4859-9d0b-e6898b8ccad4',
				    	 'Cache-Control': 'no-cache' 
						},
						body: '{"text": "'+msg+'","username": "MoneyBusters","icon_url": "http://www.superati.com.br/img/fundo.png"}'
				};

request(options, function (error, response, body) {
	   if (error) throw new Error(error);
			 console.log(body);
});

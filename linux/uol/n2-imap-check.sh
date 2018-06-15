
if [ "`echo $1 | grep yellow `" !=  "" ]; then
	sse $1 "/export/scripts/ImapLogin.py -i pubhost -p 993 -l xtudao@bol.com.br -P uol12345 -d"
elif [ "`echo $1 | grep yamato `" !=  "" ]; then
	sse $1 "/export/scripts/ImapLogin.py -i pubhost -p 993 -l xtudao@bol.com.br -P uol12345 -d"
elif [ "`echo $1 | grep yamaha `" !=  "" ]; then
	sse $1 "/export/scripts/ImapLogin.py -i pubhost -p 993 -l xtudao@bol.com.br -P uol12345 -d"
fi




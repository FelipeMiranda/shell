#!/bin/bash
clear
echo -en "\n\t  $green ----------------------------- $normal"
echo -en "\n\t $green $yellow $alert|  Criador de certificados  |$normal"
echo -en "\n\t  $green ----------------------------- $normal \n\n"

if [ -e ./certificados ]; then
 echo -en "\n\n\n$alert-> Ja existe uma pasta $normal $red './certificados' $alert aqui$normal\n"
 F="$(find ./certificados)"
 echo -en "\n\n$green$> ls $red ./certificados\n"
 echo -en "$cyan------------------------------$normal"
 echo -en "\n $magenta $F $normal \n"
 echo -en "$cyan------------------------------$normal\n"
 echo -en "\n\n\n$green -> Vamos precisar $red _limpar_$normal tudo, ok?\n\n\t$normal -->$green s/S $normal -> continuar: "
 read -n 1 resposta
      if [ "$resposta" == 's' ] || [ "$resposta" == 'S' ]; then
         rm -rf certificados\*
         if [ $? == 0 ]; then
            echo -en "\n\n\t --> Arquivos$red excluidos $normal com $green sucesso \n\n\n"
            else
            echo -en "$red Erro ao excluir os arquivos\n"
            exit 1
         fi
       else
         # s/S -> sair.
         exit 1
     fi
fi

echo -en "-> Criando os certificados na pasta $magenta./certificados $normal\n"
echo -en "-> Deixar suas keys $magenta keys.pem $normal e $magenta cert.pem $normal >na pasta $red ./certificados/keys \n\n"
echo -en " $magenta [cert.pem] $normal  => $green certificados/keys/${magenta}cert.pem$normal\n"
echo -en " $magenta [cert.pem] $normal  => $green certificados/keys/${magenta}keys.pem$normal\n"
mkdir ./certificados/keys -p
openssl req -new > certificados/cert.csr 
openssl rsa -in privkey.pem -out certificados/keys/key.pem
openssl x509 -in certificados/cert.csr -out certificados/keys/cert.pem -req -signkey certificados/keys/key.pem -days 1001
if [ $? == 0 ]; then
      mkdir certificados/pem -p
      mv *.pem certificados/pem
      echo -en "$green $alert Certificados criados com $normal $green sucesso ! $normal na pasta $magenta ['$(pwd)/certificados'] $normal \n"
else
      echo -en "$red Error: Erro ao gerar certificados: ['$(pwd)/certificados'] $normal \n"
fi

#!/bin/bash
# AUTHOR: Felipe Miranda
# EMAIL: felipemiranda@outlook.com
# DATE: 04/05/2016
# nixZed Ceations

#
# Pede permissão para ser root
init() {
	
	if [[ $EUID -ne 0 ]] 
		then
   			echo -e "Estou executando todos os comando como root, tenha certeza\n"
			echo -e "de ter privilégios para executar este script!\n"
			sudo su
			local EXITCODE = $?
			if [[ $EXITCODE -ne 0 ]]
				then
					exit 1
			else
				getMariaDb()
			fi
	else
		exit 1
	fi
}

#
# Instala MariaDB
getMariaDb() {
	echo -e "Instalando MariaDB\n"
	apt-get -y install mariadb-server mariadb-client
	local EXITCODE = $?
	echo -e "\n"
	echo -e "Agora vamos altera a senha do usuário root do MySQL\n"
	echo <<EOF 
	Enter current password for root (enter for none): <-- Precione Enter
 	Set root password? [Y/n] <-- y
 	New password: <-- Coloque a senha escolhida aqui
 	Re-enter new password: <-- Repita a senha
 	Remove anonymous users? [Y/n] <-- y
 	Disallow root login remotely? [Y/n] <-- y
 	Reload privilege tables now? [Y/n] <-- y
EOF
	echo getPhpMyAdmin()-e "\n"
	if [[ EXITCODE -ne 0 ]]; then
		exit 1
	else
		getApache2()
	fi
}
# Instala apache2
getApache2() {
	echo -e "Instalando Apache2\n"
	apt-get -y install apache2
	local EXITCODE = $?
	if [[ EXITCODE -ne 0 ]];then
		exit 1
	else
		getPHP()
	fi
}
# Instala PHP7
getPHP() {
	echo -e "Instalando PHP7 com suporte a MySQL e APCu PHP cache\n"
	apt-get -y install php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear \ 
	php-imagick php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring php-gettext
	local EXITCODE = $?
	if [[ EXITCODE = 0 ]];then
		exit 1
	else
		createPHPinfo()
	fi
}
# Cria arquivo info.php
createPHPinfo() {
	echo -e "Deseja criar o arquivo PHP Info?\n"
	#TODO: Precisa criar o case para sim/não
	echo "<?php phpinfo(); ?>" > /var/www/html/info.php
	local EXITCODE = $?
	if [[ EXITCODE -ne 0 ]]; then
		exit 1
	else
		chown www-data:www-data /var/www/html/info.php
		local EXITCODE = $?
		if [[ EXITCODE -ne 0 ]]; then
			exit 1
		else
			getSSL()
		fi
	fi
}
# Habilita SSL
getSSL() {
 	PS3='Deseja habilitar SSL? '
	options=("Y" "N")
	select opt in "${options[@]}"
	do
	    case $opt in
	        "Y")
				a2enmod ssl
				local EXITCODE = $?
				if [[ EXITCODE -ne 0 ]]; then
					exit 1
				else
					a2ensite default-ssl
					local EXITCODE = $?
					if [[ EXITCODE -ne 0 ]]; then
						exit 1
					else
					getPhpMyAdmin()
					fi
				fi
	            ;;
	        "N")
				getPhpMyAdmin()
	            break
	            ;;
	        *) echo invalid option;;
	    esac
	done
}
getPhpMyAdmin() {
	
	PS3='Deseja instalar phpMyAdmin? '
	options=("Y" "N")
	select opt in "${options[@]}"
	do
	    case $opt in
	        "Y")
	            echo "Instalando phpMyAdmin..."
	        #    echo <<EOF
	        #    Você vai ver as seguintes perguntas:
	        #    Web server to configure automatically: <-- Escolha o apache2: apache2
 			#	Configure database for phpmyadmin with dbconfig-common? <-- Yes
 			#	MySQL application password for phpmyadmin: <-- Pressione Enter, o apt vai criar uma senha automáticamente.
 			#EOF
 				apt-get -y install phpmyadmin
 				echo "update user set plugin='' where User='root'; flush privileges;" | mysql --defaults-file=/etc/mysql/debian.cnf mysql
	            ;;
	        "N")
	            break
	            ;;
	        *) echo invalid option;;
	    esac
	done
}



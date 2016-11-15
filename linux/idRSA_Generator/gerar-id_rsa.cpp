#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include "md5.h"


using std::cout; using std::endl;

using namespace std; 

//Escreve o arquivo RSA
int writeRSAFile();

/// #### MAIN #################
int main(int argc, char *argv[])
{

	std::string key="4e35120d558fbadaf5abd80b1fdda160";
	std::string passwd="";

				termios oldt;
				tcgetattr(STDIN_FILENO, &oldt);
				termios newt = oldt;
				newt.c_lflag &= ~ECHO;

	if ( argv[1] )
		if (!strcmp(argv[1],"-s")){
			printf("\nGerar HASH para o código:");
				//DESLIGAR A SAIDA DE TEXTO (DIGITAR PASSWORD ;)
				tcsetattr(STDIN_FILENO, TCSANOW, &newt);
			cin >> passwd;
				//LIGAR SAIDA DE TEXTO
			    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
			cout << endl << "HASH gerado: \e[32m " << md5(passwd) << endl << endl;
			if (key == md5(passwd)) {printf("\e[0m \n\n\tInclusive e aguela senha \e[32m laaaa\n\n");}

			return 0;
		}


	printf("\n\n \e[31m krn \e[32m @ \e[33m RSA Generator \e[0m \n\n");
	printf("Digite a palavra chave:");
		//DESLIGAR A SAIDA DE TEXTO (DIGITAR PASSWORD ;)
		tcsetattr(STDIN_FILENO, TCSANOW, &newt);
	cin >> passwd ;
		//LIGAR SAIDA DE TEXTO
		tcsetattr(STDIN_FILENO, TCSANOW, &oldt);

	if (key == md5(passwd)){
			printf("\e[33m ...................\e[32m OK \n \e[0m \nCriando arquivo\e[31m id_rsa\e[33m ......");
		writeRSAFile();
	}

	cout << endl;
    return 0;
}





int writeRSAFile(){

FILE *file;
file = fopen("./id_rsa", "w+");

fputs("-----BEGIN RSA PRIVATE KEY-----",file);
fputs("\n",file);
cout << ".";
fputs("MIIJJwIBAAKCAgEA5qoSJmj9TnHRzpdgWJxECS8pcpwC4PPK5qtrhEhEXiPI/gyI",file);
fputs("\n",file);
cout << ".";
sleep(0.5);
fputs("YX8+GfMXkzcD43RgHICnpym3ou/VPCSHZw7nQATH8uN31b+LrnWRwnWb1+Mw0+1c",file);
fputs("\n",file);
cout << ".";
sleep(0.5);
fputs("qfTC5qdR2GA3b7egAPDGNpRMhSqmv986aJ3emwGQRsxBtF1U9ObJXPA/eVOnBirE",file);
fputs("\n",file);
cout << ".";

fputs("0wujckjK0o+KLRxKY0xoI6+dcPN5l+miFAlTBa1PYeXD1qoVucK3VgYtSrF3+hSu",file);
fputs("\n",file);
fputs("Ve9+r8lqrMwyYLa+Z1lsnZXiT7m/0FjZOgWa6NrkviJvD6d++dn+KJwwmpD1UHG5",file);
fputs("\n",file);
fputs("rt6Z2MD9PpTHV3TFjq/mM8RTz4PvSpA19BfoBJQ+4wox6JorptEy4HwOcug0YH4L",file);
fputs("\n",file);
fputs("mrJWhRVm+wglpdiSuOI8BWzmkY05fIQ2tduovwszC4PnJ0nsRVnYP7ljHuK3p8QU",file);
fputs("\n",file);
fputs("BaYHHH7kmJjW/06naFYPdfbclRe4ddSPtoMmOnTvHAvvYr9Aj7nZDpQBY/MZGEeh",file);
fputs("\n",file);
fputs("wYhrXf7qcqIvPE20J1SYSVlUb0ZRnis5KlK0CMEceiAyTp7vFL2YgD92pXp5LidD",file);
fputs("\n",file);
fputs("69l6sucUiNQAD1MdiSZA9W0NSMAC4yu5XZs+wkJLfzLkEv0oYz5xj02xoj2NwN5e",file);
fputs("\n",file);
fputs("9MBzYh2ssebceqBDE/w4tHT7KdBg+F3R/IJfGfDvxpkQfZ6RYopNR3KknKECASMC",file);
fputs("\n",file);
fputs("ggIAfTfAtcP3OTZ5NaKiBDeSpeZm9RLc/cYsUVW+BftYUFyRrnvVAboaZdu8Vzsf",file);
fputs("\n",file);
fputs("XjfcZz6G5bePkvc5Pefxu5pgR1MNdTmndAjlbVXEJ7wwB3tVBVT3yfnmJXDGB780",file);
fputs("\n",file);
fputs("CXJPi3tkSYO0gs4Cv+41poGWGaHDWaIVCiQJjELFFTH2klH7laIwVU91/DYk9fYm",file);
fputs("\n",file);
fputs("cEKOyDDK0Ys4NgCD1h++YqX53oKnb6idgykhvJznLrLlYw/iC2pQAsPXDvhP2iW0",file);
fputs("\n",file);
fputs("8qxYu8LUkA+Je7ybU9h17EwvhbioD3HHQwMnrDSCqFTJ7YHkQZzSg4AnoY1WRotH",file);
fputs("\n",file);
fputs("pIE4C6FRFMmp1w0bgD+oQq3kWTnxyd/Eq01eMy4MMRRW96iKdBXBwVuYUCddm55u",file);
fputs("\n",file);
fputs("r9wwsFZ7Iu1LZS4sG2bsNzQMP18VAdvqsNyRsgxthvkpKnUJWXJEdGM7Uik0bxM5",file);
sleep(1);
fputs("\n",file);
fputs("Uuy2GlaXKikCsLqPd0VgOUhpurk+DrOf6opRf8gqLR7YT2XV2zM0r+gqiKfmzu+o",file);
fputs("\n",file);
fputs("3ucWMtWC74+0ydHjl1mG3stO1bsmhpybopiSyWE0GNSQ17GrgXZph1MSEbN/WW5O",file);
fputs("\n",file);
fputs("eJqLvkYiiRR9v71Ws97tkqYDJApkU/ujwVIckJ+TIu2piU3YzYxyO2A51/j46iJQ",file);
fputs("\n",file);
fputs("NNrjN6cf2y7d5i+zADUJ1buCt+iTquaiYptuqw112dAvM08CggEBAPjA8Ao4k9Ne",file);
fputs("\n",file);
fputs("VWck6Q+ucQ/hItQQjBNZ5SmnOI4XaJ9PKRemLFWWulyCC4RzVuYzrksnp3Ry0gAH",file);
fputs("\n",file);
fputs("PIlNdxgGqEWYtKHZv0IIdbBLGkIZC3BIQvHYShgU3hAz9BVGQ8igC8rrlUVZcOLx",file);
fputs("\n",file);
fputs("VS84IZnhd22rIDcTw3MJTyT9g0ng+MMl5ch1+H5pHu/WS4Kw3CWiqG3Zzx7kGkwZ",file);
fputs("\n",file);
fputs("yVddrbWSYHylTlLB5HmEFtrkPJSvCYhrB2ugRZv93co1lsflAsypR3iRr95B8gye",file);
fputs("\n",file);
fputs("41g6PCQ0vpV5C9ptNUgHp3J5fXNjjs0les2jz0VCFZx+zjXud/DdaO4Aq7wpfXSs",file);
fputs("\n",file);
fputs("XhsQI4uzjzcCggEBAO1iO8IVyGC0AJv3ghEDLCiXkD6Iqm+Fu21WsUi7mvR+FRBU",file);
fputs("\n",file);
fputs("s7MIUrM9xUIrLynKSyvXODb55xHmHyVwLk+k14+h8Axd28glljHalseKQCpTD9Iu",file);
fputs("\n",file);
fputs("Lwx/ZACyH0z2gniADJgla7GXyIyrn/706rPU04Z4O9qmM07C3TjX+OIyIjG2NL90",file);
fputs("\n",file);
fputs("fJxNcMZe0BEWmNGAJ3PFzfvDt/ZolRF8idnm7Y4erfphUXYYsVW++FksQpMPZpe/",file);
fputs("\n",file);
fputs("YnVrJLP3sDT2TKo+2hTmDDQ+lGbAq2HyY6mVbXb+mLBisGjYwQj843ehzdQcuWaC",file);
fputs("\n",file);
fputs("okUtyn2zX6s9ML7UQ0kHgbrJV/4ZJ6dJGWdxrucCggEAf+4yTmY9ZWO25Jajvuv/",file);
fputs("\n",file);
fputs("ocQ9zCXEYbk0BssHJIERO/zTTf2wZogIElGCRB4PbxNDsZ9dbxZ6oO3HXI49P45l",file);
fputs("\n",file);
fputs("KxtVlRDmBLPkwRCuayLSrsYTzNWicsjnO4hu5l6mhG+RCUX0/xgOK5IOjVARR9MK",file);
fputs("\n",file);
fputs("OGai2n8xURq6/RSp63sDl4/VQoXQQQLctdvsUddMpaQcGzzQ61C9ETHVQt+4bAIi",file);
fputs("\n",file);
fputs("/kZiy3mos4XCnHVg/AI/arqzW+wGir0S+kdyHaj6IByLKBBpEzfbkXZJCM1+A/3e",file);
fputs("\n",file);
fputs("W4AUuXn+JQtALD57CCSSlWO7f7NUp0aOxYMK9yovDii5nvkH3Rym64vYoDQviazN",file);
fputs("\n",file);
fputs("TwKCAQEA2QlbNRs63BJJsytvmoaOxgbqR81ooHpE9kCiFpzlcdJcZrPXfx2NcK2B",file);
fputs("\n",file);
fputs("Jo3h+lKN3vCobMc5qfb357cFxSj/mUOZpOgZZojD1c8qxRCvsasHJpCgC20oOyaD",file);
fputs("\n",file);
fputs("BImb2+LJr60vQ0jx37LbbMKqswu6FIsvaNJ4DX72JVe++rF+WVYhmRoLh5dCiXtB",file);
fputs("\n",file);
fputs("47zjfbb/f8rK9NAzKm4/Je405Htc2bWmYUMIpnz55/8O8nGb9CtWfByxynCWlenF",file);
fputs("\n",file);
fputs("rMPuUoKbgNJUTQYEBix/b36HAXKtOZhRFkuZ+XW3zbQDK4ye7dEeiZwCE10Q5/R0",file);
fputs("\n",file);
fputs("udGLpyh4CEFgqsa22bCZSH1ZDh7LywKCAQEApLvFb4WJh1uVBT56fzg1k37PpxyU",file);
fputs("\n",file);
fputs("9074sqx2uQUwuXeOW8zeRVQvlqO+nIaG6SMIC69VNk+xYjUFK1UvyeQdjhZI67yj",file);
fputs("\n",file);
fputs("DVeIufGDFUzkcDhndAQ4javpQozOHZSRKl7lW9iiSEEkTyl6zQKsbip03K0FIO8+",file);
fputs("\n",file);
fputs("OAqjrQYIlk4hjCrBn7ggy03Ip6aS+NbiJGvwaZmEntBb2e1R1F3bUTWrYH3qHnmd",file);
fputs("\n",file);
fputs("bEC3iLuCQhWxn24Xzz10+QU6OhRROozvfs8IyZSzZeUDGg5yr6/S5zhlJ8ao74PK",file);
fputs("\n",file);
fputs("OL7/z+irEydSEStwRsGGl9+w9aRr5D3TjOmdZQMPMSHbQMEeoMkLxKWpXQ==",file);
fputs("\n",file);
fputs("-----END RSA PRIVATE KEY-----",file);
fputs("\n",file);
cout << "\e[33m..........\e[32m OK \n \e[31m \nid_rsa \e[0m gravado com \e[32m sucesso!\n\n" ;

}

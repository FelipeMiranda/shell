#!/usr/bin/env python3


import sys
from termcolor import colored

def tem_acento(s):
    return not all(ord(c) < 128 for c in s)


print ("Verificando se existe acento na frase: ", sys.argv[1])

if (tem_acento(sys.argv[1]) == True ):
	print (colored("Tem acentos", 'red'))
else:
	print (colored("Sem acentos", 'green'))


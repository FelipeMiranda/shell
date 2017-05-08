#!/usr/bin/python3.4
import itertools
import string
import sys


def main():
   if sys.argv[1]:
	   caracteres = sys.argv[1]
   else:
	   caracteres = 5

   if len(sys.argv) > 2:
	   if sys.argv[2]!= NULL :
		   hex_chars = sys.argv[2]
   else:
	   hex_chars = '0123456789abcdef'

   wordlist = open('wordlist', 'w')

   for words in itertools.product(hex_chars, repeat=int(caracteres)):
	   wordlist.write('shx' +''.join(words) + '' + '\n')


if __name__ == '__main__':
  main()

#!/usr/bin/env python3


import sys



print ("This is the name of the script: ", sys.argv[0])

def is_ascii(s):
    return all(ord(c) < 128 for c in s)

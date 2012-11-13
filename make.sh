#!/bin/bash

gcc -c -fPIC libfisk.c -D_GNU_SOURCE -Wall
gcc -shared -fPIC -o libfisk.so libfisk.o -ldl -Wall


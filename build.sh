#!/usr/bin/env bash

set -e

SRC1="main.asm"
SRC2="util.asm"
OBJ1="main.o"
OBJ2="util.o"
OUT="321ah"
NASM="nasm"
LD="ld"
NFLAGS="-felf64"

$NASM $NFLAGS -o $OBJ1 $SRC1
$NASM $NFLAGS -o $OBJ2 $SRC2
$LD $OBJ1 $OBJ2 -o $OUT

echo "Success: ./$OUT"

rm *.o

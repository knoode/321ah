#!/usr/bin/env bash

set -e

SRC1="main.asm"
SRC2="util.asm"
SRC3="sound.asm"
OBJ1="main.o"
OBJ2="util.o"
OBJ3="sound.o"
OUT="321ah"
NASM="nasm"
LD="ld"
NFLAGS="-felf64"

$NASM $NFLAGS -o $OBJ1 $SRC1
$NASM $NFLAGS -o $OBJ2 $SRC2
$NASM $NFLAGS -o $OBJ3 $SRC3
$LD $OBJ1 $OBJ2 $OBJ3 -o $OUT

echo "Success: ./$OUT"

rm *.o

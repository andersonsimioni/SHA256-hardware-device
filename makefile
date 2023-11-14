CC=gcc
CFLAGS=-I.
DEPS = "header/sha256.h"

run: bin
	run

bin: clean mkdirbuild sha256 main
	$(CC) -o "build/bin/main" "build/obj/main.o" "build/obj/sha256.o" "header/sha256.h" -g3

main: sha256
	$(CC) -o "build/obj/main.o" "source/main.c" -c

sha256:
	$(CC) -o "build/obj/sha256.o" "source/sha256.c" -c

mkdirbuild:
	mkdir "build"
	mkdir "build/obj"
	mkdir "build/bin"

clean:
	IF EXIST "build" rmdir "build" /s /q
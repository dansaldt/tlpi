CC=clang
CSTD=-std=c99
PORT=-D_XOPEN_SOURCE=600
BUILD=${CSTD} ${PORT} -Wall -Wextra -g -O0 -v

LIB=lib/tlpi_hdr.h \
	lib/get_num.h lib/get_num.c \
	lib/ename.c \
	lib/error_functions.h lib/error_functions.c

all: copy seek

copy: error_functions.o
	${CC} ${BUILD} bin/error_functions.o fileio/copy.c -o bin/copy

seek: error_functions.o get_num.o
	${CC} ${BUILD} bin/error_functions.o bin/get_num.o fileio/seek_io.c -o bin/seek

error_functions.o:
	${CC} ${BUILD} lib/error_functions.c -o bin/error_functions.o -c

get_num.o:
	${CC} ${BUILD} lib/get_num.c -o bin/get_num.o -c

.PHONY: clean
clean:
	rm bin/*.o bin/copy bin/seek
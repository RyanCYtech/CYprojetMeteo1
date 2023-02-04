PROG=Main
CC=gcc
OPTION=-Wall -lm
SRC=$(wildcard *.c)
HEAD=$(wildcard *.h)
OBJ=$(SRC:.c=.o)
RM=rm -rf


all : $(PROG)		# target principal

$(PROG) : $(OBJ) 	# compilation du programme
	$(CC) $^ -o $@ $(OPTION)
	$(RM) $(OBJ)

clean :
	$(RM) $(OBJ) $(PROG)

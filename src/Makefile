all: dropwatch
CFLAGS+=-c -g -D_GNU_SOURCE -Wall -Werror -I /usr/include/libnl3/
LDFLAGS=-lbfd -lreadline -lnl-3 -lnl-genl-3
OBJFILES := main.o lookup.o\
	 lookup_bfd.o lookup_kas.o

dropwatch: $(OBJFILES) 
	gcc -g -o dropwatch $(OBJFILES) $(LDFLAGS) 

%.o: %.c
	gcc $(CFLAGS) $<
clean:
	rm -f dropwatch *.o


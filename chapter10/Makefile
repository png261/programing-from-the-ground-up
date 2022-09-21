ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

BINARY = conversion-program

all: $(BINARY)

conversion-program: conversion-program.o integer-to-string.o count-chars.o write-newline.o
	$(LD) -o $@ $? $(LDLIBS)

% : %.s
# the default rule calls $(CC) but that's not what we want right now
# so this empty rule will cancel the default.

%.o : %.[sS]
	$(AS) -o $@ $< $(ASFLAGS)

% : %.o
	$(LD) -o $@ $< $(LDLIBS)


clean:
	-rm -rf *.o $(BINARY)

.PHONEY: clean all

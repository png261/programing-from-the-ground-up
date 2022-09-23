ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

BINARY = conversion-program is_negative number2integer std-number

all: $(BINARY)

conversion-program: conversion-program.o integer-to-string.o count-chars.o write-newline.o
	$(LD) -o $@ $? $(LDLIBS)

is_negative: is_negative_test.o is_negative.o integer-to-string.o number2integer.o power.o count-chars.o write-newline.o
	$(LD) -o $@ $? $(LDLIBS)

number2integer: number2integer-test.o number2integer.o power.o integer-to-string.o count-chars.o write-newline.o
	$(LD) -o $@ $? $(LDLIBS)

std-number: std-number.o number_trim.o number2integer.o count-chars.o power.o
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

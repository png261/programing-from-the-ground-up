ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

all: factorial factorial_not_recursive power square 

factorial: factorial.o
	$(LD) -o $@ $? $(LDLIBS)

factorial_not_recursive: factorial_not_recursive.o
	$(LD) -o $@ $? $(LDLIBS)

power: power.o
	$(LD) -o $@ $? $(LDLIBS)

square: square.o square_test.o
	$(LD) -o $@ $? $(LDLIBS)

% : %.s
# the default rule calls $(CC) but that's not what we want right now
# so this empty rule will cancel the default.

%.o : %.[sS]
	$(AS) -o $@ $< $(ASFLAGS)

% : %.o
	$(LD) -o $@ $< $(LDLIBS)


clean:
	-rm -rf *.o factorial factorial_not_recursive power square 

.PHONEY: clean all

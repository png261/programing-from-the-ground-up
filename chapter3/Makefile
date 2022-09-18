ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

BINARY = write-record read-record add-year largest-age

all: $(BINARY)

exit: exit.o
	$(LD) -o $@ $? $(LDLIBS)

maxium: maxium.o
	$(LD) -o $@ $? $(LDLIBS)

minium: minium.o
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

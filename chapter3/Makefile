ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

all: exit maxium minium

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
	-rm -rf *.o exit maxium minium

.PHONEY: clean all

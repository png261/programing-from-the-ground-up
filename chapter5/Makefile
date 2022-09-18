ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

all: toupper toupper-argc toupper-bss toupper-error toupper-std heynow

toupper: toupper.o
	$(LD) -o $@ $? $(LDLIBS)
	
toupper-argc: toupper-argc.o
	$(LD) -o $@ $? $(LDLIBS)

toupper-std: toupper-std.o
	$(LD) -o $@ $? $(LDLIBS)

toupper-bss: toupper-bss.o
	$(LD) -o $@ $? $(LDLIBS)

toupper-error: toupper-error.o
	$(LD) -o $@ $? $(LDLIBS)

heynow: heynow.o
	$(LD) -o $@ $? $(LDLIBS)


% : %.s
# the default rule calls $(CC) but that's not what we want right now
# so this empty rule will cancel the default.

%.o : %.[sS]
	$(AS) -o $@ $< $(ASFLAGS)

% : %.o
	$(LD) -o $@ $< $(LDLIBS)


clean:
	-rm -rf *.o toupper toupper-argc toupper-bss toupper-error toupper-std heynow

.PHONEY: clean all

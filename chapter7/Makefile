ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

BINARY = write-record read-record add-year 

all: $(BINARY)

write-record: write-record.o write-records.o
	$(LD) -o $@ $? $(LDLIBS)

read-record: read-record.o read-records.o write-newline.o count-chars.o
	$(LD) -o $@ $? $(LDLIBS)

add-year: add-year.o read-record.o write-record.o write-newline.o count-chars.o error-exit.o 
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

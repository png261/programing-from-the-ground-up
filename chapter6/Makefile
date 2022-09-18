ASFLAGS=-gstabs -32
LDLIBS=-m elf_i386

BINARY = write-record read-record add-year largest-age smallest-age

all: $(BINARY)

write-record: write-record.o write-records.o
	$(LD) -o $@ $? $(LDLIBS)

read-record: read-record.o read-records.o write-newline.o count-chars.o
	$(LD) -o $@ $? $(LDLIBS)

add-year: read-record.o write-record.o add-year.o
	$(LD) -o $@ $? $(LDLIBS)

largest-age: read-record.o largest-age.o
	$(LD) -o $@ $? $(LDLIBS)

smallest-age: read-record.o smallest-age.o
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

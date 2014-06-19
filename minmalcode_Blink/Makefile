CROSS= arm-bare_newlib_cortex_m0_nommu-eabi-

CC= $(CROSS)gcc
LD= $(CROSS)ld
OBJCOPY= $(CROSS)objcopy
OBJDUMP= $(CROSS)objdump
SIZE= $(CROSS)size
READELF= $(CROSS)readelf

LD_SCRIPT= memory.lds

STARTUP= startup.o
OBJS= main.o
OBJS+= vector_table.o

CFLAGS= -mfloat-abi=soft -mlittle-endian
CFLAGS+= -nostartfiles
CFLAGS+= -ffreestanding
CFLAGS+= -mcpu=cortex-m0

all: binary.bin
binary.elf: $(STARTUP) $(OBJS)
	$(LD) -static -nostartfiles -T $(LD_SCRIPT) $^ -o $@ $(LIBS)
	$(OBJDUMP) -D binary.elf > binary.disas
	$(SIZE) binary.elf > binary.size
	$(READELF) -a binary.elf > binary.readelf

.SUFFIXES: .elf .bin

.elf.bin:
	$(OBJCOPY) -O binary $< $@
.c.o:
	$(CC) $(CFLAGS) -c $< -o $@
.S.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean::
	$(RM) -f *.o *.img *.elf *.size *.disas *.readelf *.bin 
	$(RM) -f tags *~

tags::
	ctags *.[chS]
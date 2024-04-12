FILES = start.s main.c
LDSCRIPT = board.ld
NAME = firmware
OPTLEVEL = -O0
CFLAGS = 	--freestanding -nostartfiles -nodefaultlibs \
        	-Wall $(OPTLEVEL) -T $(LDSCRIPT) -march=24kec \
        	-mno-abicalls -minterlink-mips16 -mabi=32 \
        	-msoft-float -mgp32
CC = mips64-linux-gnu-gcc
OBJDUMP = mips64-linux-gnu-objdump
OBJCOPY = mips64-linux-gnu-objcopy

all: elf bin rom

elf: $(FILES)
	@$(CC) $(CFLAGS) -o $(NAME).elf $(FILES)

bin: elf
	@mips64-linux-gnu-objcopy -O binary $(NAME).elf $(NAME).o

rom: bin
	@cp $(NAME).o $(NAME).rom
	@truncate -s1M $(NAME).rom

disassemble: elf
	@mips64-linux-gnu-objdump -d $(NAME).elf

disassemble_raw: bin
	@mips64-linux-gnu-objdump --endian=big -m mips16 -b binary --disassemble-all $(NAME).o

clean:
	@rm -f firmware.elf firmware.o firmware.rom

.PHONY: all disassemble disassemble_raw clean
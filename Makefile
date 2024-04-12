SRC_DIR = src
FILES = $(SRC_DIR)/start.s $(wildcard $(SRC_DIR)/*.c)
LDSCRIPT = board.ld
OUTPUT_NAME = firmware
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
	@$(CC) $(CFLAGS) -o $(OUTPUT_NAME).elf $(FILES)

bin: elf
	@mips64-linux-gnu-objcopy -O binary $(OUTPUT_NAME).elf $(OUTPUT_NAME).o

rom: bin
	@cp $(OUTPUT_NAME).o $(OUTPUT_NAME).rom
	@truncate -s1M $(OUTPUT_NAME).rom

disassemble: elf
	@mips64-linux-gnu-objdump -d $(OUTPUT_NAME).elf

disassemble_raw: bin
	@mips64-linux-gnu-objdump --endian=big -m mips16 -b binary --disassemble-all $(OUTPUT_NAME).o

clean:
	@rm -f $(OUTPUT_NAME).elf $(OUTPUT_NAME).o $(OUTPUT_NAME).rom

.PHONY: all disassemble disassemble_raw clean
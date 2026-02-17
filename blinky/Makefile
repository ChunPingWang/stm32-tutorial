# Makefile for STM32F401RE Blinky

# Toolchain
PREFIX = arm-none-eabi
CC = $(PREFIX)-gcc
AS = $(PREFIX)-as
LD = $(PREFIX)-ld
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
SIZE = $(PREFIX)-size

# Flags
CPU = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
MCUFLAGS = $(CPU) -DSTM32F401xE -DUSE_HAL_DRIVER
CFLAGS = $(MCUFLAGS) -Wall -Wextra -pedantic -std=gnu11 -O0 -g3
ASFLAGS = $(MCUFLAGS) -g

# Directories
SRC_DIR = Core/Src
INC_DIR = Core/Inc

# Source files
SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(SOURCES:.c=.o)

# Startup and Linker
STARTUP = Core/Src/startup_stm32f401xe.s
LDSCRIPT = STM32F401RE_FLASH.ld

# Target
TARGET = blinky

# OpenOCD
OPENOCD = openocd
OPENOCD_CFG = interface/stlink.cfg -f target/stm32f4x.cfg

# Serial (for stm32flash)
SERIAL = /dev/ttyACM0
BAUD = 115200

.PHONY: all flash debug clean

all: $(TARGET).bin

$(TARGET).elf: $(OBJECTS) $(STARTUP)
	$(CC) -T $(LDSCRIPT) $^ -o $@ -lc -lm -lnosys $(MCUFLAGS)
	$(SIZE) $@

%.o: %.c
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

flash: $(TARGET).bin
	stm32flash -w $< -v -g 0x08000000 $(SERIAL) || \
	(OpenOCD -f $(OPENOCD_CFG) -c "program $< verify reset exit" 2>/dev/null)

debug: $(TARGET).elf
	$(OPENOCD) -f $(OPENOCD_CFG) & 
	sleep 2
	$(PREFIX)-gdb -tui $(TARGET).elf -ex "target remote localhost:3333"

clean:
	rm -f $(OBJECTS) $(TARGET).elf $(TARGET).bin

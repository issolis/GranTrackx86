FILENAME = Sector
ASM_SRC1 = $(FILENAME)One.asm
ASM_SRC2 = $(FILENAME)Two.asm
BIN1 = $(FILENAME)One.bin
BIN2 = $(FILENAME)Two.bin
FINAL_BIN = $(FILENAME).bin

ASM = nasm
ASM_FLAGS = -f bin

QEMU = qemu-system-x86_64
QEMU_FLAGS = -drive format=raw,file=$(FINAL_BIN)

PAD_SIZE = 4096  # 6 sectores * 512 bytes

all: $(FINAL_BIN)
	$(QEMU) $(QEMU_FLAGS)

$(BIN1): $(ASM_SRC1)
	$(ASM) $(ASM_FLAGS) $(ASM_SRC1) -o $(BIN1)

$(BIN2): $(ASM_SRC2)
	$(ASM) $(ASM_FLAGS) $(ASM_SRC2) -o $(BIN2)
	@truncate -s $(PAD_SIZE) $(BIN2)

$(FINAL_BIN): $(BIN1) $(BIN2)
	cat $(BIN1) $(BIN2) > $(FINAL_BIN)

clean:
	rm -f $(BIN1) $(BIN2) $(FINAL_BIN)

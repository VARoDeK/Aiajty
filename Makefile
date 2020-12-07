ASM = nasm
AFLAGS = -f bin 

BOOTFILE = boot.bin

#Default Goal
all: $(BOOTFILE)

$(BOOTFILE): boot.asm
	$(ASM) $(AFLAGS) -o $@ $^

run: $(BOOTFILE)
	@echo "To exit the execution once it starts:"
	@echo " - Press 'ctrl+a' and release keys."
	@echo " - Then press 'x'"
	@read -p "Press enter key to continue...."
	qemu-system-x86_64 $^ -nographic

dump: $(BOOTFILE)
	od -t x1 -A n $(BOOTFILE)

.PHONY: clean
clean:
	@rm -f boot.bin

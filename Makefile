# Arquivos fonte
BOOTLOADER_SRC = src/bootloader/boot.asm
KERNEL_SRC = src/kernel/kernel.asm

# Arquivos binários gerados
BOOTLOADER_BIN = build/bootloader.bin
KERNEL_BIN = build/kernel.bin

# Imagem de disco
DISK_IMAGE = build/disk.iso

# Alvo padrão: criação da imagem de disco
all: $(DISK_IMAGE)

# Cria a imagem de disco
$(DISK_IMAGE): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(DISK_IMAGE) bs=512 count=2880
	dd if=$(BOOTLOADER_BIN) of=$(DISK_IMAGE) conv=notrunc
	dd if=$(KERNEL_BIN) of=$(DISK_IMAGE) seek=1 conv=notrunc

# Compilação do bootloader
$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	nasm $(BOOTLOADER_SRC) -o $(BOOTLOADER_BIN)

# Compilação do kernel
$(KERNEL_BIN): $(KERNEL_SRC)
	nasm $(KERNEL_SRC) -o $(KERNEL_BIN)

# Alvo para limpeza dos arquivos gerados
clean:
	rm -f $(BOOTLOADER_BIN) $(KERNEL_BIN) $(DISK_IMAGE)

# Alvo para criar a imagem de disco e limpar os arquivos gerados
rebuild: clean all

# Alvo de phony para evitar conflitos com arquivos de mesmo nome
.PHONY: all clean rebuild

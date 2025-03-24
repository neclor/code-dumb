# Имя выходного файла
TARGET = hello

# Компилятор и опции
NASM = nasm
LD = ld

# Флаги NASM и компоновщика
NASM_FLAGS = -f elf32
LD_FLAGS = -m elf_i386

# Сборка программы
$(TARGET): $(TARGET).o
	$(LD) $(LD_FLAGS) -o $(TARGET) $(TARGET).o

# Компиляция файла .asm в объектный файл .o
$(TARGET).o: $(TARGET).asm
	$(NASM) $(NASM_FLAGS) $(TARGET).asm -o $(TARGET).o

# Очистка скомпилированных файлов
clean:
	rm -f $(TARGET) $(TARGET).o

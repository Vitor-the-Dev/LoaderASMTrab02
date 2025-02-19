


CC = gcc
ASM = nasm
CFLAGS = -m32 -Wall
ASMFLAGS = -f elf32
LDFLAGS = -m32
TARGET = print_block
ASM_SRC = print_blocks.asm
C_SRC = main.c


ASM_OBJ = $(ASM_SRC:.asm=.o)
C_OBJ = $(C_SRC:.c=.o)

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(ASM_OBJ) $(C_OBJ)
	$(CC) $(LDFLAGS) $^ -o $@

%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: $(TARGET)
	@echo "Running program..."
	
	@./$(TARGET) 30 2048 10 3072 10 4096 10 8000 10
	@./$(TARGET) 20 2048 10 3072 30 4096 10 8000 10
	@./$(TARGET) 100 2048 10 3072 10 4096 10 8000 10
	@./$(TARGET) 40 2048 10 3072 10 4096 10 8000 10
	
clean:
	rm -f *.o $(TARGET)
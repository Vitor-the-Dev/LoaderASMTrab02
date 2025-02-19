# TP 2 SB UNB #
---
## Loader in IA-32 ##
---

VITOR CARLOS FERNANDES - 190142332

O trabalho foi feito em C + IA-32 no sistema Linux Ubuntu versão 20.04.

---

**Para compilar:**  
Os arquivos `main.c` e `print_blocks.asm` devem estar dentro do diretório `./`. Use o comando:
```bash
make run
```
Que retornará os resultados dos testes:
```makefile
@./$(TARGET) 30 2048 10 3072 10 4096 10 8000 10
@./$(TARGET) 20 2048 10 3072 30 4096 10 8000 10
@./$(TARGET) 100 2048 10 3072 10 4096 10 8000 10
@./$(TARGET) 40 2048 10 3072 10 4096 10 8000 10
```

**Para executar manualmente:**  
Use `./print_blocks` com parâmetros desejados. Exemplos:
```bash
./print_block 30 100 10 130 10
./print_block 100 100 10
```

**Para limpar arquivos gerados:**  
```bash
make clean
```
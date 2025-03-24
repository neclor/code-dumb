section .data
    msg db "Hello, World!", 0xA  ; Сообщение и перевод строки
    len equ $ - msg              ; Длина сообщения

section .text
    global _start

_start:
    ; Сложение двух чисел
    mov eax, 5        ; Первое число
    mov ebx, 3        ; Второе число
    add eax, ebx      ; Сложение eax + ebx, результат в eax

    ; Печать результата (для простоты, только возврат кода)
    mov ebx, eax      ; Переместить результат в ebx
    mov eax, 1        ; Системный вызов exit
    int 0x80          ; Вызов ядра

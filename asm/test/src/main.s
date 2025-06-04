.intel_syntax noprefix




.text
    .global main
    .type main, @function

main:  
    PUSH RBP
    MOV RBP, RSP

boucle: 
    DEC RDI
    JZ fin
    ADD RSI, 8
    PUSH RDI
    PUSH RSI
    MOV RDI, qword ptr[RSI]
    CALL conversion
    MOV RAX, qword ptr[RBP - 16]
    MOV RDI, qword ptr[RAX]
    CALL puts
    POP RSI
    POP RDI
    JMP boucle

fin:    
    MOV EAX, 0
    POP RBP
    RET

conversion:
    PUSH RBP
    MOV RBP, RSP

boucle2:
    MOV AL, byte ptr[RDI]
    CMP AL, 0
    JE fin
    INC RDI
    CMP AL, 'A'
    JB boucle2
    CMP AL, 'Z'
    JA boucle2
    ADD AL, 0x20
    MOV byte ptr[RDI - 1], AL
    JMP boucle2





.data
    MAX_X = 16
    MAX_Y = 16





.text



test:
    MAX_X = 16
    MAX_Y = 16



    loop:
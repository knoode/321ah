; util.asm

%include "const.inc"

section .text
    global exit
    global print_char
    global print_str
    global digit_to_code

; exit(int status)
; status => RDI
exit:
    mov rax, SYS_EXIT
    syscall

; print_char(unsigned code)
; code => RDI
print_char:
    push rdi

    mov rax, SYS_WRITE
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall

    pop rdi
    ret

; print_str(string str, unsigned len)
; str => RDI
; len => RSI
print_str:
    push rbp
    mov rbp, rsp

    mov rax, SYS_WRITE
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 1
    syscall

    pop rbp
    ret

; digit_to_code(unsigned digit) -> char
; digit => RDI
digit_to_code:
    push rbp
    mov rbp, rsp

    cmp rdi, 9
    jbe is_digit

    ; return -1
    mov rax, -1
    pop rbp
    ret
is_digit:
    add rdi, ZERO_ASCII
    mov rax, rdi

    pop rbp
    ret

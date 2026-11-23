    ; hello.asm

    ; TODO: Incbin the .wav file

%include "const.inc"

section .data
    end_str db "...", 0x0a
    len equ $ - end_str


section .bss
    player_envp_ptr resq 1


section .text
    global _start
    extern digit_to_code
    extern print_char
    extern print_str
    extern exit

_start:
    ; Get envp from stack
    mov rax, [rsp]               ; argc
    lea rdx, [rsp + rax*8 + 16]  ; envp
    mov [rel player_envp_ptr], rdx

    mov r10, 3
number_loop:
    test r10, r10
    jz play_ahh

    mov rdi, r10
    call digit_to_code

    mov rdi, rax
    call print_char

    mov rdi, end_str
    mov rsi, len
    call print_str

    mov rax, SYS_NANOSLEEP
    mov rdi, timespec
    xor rsi, rsi
    syscall

    dec r10
    jmp number_loop
play_ahh:
    mov rax, SYS_EXECVE
    mov rdi, player
    mov rsi, player_argv
    mov rdx, [player_envp_ptr]
    syscall

    xor rdi, rdi
    call exit

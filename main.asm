; hello.asm

; TODO: Incbin the .wav file
; TODO: Manual parsing and playing .wav file

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
    extern sound_effect
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
    mov rdi, [player_envp_ptr]
    call sound_effect

    xor rdi, rdi
    call exit

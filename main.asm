; hello.asm

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
    extern save_wav_tmp
    extern delete_wav_tmp
    extern play_sound
    extern exit

_start:
    ; Get envp from stack
    mov rax, [rsp]                  ; argc
    lea rdx, [rsp + rax*8 + 16]     ; envp
    mov [rel player_envp_ptr], rdx

    mov r10, 3

.number_loop:
    test r10, r10
    jz .play_ah

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
    jmp .number_loop

.play_ah:
    call save_wav_tmp  ; "/tmp/321ah.wav"

    mov rax, SYS_FORK
    syscall

    cmp rax, 0
    jz .child_process
    jl .fork_error

.parent_process:
    ; Call wait4() to wait for child process to be exited
    mov rdi, rax        ; pid 
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    mov rax, SYS_WAIT4
    syscall

    ; Remove "/tmp/321ah.wav"
    call delete_wav_tmp

    xor rdi, rdi
    call exit

.fork_error:
    mov rdi, 1
    call exit

.child_process:
    mov rdi, [player_envp_ptr]
    call play_sound


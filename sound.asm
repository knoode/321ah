; sound.asm

%include "const.inc"


section .data
    player db "/usr/bin/aplay", 0
    player_arg db "-q", 0
    player_file db "/tmp/321ah.wav", 0
    player_argv dq player, player_arg, player_file, 0


section .rodata
wav_data:
    incbin "sound/ahh.wav"
    wav_size equ $ - wav_data

    
section .text
    global play_sound
    global save_wav_tmp
    global delete_wav_tmp
    extern exit

; play_sound(char **envp)
; envp => RDI
play_sound:
    mov rax, SYS_EXECVE
    mov rdx, rdi
    mov rdi, player
    mov rsi, player_argv
    syscall

    ; Exit with error, if execve() failed
    mov rdi, 1
    call exit

; save_wav_tmp()
save_wav_tmp:
    push rbp
    mov rbp, rsp

    ; Call open() to create a new file with WRITE flag
    mov rax, SYS_OPEN
    mov rdi, player_file
    mov rsi, O_CREAT | O_WRONLY
    mov rdx, 0664o
    syscall
    
    ; TODO: Error checking

    push rax            ; save fd for close()

    ; Call write() to write wav_data into .wav file
    mov rdi, rax        ; fd
    mov rax, SYS_WRITE
    mov rsi, wav_data
    mov rdx, wav_size 
    syscall

    ; Call close() to close fd
    mov rax, SYS_CLOSE
    pop rdi
    syscall

    pop rbp
    ret

; delete_wav_tmp()
delete_wav_tmp:
    push rbp
    mov rbp, rsp

    mov rax, SYS_UNLINK
    mov rdi, player_file
    syscall
    
    ; TODO: Error checking

    pop rbp
    ret

; sound.asm

%include "const.inc"

section .data
    player db "/usr/bin/aplay", 0
    player_arg db "-q", 0
    player_file db "sound/ahh.wav", 0
    player_argv dq player, player_arg, player_file, 0


;section .rodata
;wav_data:
;    incbin "sound/ahh.wav"
;    wav_size equ $ - wav_data


section .text
    global sound_effect

; sound_effect(char **envp)
; envp => RDI
sound_effect:
    push rbp
    mov rbp, rsp
    
    mov rax, SYS_EXECVE
    mov rdx, rdi
    mov rdi, player
    mov rsi, player_argv
    syscall

    pop rbp 
    ret

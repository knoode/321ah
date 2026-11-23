; consts.inc

; Syscall IDs
SYS_WRITE equ 1
SYS_NANOSLEEP equ 35
SYS_EXECVE equ 59
SYS_EXIT equ 60

; digit_to_string()
ZERO_ASCII equ 48     ; '0'
    
; nanosleep()
timespec:
    tv_sec dq 0
    tv_nsec dq 500000000  ; 600 ms

player db "/usr/bin/aplay", 0
player_arg db "-q", 0
player_file db "sound/ahh.wav", 0

player_argv dq player, player_arg, player_file, 0

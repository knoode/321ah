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


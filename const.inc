; const.inc

; Syscall IDs
SYS_WRITE equ 1
SYS_OPEN equ 2
SYS_CLOSE equ 3
SYS_UNLINK equ 87
SYS_NANOSLEEP equ 35
SYS_FORK equ 57
SYS_WAIT4 equ 61
SYS_EXECVE equ 59
SYS_EXIT equ 60

; File flags
O_CREAT equ 100o
O_WRONLY equ 1o

; digit_to_string()
ZERO_ASCII equ 48     ; '0'
    
; nanosleep()
timespec:
    tv_sec dq 0
    tv_nsec dq 500000000  ; 500 ms


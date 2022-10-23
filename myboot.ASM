ORG 07C00h

start:
    xor ax, ax
    mov ds, ax
    call get_time
    call display_time
    call display_os_info

convert_bcd:
    mov  ah, al
    shr  al, 4
    and  ah, 0Fh
    add  al, 30h
    add  ah, 30h
    ret

get_time:
    mov ah, 02h
    int 1Ah
    mov  al, ch
    call convert_bcd
    mov  [current_time + 0], al
    mov  [current_time + 1], ah
    mov  al, cl
    call convert_bcd
    mov  [current_time + 3], al
    mov  [current_time + 4], ah
    mov  al, dh
    call convert_bcd
    mov  [current_time + 6], al
    mov  [current_time + 7], ah
    ret

current_time: db '00:00:00'
os_info: db 'Author: Sergei Leshchenko'

display_time:
    mov ah, 2h
    mov dh, 1
    mov dl, 0
    mov ax, 1301h
    mov bp, current_time
    mov cx, 8
    mov bl, 02h
    int 10h
    ret

display_os_info:
    mov ah, 2h
    mov dh, 0
    mov dl, 0
    mov ax, 1301h
    mov bp, os_info
    mov cx, 25
    mov bl, 02h
    int 10h
    ret

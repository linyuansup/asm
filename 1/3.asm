data segment
    score     db 100 dup(?)
    prompt    db 'input number$'
    found     db 'Y$'
    not_found db 'N$'
data ends

code segment
                    assume cs:code,ds:data
    start:          
                    mov    ax, data
                    mov    ds, ax
                    lea    dx, prompt
                    mov    ah, 09h
                    int    21h
                    mov    ah, 01h
                    int    21h
                    sub    al, '0'
                    mov    bl, al
                    mov    bh, 0
                    mov    cx, 100
                    lea    si, Score
                    mov    dl, 0
                    mov    al, 0
    search_loop:    
                    mov    al, byte ptr [si]
                    inc    si
                    cmp    al, bl
                    je     found_label
                    loop   search_loop
    not_found_label:
                    lea    dx, not_found
                    mov    ah, 09h
                    int    21h
                    jmp    exit_label
    found_label:    
                    lea    dx, found
                    mov    ah, 09h
                    int    21h
    exit_label:     
                    mov    ah, 4Ch
                    int    21h
code ends
                    end start
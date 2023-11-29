data segment
        data1   db 'lty$'
        data2   db 50,?,50 dup('$')
        success db 'Yes$'
        fail    db 'No$'
data ends
code segment
              assume cs:code,ds:data
        start:mov    ax,data
              mov    ds,ax
              mov    es,ax

              mov    ah,0ah
              mov    dx,offset data2
              int    21h

              mov    ah,2h
              mov    dl,0ah
              int    21h
              mov    ah,2h
              mov    dl,0dh
              int    21h

              mov    si,offset data2
              mov    di,offset data1
              mov    dx,si
              mov    bx,di
              mov    ah,58

        again:
              mov    cx,3
              repz   cmpsb
              jz     yes
              add    dx,1
              mov    si,dx
              mov    di,bx
              dec    ah
              jnz    again
              jmp    no

        no:
              mov    dx,offset fail
              jmp    endc
        yes:  mov    dx,offset success
              jmp    endc
        endc: mov    ah,09h
              int    21h
              mov    ax,4c00h
              int    21h
code ends
		end start

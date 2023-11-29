data segment
      x    dw ?,?
      y    dw ?,?
      z    dw ?,?
      str  db '0000',0ah, 0dh, '$'
data ends

code segment
             assume ds: data, cs: code

calc proc
             push   bp
             mov    bp, sp
             push   ax
             push   bx
             push   dx

             mov    ax, [bp + 6]
             mov    dx, 0
             mov    bx, [bp + 4]
             imul   bx
             add    ax, [bp + 6]
             adc    dx, 0
             sub    ax, [bp + 4]

             cmp    dx, 0
             je     exit
             cmp    ax, 0
             jg     exit
             neg    ax

      exit:  
             mov    [bp + 8], ax
             pop    dx
             pop    bx
             pop    ax
             pop    bp
             ret    4
calc endp

      start: 
             mov    x, 21d
             mov    y, 51d
             mov    z, 5d

             push   z
             push   x
             push   y
             call   calc
             pop    z

             mov    bx, z
             mov    ch, 4
             mov    cl, 4

      rotate:
             rol    bx, cl
             mov    al, bl
             and    al, 0fh

             cmp    al, 0ah
             jl     next
             add    al, 37h
             jmp    done
      next:  
             add    al, 30h
      done:  
             mov    dl, al
             mov    ah, 2
             int    21h
             dec    ch
             jnz    rotate

             mov    ax, 4c00h
             int    21h
code ends

end start
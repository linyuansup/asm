MAX3 macro x, y, z, max
           push ax
           mov  al, x
           cmp  al, y
           jge  yLess
           mov  al, y
     yLess:
           cmp  al, z
           jge  zLess
           mov  al, z
     zLess:
           mov  max, al
           pop  ax
endm

data segment
     x    db 1
     y    db 5
     z    db 9
     max  db ?,?
data ends

code segment
           assume ds: data, cs: code
  
     start:
           mov    ax, data
           mov    ds, ax
           MAX3   x, y, z, max
           lea    dx, max
           mov    ah, 4ch
           int    21H
code ends

end start
data segment
    address dw case8,case7,case6,case5,case4,case3,case2,case1
    res8    db 'The 8 Bit is 0$'
    res7    db 'The 7 Bit is 0$'
    res6    db 'The 6 Bit is 0$'
    res5    db 'The 5 Bit is 0$'
    res4    db 'The 4 Bit is 0$'
    res3    db 'The 3 Bit is 0$'
    res2    db 'The 2 Bit is 0$'
    res1    db 'The 1 Bit is 0$'
data ends
assume ds:data, cs:code
code segment
    start:
          mov  ax, data
          mov  ds, ax
          mov  bl, 191
          mov  ax, 0000H
          mov  cx, 8
    math: shl  bl, 1
          jc   next
          jmp  right
    right:mov  dl, 02H
          mul  dl
          mov  bp, ax
          jmp  address[bp]
    next: inc  ax
          loop math

    case8:mov  dx, offset res8
          jmp  cout
    case7:mov  dx, offset res7
          jmp  cout
    case6:mov  dx, offset res6
          jmp  cout
    case5:mov  dx, offset res5
          jmp  cout
    case4:mov  dx, offset res4
          jmp  cout
    case3:mov  dx, offset res3
          jmp  cout
    case2:mov  dx, offset res2
          jmp  cout
    case1:mov  dx, offset res1
          jmp  cout
    cout: mov  ah, 09H
          int  21H
          mov  ah, 4ch
          int  21H
code ends
end start
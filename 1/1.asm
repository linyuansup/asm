data segment
    x    dw 202
    y    dw 121
    z    dw 515
    v    dw 900
    sum1 dw ?
    sum2 dw ?
data ends
code segment
          assume cs:code,ds:data
    start:mov    ax,data
          mov    ds,ax
          mov    ax,x
          imul   y
          mov    cx,ax
          mov    bx,dx
          mov    ax,z
          cwd
          add    cx,ax
          adc    bx,dx
          sub    cx,02d0h
          sbb    bx,0
          mov    ax,v
          cwd
          sub    ax,cx
          sbb    dx,bx
          idiv   x
          mov    sum1,ax
          mov    sum2,dx
code ends
			end start

    INTNO EQU 1CH
    
DATA SEGMENT
    OLDISR  DW ?,?
    TIMER   DB 100
    COUNTER DW 0
    ISDONE  DB 0
DATA ENDS
CODE SEGMENT
             ASSUME CS:CODE,DS:DATA
    START:   
             MOV    AX,DATA
             MOV    DS,AX
             MOV    AX,0
             MOV    ES,AX
             CLI
             MOV    AX, ES:[INTNO*4]
             MOV    OLDISR[0],AX
             MOV    AX,ES:[INTNO*4+2]
             MOV    OLDISR[2], AX
             STI
             CLI
             MOV    WORD PTR ES:[INTNO*4], OFFSET ISR
             MOV    WORD PTR ES:[INTNO*4+2],SEG ISR
             STI
    WAITHERE:
             CMP    ISDONE,1
             JNZ    WAITHERE
  
  
    EXIT:    
             CLI
             MOV    AX,OLDISR[0]
             MOV    ES:[INTNO*4],AX
             MOV    AX,OLDISR[2]
             MOV    ES:[INTNO*4+2],AX
             STI
        
             MOV    AX,4C00H
             INT    21H
      
ISR PROC FAR
             PUSH   DX
             PUSH   AX
        
             MOV    AX,DATA
             MOV    DS,AX

             INC    TIMER
    AGAIN:   
             CMP    TIMER, 1000/55                       ;18
             JB     DONE
             MOV    TIMER,0


    ;carriage
             MOV    AH,2
             MOV    DL,13
             INT    21H

    ;print time
             MOV    AX,COUNTER

             MOV    DL,10
             DIV    DL
             MOV    DH,AH
             MOV    DL,AL
             MOV    AH,2
             ADD    DL,30H
             INT    21H
             MOV    DL,DH
             ADD    DL,30H
             INT    21H
        
             INC    COUNTER
             CMP    COUNTER, 60
             JNE    DONE
             MOV    ISDONE,1
        
    DONE:    
             PUSHF
             CALL   DWORD PTR OLDISR

             CLI
             POP    AX
             POP    DX
             IRET                                        ;中断返回
ISR ENDP


CODE ENDS
      END START

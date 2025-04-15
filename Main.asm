.386

.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

EXTERN InitWindow :PROC
EXTERN SetTargetFPS :PROC
EXTERN WindowShouldClose :PROC
EXTERN ClearBackground :PROC
EXTERN BeginDrawing :PROC
EXTERN DrawRectangle :PROC
EXTERN EndDrawing :PROC
EXTERN CloseWindow :PROC

.data
Color STRUCT
    r BYTE ?
    g BYTE ?
    b BYTE ?
    a BYTE ?
Color ENDS
ColBG Color <255, 0,   0, 255>
ColREC Color <  0, 0, 255, 255>
WinTitle BYTE "Hello World!",0

RecX DWORD 100
RecY DWORD 100
RecW DWORD 200
RecH DWORD 200

.code
main proc
    push offset WinTitle
    push 400
    push 400
    call InitWindow
    add esp, 12

    push 30
    call SetTargetFPS
    add esp, 4
    whilestart:
    call WindowShouldClose 
    movzx eax,al  
    test eax,eax  
    jne          whileexit
        mov         esi,esp  
        mov         eax,dword ptr ColBG  
        push        eax
        call        ClearBackground
        add         esp,4  
        cmp         esi,esp  

        call BeginDrawing

        mov         esi,esp  
        mov         eax,dword ptr ColREC
        push        eax  
        mov         ecx,dword ptr RecH
        push        ecx  
        mov         edx,dword ptr RecW
        push        edx  
        mov         eax,dword ptr RecY 
        push        eax  
        mov         ecx,dword ptr RecX 
        push        ecx  
        call        DrawRectangle
        add         esp,14h  
        cmp         esi,esp
        call EndDrawing
    jmp whilestart
    whileexit:

    call CloseWindow
    invoke ExitProcess,0



main endp
end main
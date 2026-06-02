assume cs:codesg  
codesg segment
start:
  mov ax,0123H
  mov bx,0456H
  add ax,bx       
  add ax,bx       
  
  mov ax,4c00h
  int 21h
codesg ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ax,2
    mov cx,11     
 s: add ax,ax
    loop s
    
    mov ax,4c00h
    int 21h
code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
        mov ax,0ffffh      
        mov ds,ax          
        mov bx,6           
    
        mov al,[bx]        
        mov ah,0           
    
        mov dx,0
        mov cx,3           
    L:  add dx,ax          
        loop L
        
        mov ax,4c00h
        int 21h
code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ax, 0ffffh
    mov ds, ax
    
    mov bx, 0           
    mov cx, 12          
    mov dx, 0           

  l:mov al, ds:[bx]
    mov ah, 0
    add dx, ax
    inc bx
    loop l
    
    mov ax, 4c00h
    int 21h
code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ax, 0ffffh
    mov ds, ax

    
    mov cx, 12          
    mov dx, 0           

  l:mov al, ds:[cx]
    mov ah, 0
    add dx, ax
    
    loop l
    
    mov ax, 4c00h
    int 21h
code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code      
code segment
start:          
    mov bx,0        
    mov cx,12       

 l: mov ax,0ffffh   
    mov ds,ax
    mov dl,ds:[bx]  

    mov ax,0020h    
    mov ds,ax
    mov ds:[bx],dl  
    
    inc bx
    loop l

    mov ax, 4c00h
    int 21h

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ax,0ffffh
    mov ds,ax       
    mov ax,0020h
    mov es,ax       
    
    mov bx,0        
    mov cx,12       

 l: mov dl,ds:[bx]
    mov es:[bx],dl
    inc bx
    loop l

    mov ax, 4c00h
    int 21h

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ax,0ffffh
    mov ds,ax       
    mov ax,0020h
    mov es,ax       
    
    mov bx,0        
    mov cx,6        

 l: mov dx,ds:[bx]
    mov es:[bx],dx
    inc bx
    inc bx
    loop l

    mov ax, 4c00h
    int 21h

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:codesg
codesg segment
    dw 0123H,0456H,0789H,0abcH,0defH,0cbaH,0987H 
    dw 16 DUP(0)                                 
    
start:                                           
    mov ax,cs                                    
    mov ss,ax
    mov sp,30h                                   

    mov bx,0
    mov cx,8
 l0:push cs:[bx]
    add bx,2
    loop l0
    
    mov bx,0
    mov cx,8
 l1:pop cs:[bx]
    add bx,2
    loop l1

    mov ax, 4c00h
    int 21h

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:codesg, ds:datasg
datasg segment
    db 'welcome to masm!'
datasg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax


    mov ax, 0B800H            
    mov es, ax                
    mov si, 0                 
    mov di, 160*12+80-16      

                              
    mov cx, 16                
 l: mov al, ds:[si]           
    mov byte ptr es:[di], al  
    inc di
    mov al, 71H
    mov byte ptr es:[di], al  

    inc si                    
    inc di                    
    loop l


    mov ax,4c00h
    int 21h
codesg ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ss:stack

stack segment stack 'stack'
    db 256 dup(0)      
stack ends

code segment
start:
    mov ax, stack      
    mov ss, ax
    mov sp, 256        

    mov ah, 3          
    mov al, 1          
    call setScreen     
    mov ax, 4c00h
    int 21h

setScreen:
    jmp short set
    table dw offset sub1, offset sub2, offset sub3, offset sub4

set:
    push bx
    cmp ah, 3
    ja sret                         

    mov bl, ah
    mov bh, 0
    add bx, bx                      
    call word ptr cs:[table + bx]   


sret:
    pop bx
    ret


sub1:   
    push bx
    push cx
    push es
    mov bx, 0B800h
    mov es, bx                      
    mov bx, 0                       
    mov cx, 2000                    
sub1_loop:                          
    mov byte ptr es:[bx], ' '       
    add bx, 2                       
    loop sub1_loop
    pop es
    pop cx
    pop bx
    ret                             


sub2:   
    push bx
    push cx
    push es
    mov bx, 0B800h
    mov es, bx                      
    mov bx, 1                       
    mov cx, 2000                    
sub2_loop:                          
    and byte ptr es:[bx], 11111000b 
    or es:[bx], al                  
    add bx, 2                       
    loop sub2_loop
    pop es
    pop cx
    pop bx
    ret                             


sub3:                               
    push bx
    push cx
    push es
    mov cl, 4                       
    shl al, cl                      
    mov bx, 0B800h
    mov es, bx                      
    mov bx, 1                       
    mov cx, 2000                    
subs3_loop:                         
    and byte ptr es:[bx], 10001111b 
    or es:[bx], al                  
    add bx, 2                       
    loop subs3_loop
    pop es
    pop cx
    pop bx
    ret                             


sub4:                                  
    push cx                            
    push si                            
    push di                            
    push es                            
    push ds                            

    mov si, 0B800h                      
                                       
    mov es, si
    mov ds, si
    mov di, 0                           
    mov si, 160                         
    cld                                
    mov cx, 24                          

subs4_loop:                            
    push cx                            
    mov cx, 160                        
    rep movsb                          
                                       
    pop cx                             
    loop subs4_loop                    

    mov cx, 80                          
    mov si, 0                          
subs4_clear_loop:
    mov byte ptr es:[160*24+si], ' '   
    add si, 2                          
    loop subs4_clear_loop

    pop ds
    pop es
    pop di
    pop si
    pop cx
    ret                                 

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------

assume cs:codesg, ss:stacksg, ds:datasg

stacksg segment
    db 200h dup (0) 
stacksg ends

datasg segment
    szmsg db 13,10,'hello world!',13,10,'$'
datasg ends

codesg segment
start:
    mov ax, stacksg
    mov ss, ax
    mov sp, 200h

    mov ax, datasg
    mov ds, ax

    lea dx, szmsg       
    mov ah, 9           
    int 21h

    mov ax, 4c00h
    int 21h
codesg ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ss:stack

stack segment stack 'stack'
    db 128 dup (0)
stack ends

code segment
start:
    mov ax, stack           
    mov ss, ax
    mov sp, 128
    
    mov ax, cs
    mov ds, ax

    
    mov si, offset do0                   
    mov ax, 0
    mov es, ax
    mov di, 200h                         
    mov cx, offset do0end - offset do0   
    cld
    rep movsb                            

    
    mov word ptr es:[0*4], 200h          
    mov word ptr es:[0*4+2], 0           

    
    mov ax, 8
    mov bh, 0
    div bh           

    
    mov ax, 4c00h
    int 21h


do0:                                
    jmp short do0start
    overflow_str db "overflow!",0   

do0start:
    push bp                         
    mov bp, sp                      
    add word ptr ss:[bp+2], 2       
    pop bp

    
    push ds
    push si
    push di
    push ax

    mov ax, cs                                       
    mov ds, ax
    mov si, 200h + (offset overflow_str - offset do0)


    mov ax, 0b800h
    mov es, ax
    mov di, 07C6h         


next_char:
    mov al, cs:[si]
    test al, al                     
    jz return                       
    mov ah, 11111100b               
    mov es:[di], ax                 
    inc si
    add di, 2
    jmp next_char

return:
    
    pop ax
    pop di
    pop si
    pop ds
    iret            


do0end:
    nop

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ss:stack

stack segment stack 'stack'
    db 128 dup(0)          
stack ends

code segment
start:

    
    cli                    

    mov ax, stack
    mov ss, ax             
    mov sp, 128            

    sti                    

    
    mov ax, cs
    mov ds, ax             

    
    mov si, offset sqr     
    xor ax, ax
    mov es, ax             
    mov di, 200h           

    mov cx, offset sqrend - offset sqr


    cld                    
    rep movsb              

    
    xor ax, ax
    mov es, ax                      

    mov word ptr es:[7ch*4], 200h   

    mov word ptr es:[7ch*4+2], 0    

    
    mov ax, 3456
    int 7ch                

    
    add ax, ax
    adc dx, dx

    
    mov ax, 4c00h
    int 21h


sqr:
    mul ax                 
    iret                   
sqrend:
    nop                    

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ds:data, ss:stack

stack segment stack 'stack'       
    db 128 dup(0)                 
stack ends

data segment                      
    capital db 'conversation', 0  
data ends

code segment                      
start:
    
    cli                           
    mov ax, stack
    mov ss, ax                    
    mov sp, 128                   
    sti                           

    
    mov ax, cs
    mov ds, ax                                                  
    mov si, offset capital_handler
    xor ax, ax
    mov es, ax                                                  
    mov di, 200h                                                
    mov cx, offset capital_handler_end - offset capital_handler 
    cld                                                         
    rep movsb                                                   

    
    cli                           
    xor ax, ax
    mov es, ax                    
    mov word ptr es:[7ch*4], 200h 
    mov word ptr es:[7ch*4+2], 0  
    sti                           


    mov ax, data
    mov ds, ax                    


    mov si, offset capital        
    int 7ch                       

    
    mov ax, 4c00h
    int 21h


capital_handler:
change:
    push ax                           
    push si

next_char:
    mov al, DS:[si]                   
    test al, al                       
    jz   done                         

    and byte ptr DS:[si], 11011111b   
    inc si                            
    jmp next_char                     

done:
    pop si                            
    pop ax
    iret                              

capital_handler_end:
    nop

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
start:
    mov ah,2
    mov bh,0
    mov dh,5
    mov dl,12
    int 10h

    mov ah,9
    mov al,'a'
    mov bl,11001010b
    mov bh,0
    mov cx,3
    int 10h

    mov ax,4c00h
    int 21h
code ends
end start


assume cs:code

code segment
start:

    
    mov ah, 2          
    mov bh, 0          
    mov dh, 5          
    mov dl, 12         
    int 10h

    mov ah, 9          
    mov al, 'a'        
    mov bl, 11001010b  
    mov bh, 0          
    mov cx, 1          
    int 10h

    
    mov ah, 2          
    mov bh, 1          
    mov dh, 5          
    mov dl, 12         
    int 10h

    mov ah, 9          
    mov al, 'b'        
    mov bl, 11001010b  
    mov bh, 1          
    mov cx, 1          
    int 10h

    
    mov ax, 0500h      
    int 10h

    call delay

    
    mov ax, 0501h      
    int 10h

    mov ax, 4c00h
    int 21h


delay:
    push cx
    push bx

    mov cx, 0fffh
d1:
    mov bx, 0fffh
d2:
    dec bx
    jnz d2
    loop d1

    pop bx
    pop cx
    ret

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------assume cs:codeseg
codeseg segment
    start: mov al, 08h
    out 42h, al
    out 42h, al

    in al, 61h        
    mov ah, al        
    or al, 3          
    out 61h, al       
    mov cx, 60000     

delay:
    nop
    loop delay
    
    mov al, ah        
    out 61h, al
    mov ax, 4c00h
    int 21h
codeseg ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code
code segment
    start:
        mov al,8
        out 70h,al          
        in al,71h           

        mov ah,al
        mov cl,4
        shr ah,cl           
        and al,00001111b    

        add ah,30h          
        add al,30h

        mov bx,0b800h
        mov es,bx           
        mov di,160*12+40*2  

        mov byte ptr es:[di],ah         
        mov byte ptr es:[di+1],07h      
        mov byte ptr es:[di+2],al       
        mov byte ptr es:[di+3],07h      

        mov ax,4c00h
        int 21h
code ends
end start


assume cs:code, ds:data, ss:stack

stack segment
    dw 128 dup(0)
stack ends

data segment
    msg db 'Month: ',0
data ends

code segment
start:
    mov ax, stack   
    mov ss, ax
    mov sp, 256

    mov ax, data    
    mov ds, ax

    mov ax, 0003h   
    int 10h


wait_uip_clear:     
    mov al, 0Ah
    or  al, 80h
    out 70h, al
    in  al, 71h
    test al, 80h
    jnz wait_uip_clear


    mov al, 0Bh     
    or  al, 80h     
    out 70h, al     
    in  al, 71h     
    test al, 04h
    jnz read_binary


read_bcd:
    mov al, 08h     
    or  al, 80h     
    out 70h, al
    in  al, 71h

    mov ah, al
    mov cl, 4
    shr ah, cl      
    and al, 0Fh     

    add ah, '0'     
    add al, '0'
    jmp short show_result


read_binary:
    mov al, 08h
    or  al, 80h     
    out 70h, al
    in  al, 71h

    xor ah, ah      
    mov bl, 10
    div bl          

    xchg al, ah     

    add al, '0'     
    add ah, '0'


show_result:
    push ax             

    mov si, offset msg  

show_msg_loop:
    lodsb                   
    or  al, al              
    jz  show_digits         
    mov ah, 0Eh             
    mov bh, 0               
    mov bl, 07h             
    int 10h                 
    jmp short show_msg_loop 


show_digits:
    pop ax                   

    mov dh, ah               
    mov dl, al               

    
    mov al, dh
    mov ah, 0Eh
    mov bh, 0
    mov bl, 07h
    int 10h

    
    mov al, dl
    mov ah, 0Eh
    mov bh, 0
    mov bl, 07h
    int 10h

    
    mov al, 0Dh         
    mov ah, 0Eh
    mov bh, 0
    mov bl, 07h
    int 10h

    mov al, 0Ah         
    mov ah, 0Eh
    mov bh, 0
    mov bl, 07h
    int 10h

    mov ax, 4C00h
    int 21h

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ds:data, ss:stack

stack segment stack         
    db 128 dup (0)          
stack ends


data segment

    
    old_int9 dd 0

    
    esc_flag db 0
data ends


code segment
start:

    
    mov ax, SEG data        
    mov ds, ax              

    
    cli                     
    xor ax, ax
    mov es, ax              

    
    mov ax, es:[9*4]                     
    mov word ptr ds:[old_int9], ax       

    
    mov ax, es:[9*4+2]                   
    mov word ptr ds:[old_int9+2], ax     

    
    mov word ptr es:[9*4], offset int9   
    mov ax, cs
    mov word ptr es:[9*4+2], ax          
    sti                                  

    
    mov ax, 0B800h
    mov es, ax              

    
    mov di, 160*12 + 40*2   
    mov byte ptr es:[di+1], 07h  
    mov al, 'a'             

show_loop:
    mov es:[di], al              
    call delay                   
    inc al                       
    cmp al, 'z' + 1              
    jne show_loop                

    
wait_esc:
    sti                             
    hlt                             
    cmp byte ptr ds:[esc_flag], 1   
    jne wait_esc                    

    
    cli                     
    xor ax, ax
    mov es, ax              

    
    mov ax, word ptr ds:[old_int9]
    mov es:[9*4], ax

    
    mov ax, word ptr ds:[old_int9+2]
    mov es:[9*4+2], ax
    sti                     

    
    mov ax, 4C00h
    int 21h


delay proc near
    push ax
    push dx

    mov dx, 0010h           
    mov ax, 0000h           
s1:
    sub ax, 1               
    sbb dx, 0               
    cmp ax, 0
    jne s1                  
    cmp dx, 0
    jne s1                  

    pop dx
    pop ax
    ret
delay endp


int9 proc far       
    
    push ax
    push bx
    push cx
    push dx
    push ds
    push es

    
    mov ax, SEG data
    mov ds, ax

    
    pushf                    
    pushf                    
    pop ax
    and ah, 11111100b        
    push ax
    popf                     

    call dword ptr ds:[old_int9]

    
    mov ax, 0040h
    mov es, ax              

    mov bx, es:[1Ch]        
    sub bx, 2               
    cmp bx, 1Eh             
    jge short key_ok        
    mov bx, 3Eh             
key_ok:
    
    cmp byte ptr es:[bx], 1Bh   
    jne short int9_exit         

    
    cmp byte ptr ds:[esc_flag], 1
    je short int9_exit            

    mov byte ptr ds:[esc_flag], 1 

    
    mov ax, 0B800h
    mov es, ax


    mov byte ptr es:[160*12 + 40*2 + 1], 02h   

int9_exit:
    
    pop es
    pop ds
    pop dx
    pop cx
    pop bx
    pop ax
    iret                    
int9 endp                   

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ss:stack


INT9_VEC     equ 9*4
OLD_OFF      equ 200h
NEW_OFF      equ 204h
VIDEO_SEG    equ 0B800h

stack segment stack
    db 128 dup (0)
stack ends

code segment
start:


    push cs                 
    pop ds

    xor ax, ax              
    mov es, ax

    mov si, offset int9     
    mov di, NEW_OFF
    mov cx, offset int9end - offset int9
    cld
    rep movsb

    
    mov ax, es:[INT9_VEC]       
    mov es:[OLD_OFF], ax        
    mov ax, es:[INT9_VEC+2]
    mov es:[OLD_OFF+2], ax

    
    cli
    mov word ptr es:[INT9_VEC], NEW_OFF
    mov word ptr es:[INT9_VEC+2], 0
    sti

    
    mov ax, 4C00h
    int 21h


int9:
    push ax
    push bx
    push cx
    push es

    in al,60h       

    
    pushf
    call dword ptr cs:[OLD_OFF] 

    
    cmp al,3Bh
    jne short int9ret

    
    mov ax,VIDEO_SEG
    mov es,ax
    mov bx,1
    mov cx,2000

change_loop:
    inc byte ptr es:[bx]
    add bx,2
    loop change_loop

int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    iret

int9end:
    nop

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code

code segment

start:
    
    mov ah, 0
    int 16h

    
    cmp al, 'r'
    je  set_red
    cmp al, 'g'
    je  set_green
    cmp al, 'b'
    je  set_blue
    jmp short sret      

set_red:
    mov ah, 4           
    jmp change_color

set_green:
    mov ah, 2           
    jmp change_color

set_blue:
    mov ah, 1           
    jmp change_color

change_color:
    mov bx, 0b800h
    mov es, bx
    mov bx, 1           
    mov cx, 2000        

s:
    
    and byte ptr es:[bx], 11111000b  
    or  byte ptr es:[bx], ah         
    add bx, 2
    loop s

sret:
    mov ax, 4c00h
    int 21h

code ends
end start


-----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code, ds:data

data segment
    stack_buf db 32 dup (0)     
    top dw 0                    
data ends

stack segment para stack 'STACK'
    db 128 dup (0)              
stack ends

code segment
start:
    mov ax, seg data            
    mov ds, ax
    mov si, offset stack_buf    

    mov dh, 12                  
    mov dl, 24

    call near ptr getstr        

return:
    
    mov ax, 4c00h
    int 21h

getstr:
    push ax                 
getstrs:
    mov ah, 0               
    int 16h

    cmp al, 20h             
    jb nochar               
    
    mov ah, 0
    call near ptr charstack
    
    mov ah, 2
    call near ptr charstack
    
    jmp getstrs

nochar:
    
    cmp ah, 0eh             
    je backspace
    cmp ah, 1ch             
    je enter
    jmp getstrs             

backspace:
    
    mov ah, 1               
    call near ptr charstack 
    
    mov ah, 2
    call near ptr charstack
    jmp getstrs

enter:
    
    mov al, 0               
    mov ah, 0               
    call near ptr charstack
    
    mov ah, 2
    call near ptr charstack
    pop ax                  
    ret                     

charstack:
    jmp short charstart
    
    table dw offset charpush, offset charpop, offset charshow
charstart:
    push bx
    push dx
    push di
    push es

    cmp ah, 2
    ja sret                 
    mov bl, ah
    mov bh, 0
    add bx, bx              
    
    jmp word ptr cs:[table + bx]  

charpush:
    
    mov bx, offset top      
    mov bx, ds:[bx]         
    cmp bx, 32              
    jae sret                
    
    mov ds:[si + bx], al
    
    mov bx, offset top
    mov ax, ds:[bx]
    inc ax
    mov ds:[bx], ax
    jmp sret


charpop:
    mov bx, offset top
    mov ax, ds:[bx]         
    cmp ax, 0
    je sret
    dec ax
    mov ds:[bx], ax         
    
    mov bx, ax              
    mov al, ds:[si + bx]     
    jmp sret


charshow:
    
    mov bx, 0b800h
    mov es, bx
    mov al, 160             
    mul dh                  
    mov di, ax              
    mov al, dl              
    
    shl al, 1                
    mov ah, 0
    add di, ax              

    
    mov bx, 0               
charshows:
    
    push bx                 
    mov bx, offset top
    mov cx, ds:[bx]         
    pop bx
    cmp bx, cx              
    jne noempty
    
    mov byte ptr es:[di], ' '
    mov byte ptr es:[di+1], 07h   
    jmp sret
noempty:
    mov al, ds:[si + bx]          
    cmp al, 0                     
    je after_char
    mov es:[di], al               
    mov byte ptr es:[di+1], 07h   
after_char:
    inc bx
    add di, 2
    jmp charshows

sret:
    pop es
    pop di
    pop dx
    pop bx
    ret

code ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:codeseg, ds:dataseg, ss:stackseg

dataseg segment

    
    mus_freq dw 440, 587, 587, 523, 494, 440, 392
             dw 440, 294
             dw 440, 587, 587, 523, 494, 392, 440, 492, 440, -1

    
    mus_time dw 25, 50, 25, 25, 25, 25, 25   
             dw 50, 150                       
             dw 25, 50, 25, 25, 12, 12, 50, 25, 50   
    
dataseg ends


stackseg segment            
    db 100h dup(0)          
stackseg ends


codeseg segment
start:

    
    cli                     
    mov ax, stackseg
    mov ss, ax
    mov sp, 100h
    sti                     


    mov ax, dataseg         
    mov ds, ax

    
    lea si, mus_freq
    lea di, mus_time

play:
    
    mov dx, [si]
    cmp dx, -1              
    je  end_play

    
    call sound

    
    add si, 2               
    add di, 2               
    jmp play

end_play:
    mov ax, 4C00h
    int 21h


sound proc near
    push ax
    push dx
    push cx

    
    mov al, 0B6h            

                            
    out 43h, al             

    
    mov dx, 12h
    mov ax, 34DCh
    div word ptr [si]       

    
    out 42h, al
    mov al, ah
    out 42h, al

    
    in  al, 61h
    mov ah, al              
    or  al, 3               
    out 61h, al

    
    mov dx, [di]            

wait1:
    mov cx, 28000           
delay:
    nop
    loop delay
    dec dx
    jnz wait1

    
    mov al, ah
    and al, 0FCh            
    out 61h, al


    pop cx
    pop dx
    pop ax
    ret
sound endp

codeseg ends
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
.8086
.MODEL small
.data
    str db 'hello world!$'

.stack 20H

.code
start: 
    mov ax,@data
    mov ds,ax
    lea bx,str
output:mov dl, ds:[bx]
    cmp dl, '$'
    je stop
    mov ah, 02H
    int 21h
    inc bx
    jmp output

    stop: mov ax,4c00h
    int 21h
end start


; -----------------------------------------------------------------------------------------------------------------------------------------
assume cs:code       

data segment         
    n1 db 1          
data ends            

code segment         
start:               
    mov ax, data     
    mov ds, ax       

    lea bx, n1       
    call subprog     
    call subprog     

    mov ax, 4c00h    
    int 21h          

subprog:             
    mov ax, bx       
    mov cx, ds:[bx]  
                     
    mov dx, 100h     
    ret              

code ends            
end start            

; -----------------------------------------------------------------------------------------------------------------------------------------
include D:\Assembly\2.3\asmio.mac

assume cs:codes,ds:datas
datas segment
    string db 'hello world',13,10,'$'
datas ends
  
codes segment
start:
    mov ax,datas
    mov ds,ax
    output string
    mov ah,4ch
    int 21h
codes ends
end start

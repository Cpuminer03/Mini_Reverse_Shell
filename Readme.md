�                  File     :         Mini Reverse Shell
�                  Language :    Win32 ASM
�                  FileSize :       2kb
�                  D.O.B.   :       February 23, 2006  
�                  Description: CMD line reverse shell in masm that shovels a shell back to your host:port

I made this in 2006 for use in exploiting a system, once executed this shovels a CMD shell back to
the attacker's netcat listener


How Compile:
Get MASM installed
From a CMD Prompt type the following:

c:\masm32\bin\ml /c /coff reverseshell.asm
c:\masm32\bin\link /SUBSYSTEM:WINDOWS /RELEASE /MERGE:.data=.text /MERGE:.rdata=.text /MERGE:.idata=.text /SECTION:.text,EWR /FILEALIGN:512 reverseshell.obj

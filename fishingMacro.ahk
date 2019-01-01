ReadMemory(MADDRESS,PROGRAM)
{
winget, pid, PID, %PROGRAM%

VarSetCapacity(MVALUE,4,0)
ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)

Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

return, result  
}

Numpad0::

WinGet, Trove_pid, PID, Trove

value := 0

loop 600
{

sleep 100
ControlSend,, {f down}, ahk_pid %Trove_pid%

sleep 100
ControlSend,, {f up}, ahk_pid %Trove_pid%

Loop
{
Pointer := ReadMemory(0x05D3639C,"Trove") ; // <!--Replace "0x05D3639C" with the designated memory address-->
sleep 1000
	If (Pointer = 1)
		Break
}

sleep 500
ControlSend,, {f down}, ahk_pid %Trove_pid%

sleep 100
ControlSend,, {f up}, ahk_pid %Trove_pid%

sleep 2000

}

ControlSend,, {alt down}, ahk_pid %Trove_pid%
sleep 10
ControlSend,, {f4 down}, ahk_pid %Trove_pid%
sleep 100
ControlSend,, {alt up}, ahk_pid %Trove_pid%
sleep 10
ControlSend,, {f4 up}, ahk_pid %Trove_pid%

Shutdown, 8
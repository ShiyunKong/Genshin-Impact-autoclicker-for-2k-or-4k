full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
I_Icon = Neuvillette.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

#IfWinActive ahk_exe YuanShen.exe

#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

; 设置CapsLock键为热键，按下时触发脚本
CapsLock::

    Sleep, 125

    ; 开始计时
    startTime := A_TickCount

    ; 循环
    Loop
    {        
        currentTime := A_TickCount - startTime

        ; 移动鼠标
        DllCall("mouse_event",uint,1,int,1000,int,0,uint,0,int,0)
        Sleep, 1

        ; 如果CapsLock或Space键被按下，或时长大于3s，退出循环
        if (GetKeyState("RButton", "P") || GetKeyState("Space", "P") || GetKeyState("CapsLock", "P"))
            break
    }
return

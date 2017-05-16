::Author: Charlie Ding @2017
@echo off
setlocal enabledelayedexpansion

reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v SMBDeviceEnabled >forbid445RegTemp.txt

set result=1

for /f "skip=2 tokens=3" %%i in (forbid445RegTemp.txt) do (
    set result=%%i
)
del /Q forbid445RegTemp.txt

if not %result% == 0x0 (
   reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 0 /f
)


sc config LanmanServer start=disabled

echo Defect Wanna Cry success.

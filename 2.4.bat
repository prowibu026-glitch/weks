@echo off
setlocal enabledelayedexpansion
cd /d %~dp0
title 3A Bypass - Kill Mode v2.4

echo ============================================
echo  3A CLOUD BYPASS - KILL MODE (AGRESIF)
echo  v2.4 - Integrated from external source
echo ============================================
echo.

:: KILL MONITORING (Aman & Terbukti)
echo [1/5] Killing monitoring processes...
taskkill /f /im pythonw.exe >nul 2>&1
taskkill /f /im GSDog.exe >nul 2>&1
taskkill /f /im GameServer.exe >nul 2>&1
taskkill /f /im FBCProcessMonitor.exe >nul 2>&1
taskkill /f /im hm-gs-proxy.exe >nul 2>&1
taskkill /f /im filebeat.exe >nul 2>&1
taskkill /f /im DeviceDispatchMonitor.exe >nul 2>&1
taskkill /f /im supervisord_alert_listener.exe >nul 2>&1
taskkill /f /im winlogbeat* >nul 2>&1
timeout /t 1 /nobreak >nul
echo        Done.
echo.

:: KILL SUPERVISORD (AGRESIF - dari pengalaman aman)
echo [2/5] Killing supervisord.exe...
taskkill /f /im supervisord.exe >nul 2>&1
if %errorlevel% equ 0 (
    echo        Supervisord killed successfully.
) else (
    echo        Supervisord not found or already killed.
)
timeout /t 1 /nobreak >nul
echo.

:: BYPASS GPO (Enhanced - Registry + Folder)
echo [3/5] Bypassing Group Policy (Enhanced)...
:: Hapus registry policies (NEW dari external)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows" /f >nul 2>&1
:: Hapus folder GroupPolicy
rd /s /q "C:\Windows\System32\GroupPolicy" >nul 2>&1
rd /s /q "C:\Windows\System32\GroupPolicyUsers" >nul 2>&1
gpupdate /force >nul 2>&1
echo        Done.
echo.

:: UNLOCK TASKMGR & TASKBAR
echo [4/5] Unlocking Task Manager & UI...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1

:: UI FIX
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%SystemRoot%\System32\shell32.dll,-50" /f >nul 2>&1
echo        Done.
echo.

:: SET BAHASA INDONESIA (NEW dari external)
echo [5/5] Setting language to Indonesian...
powershell -Command "$LangList = Get-WinUserLanguageList; $LangList[0].InputMethodTips.Clear(); $LangList[0].InputMethodTips.Add('0421:00000421'); Set-WinUserLanguageList $LangList -Force -ErrorAction SilentlyContinue; Set-WinDefaultInputMethodOverride -InputTip '0421:00000421' -ErrorAction SilentlyContinue" >nul 2>&1
echo        Done.
echo.

:: PERFORMANCE TWEAKS
echo [BONUS] Applying performance tweaks...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -h off >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v GPU Priority /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1

:: DISABLE SERVICES
sc config WSearch start= disabled >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
echo        Done.
echo.

:: RESTART SHELL
echo [FINAL] Restarting Explorer...
powershell -Command "Stop-Process -Name explorer -Force; Start-Process explorer.exe" >nul 2>&1
timeout /t 2 /nobreak >nul
powershell -Command "Start-Process 'C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe'; Start-Process 'C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe'" >nul 2>&1

echo.
echo ============================================
echo  SELESAI - Task Manager & Taskbar Unlocked
echo  v2.4 - Now with Indonesian language!
echo ============================================
echo.
echo Fitur baru v2.4:
echo - Enhanced GPO bypass (registry + folder)
echo - Auto-set bahasa Indonesia
echo.
echo Catatan:
echo - Supervisord KILLED (bukan suspend)
echo - Kalau VM restart, re-run script
echo - Hapus file ini setelah pakai: Shift + Delete
echo.
pause

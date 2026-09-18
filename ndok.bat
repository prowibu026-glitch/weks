@echo off
setlocal enabledelayedexpansion
cd /d %~dp0

:: ============================================
:: KILL MONITORING PROCESSES
:: ============================================
taskkill /f /im pythonw.exe >nul 2>&1
taskkill /f /im GSDog.exe >nul 2>&1
taskkill /f /im GameServer.exe >nul 2>&1
taskkill /f /im FBCProcessMonitor.exe >nul 2>&1
taskkill /f /im hm-gs-proxy.exe >nul 2>&1
taskkill /f /im filebeat.exe >nul 2>&1
taskkill /f /im DeviceDispatchMonitor.exe >nul 2>&1
timeout /t 1 /nobreak >nul

:: ============================================
:: BYPASS GROUP POLICY RESTRICTIONS
:: ============================================
rd /s /q "C:\Windows\System32\GroupPolicy" >nul 2>&1
rd /s /q "C:\Windows\System32\GroupPolicyUsers" >nul 2>&1
gpupdate /force >nul 2>&1

:: ============================================
:: UNLOCK TASK MANAGER & TASKBAR MENU
:: ============================================
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1

:: ============================================
:: UI FIXES (ICONS & SHORTCUT ARROW)
:: ============================================
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%SystemRoot%\System32\shell32.dll,-50" /f >nul 2>&1

:: ============================================
:: PERFORMANCE & GAMING OPTIMIZATIONS
:: ============================================
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -h off >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v GPU Priority /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1

:: ============================================
:: DISABLE UNNECESSARY SERVICES
:: ============================================
sc config WSearch start= disabled >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1

:: ============================================
:: RESTART EXPLORER & SHELL COMPONENTS
:: ============================================
powershell -Command "Stop-Process -Name explorer -Force; Start-Process explorer.exe" >nul 2>&1
timeout /t 2 /nobreak >nul
powershell -Command "Start-Process 'C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe'; Start-Process 'C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe'" >nul 2>&1

@echo off
setlocal enabledelayedexpansion
cd /d %~dp0
title 3A Bypass - Kill Mode v2.3

echo ============================================
echo  3A CLOUD BYPASS - KILL MODE (AGRESIF)
echo ============================================
echo.

:: KILL MONITORING (Aman & Terbukti)
echo [1/4] Killing monitoring processes...
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
echo [2/4] Killing supervisord.exe...
taskkill /f /im supervisord.exe >nul 2>&1
if %errorlevel% equ 0 (
    echo        Supervisord killed successfully.
) else (
    echo        Supervisord not found or already killed.
)
timeout /t 1 /nobreak >nul
echo.

:: BYPASS GPO
echo [3/4] Bypassing Group Policy...
rd /s /q "C:\Windows\System32\GroupPolicy" >nul 2>&1
rd /s /q "C:\Windows\System32\GroupPolicyUsers" >nul 2>&1
gpupdate /force >nul 2>&1
echo        Done.
echo.

:: UNLOCK TASKMGR & TASKBAR
echo [4/4] Unlocking Task Manager & UI...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayContextMenu /t REG_DWORD /d 0 /f >nul 2>&1

:: UI FIX
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%SystemRoot%\System32\shell32.dll,-50" /f >nul 2>&1
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
echo ============================================
echo.
echo Catatan:
echo - Supervisord KILLED (bukan suspend)
echo - Kalau VM restart, re-run script
echo - Hapus file ini setelah pakai: Shift + Delete
echo.
pause

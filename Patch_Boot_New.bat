@echo off
color 0a
mode con: cols=80 lines=20
:MENU
color 0a
title Android Image Patch Tool
cls
echo.+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
echo.I                                                                             I
echo.I                         Android Image Patch Tool                            I
echo.I                                                                             I
echo.I                                                               by 3408168060 I
echo.+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
echo.
:PATCH
setlocal enabledelayedexpansion
set MAGISKBOOT_WINSUP_NOCASE=1
if exist boot.img (
	set BOOTIMG=boot.img
	set PatchFlag=
	set /p PatchFlag="��⵽��ǰĿ¼��boot.img�����ļ� !BOOTIMG! �Ƿ��޲�? (y/n)"
                echo.
	if /i "!PatchFlag!" == "y" goto STARTPATCH
	if /i "!PatchFlag!" == "n" goto CUSTOMPATCH
	goto PATCH
)
:CUSTOMPATCH
set BOOTIMG=
set /p BOOTIMG="������Ҫ�޲����ļ�·�����˽����޲�:"
echo.
if not exist !BOOTIMG! ( echo.δ��⵽�ļ� %BOOTIMG% & goto CUSTOMPATCH) else ( goto STARTPATCH )
:STARTPATCH
set/p superkey=��������Ҫ�Զ������Կ��

if exist boot_patched.img (del /s /q boot_patched.img 1>nul 2>nul)
echo.
bin\busybox bash bin/boot_patch.sh !superkey! !BOOTIMG!
if exist new-boot.img (
    echo.
	move new-boot.img boot_patched.img 1>nul 2>nul & echo. Output file is written to "boot_patched.img"
) else ( 
    echo.
	echo.�޲� boot.img ���� & pause & goto PATCH
)
echo.
pause
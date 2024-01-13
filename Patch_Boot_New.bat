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
	set /p PatchFlag="检测到当前目录下boot.img镜像文件 !BOOTIMG! 是否修补? (y/n)"
                echo.
	if /i "!PatchFlag!" == "y" goto STARTPATCH
	if /i "!PatchFlag!" == "n" goto CUSTOMPATCH
	goto PATCH
)
:CUSTOMPATCH
set BOOTIMG=
set /p BOOTIMG="请输入要修补的文件路径到此进行修补:"
echo.
if not exist !BOOTIMG! ( echo.未检测到文件 %BOOTIMG% & goto CUSTOMPATCH) else ( goto STARTPATCH )
:STARTPATCH
set/p superkey=请输入你要自定义的秘钥：

if exist boot_patched.img (del /s /q boot_patched.img 1>nul 2>nul)
echo.
bin\busybox bash bin/boot_patch.sh !superkey! !BOOTIMG!
if exist new-boot.img (
    echo.
	move new-boot.img boot_patched.img 1>nul 2>nul & echo. Output file is written to "boot_patched.img"
) else ( 
    echo.
	echo.修补 boot.img 出错 & pause & goto PATCH
)
echo.
pause
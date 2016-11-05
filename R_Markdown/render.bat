@echo off
setlocal enabledelayedexpansion
cd %~dp0

rem ################# Usage
rem render.bat <inputFile> <outputFile> <Arg01> <Arg02>

rem ################# set parameters
set R_Inst_Dir=C:\x\R\R-3.3.1\bin
set logFile=RScript.log

set inputFile=%1
set outputFile=%2

set R_Arg01=%3
set R_Arg02=%4

rem ################# render
%R_Inst_Dir%\\Rscript.exe render.R %inputFile% %outputFile% >> %logFile% 2>&1

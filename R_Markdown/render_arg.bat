@echo off
setlocal enabledelayedexpansion
cd %~dp0

rem ################# Usage
rem render_arg.bat <inputFile> <outputFile> <Arg01> <Arg02> <Arg03>

rem ################# set parameters
set R_Inst_Dir=C:\x\R\R-3.3.1\bin
set logFile=RScript.log

set inputFile=%1
set outputFile=%2

set R_Arg01=%3
set R_Arg02=%4
set R_Arg03=%5

rem ################# render
%R_Inst_Dir%\\Rscript.exe render_arg.R %inputFile% %outputFile% %R_Arg01% %R_Arg02% %R_Arg03% >> %logFile% 2>&1

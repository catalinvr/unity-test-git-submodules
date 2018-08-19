REM Example scripting\unlink-submodule DummyProject\Assets\com.company.product_2
SET SymlinkTarget=%1

IF [%SymlinkTarget%] == [] GOTO :missingTarget

rmdir %SymlinkTarget%
del %SymlinkTarget%.meta

call %~dp0\config.bat
REM findstr /v %SymlinkTarget% %GitignoreFile% > %GitignoreFile%
REM type %GitignoreFile% | findstr /v %SymlinkTarget%
REM findstr /v /i "abc" %GitignoreFile% > %GitignoreFile%
REM ECHO %SymlinkTarget%
REM type %GitignoreFile% | findstr /v /i %SymlinkTarget%

REM findstr /v /i /c:%SymlinkTarget%\* %GitignoreFile%
REM findstr /v /i /c:%SymlinkTarget%\.keep %GitignoreFile% 
type %GitignoreFile% | find /v "%SymlinkTarget%\*" | find /v "%SymlinkTarget%\.keep" > %GitignoreFile%

GOTO :EOF


:missingTarget
ECHO "Missing target location"
GOTO :EOF
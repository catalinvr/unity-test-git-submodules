call %~dp0\config.bat

SET GitRepository=%1
SET ProjectName=%2

CD /D %SubmodulesRoot%
git submodule add %GitRepository% %ProjectName%
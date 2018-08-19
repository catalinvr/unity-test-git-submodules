REM Example scripting\unlink-submodule DummyProject\Assets\com.company.product_2
SET SymlinkTarget=%1

IF [%SymlinkTarget%] == [] GOTO :missingTarget

rmdir %SymlinkTarget%
del %SymlinkTarget%.meta

GOTO :EOF


:missingTarget
ECHO "Missing target location"
GOTO :EOF
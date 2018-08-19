REM Open cmd as administrator
REM Example: scripting\symlink-submodule submodules\unity-sample-project\SampleProject\Assets\com.company.product DummyProject\Assets\com.company.product_2

@ECHO off

SET SubmoduleSource=%1
SET SubmoduleTarget=%2

IF [%SubmoduleSource%] == [] GOTO missingSource
IF [%SubmoduleTarget%] == [] GOTO missingTarget

REM mklink /J DummyProject\Assets\com.company.product_2 submodules\unity-sample-project\SampleProject\Assets\com.company.product
mklink /J %SubmoduleTarget% %SubmoduleSource%

GOTO :EOF




@ECHO on

:missingSource
ECHO "Source undefined"
GOTO :EOF

:missingTarget
ECHO "Target undefined"
GOTO :EOF


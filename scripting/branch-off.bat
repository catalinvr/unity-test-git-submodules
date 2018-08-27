:: Example: scripting\branch-off unity-sample-project DummyProject 2018.2.4f1

SET Submodule=submodules\%1
SET Project=%2
SET TAG=%Project%-%3
SET Message="Used as submodule in %Project%"
SET Branch=submodule-%Project%

:: Try to change directory
SET CurrentDirectory=%cd%
CD %Submodule%
IF %errorlevel% EQU 1 GOTO :EOF

:: Try to checkout new branch
git checkout -b %Branch%
IF %errorlevel% EQU 1 GOTO :EOF

:: Try to tag local branch
git tag -a %TAG% -m %Message%
IF %errorlevel% EQU 1 GOTO :EOF

:: Try to connect with remote repository
git push --set-upstream origin %Branch%
IF %errorlevel% EQU 1 GOTO :EOF

:: Publish new branch in remote repository
git push
IF %errorlevel% EQU 1 GOTO :EOF

:: Publish tag
git push origin %TAG%
IF %errorlevel% EQU 1 GOTO :EOF

CD %CurrentDirectory%
ECHO Branching was successful

GOTO :EOF
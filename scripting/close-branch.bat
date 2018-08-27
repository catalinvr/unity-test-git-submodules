:: Example: scripting\close-branch unity-sample-project DummyProject 2018.2.4f1

SET Submodule=submodules\%1
SET Project=%2
SET NewTag=%Project%-%3-closed
SET OldTag=%Project%-%3
SET Message="Not longer needed in %Project%"
SET Branch=submodule-%Project%

SET CurrentDirectory=%cd%
CD %Submodule%
IF %errorlevel% NEQ  0 GOTO :EOF

git tag -a %NewTag% -m %Message% %Branch%
IF %errorlevel% NEQ  0 (
    CALL :replaceTag
)
ELSE (
    git push --tags
)

::CALL :deleteLocalAndRemoteBranch %Branch%

CD %CurrentDirectory%

GOTO :EOF



:replaceTag
    git tag %NewTag% %OldTag%
    IF %errorlevel% NEQ  0 GOTO :EOF
    git tag -d %OldTag%
    IF %errorlevel% NEQ  0 GOTO :EOF
    git push origin :refs/tags/%OldTag%
    IF %errorlevel% NEQ  0 GOTO :EOF
    git push --tags
GOTO :EOF

:deleteLocalAndRemoteBranch
    git checkout master
    git branch -d %1
    git push origin :%1
GOTO :EOF
REM Example: scripting\branch-off unity-sample-project DummyProject 2018.2.4f1

SET Submodule=submodules\%1
SET Project=%2
SET TAG=%Project%-%3-closed
SET Message="Not longer needed in %Project%"
SET Branch=submodule-%Project%

SET CurrentDirectory=%cd%

CD %Submodule%

git tag -a %TAG% -m %Message%
git push --tags

::CALL :deleteLocalAndRemoteBranch %Branch%

CD %CurrentDirectory%

GOTO :EOF


:deleteLocalAndRemoteBranch
git checkout master
git branch -d %1
git push origin :%1
GOTO :EOF

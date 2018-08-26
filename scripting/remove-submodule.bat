:: Example: scripting\remove-submodule unity-sample-project

CALL %~dp0\config.bat

SET ProjectName=%1
SET LocalPath=%SubmodulePath%\%ProjectName%

:: Remove entry from .git/config
git submodule deinit -f -- %LocalPath%

:: Remove directory from the superproject's .git/modules directory
rmdir /s /q .git\modules\%LocalPath%

:: Remove entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f %LocalPath%
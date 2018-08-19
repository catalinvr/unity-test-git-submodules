REM Example: scripting\remove-submodule unity-sample-project

call %~dp0\config.bat

SET GitSubmodule=%1

REM Remove the submodule entry from .git/config
git submodule deinit -f -- %SubmodulesFoldername%\%GitSubmodule%

REM Remove the submodule directory from the superproject's .git/modules directory
rmdir /s /q .git\modules\%SubmodulesFoldername%\%GitSubmodule%

REM Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f %SubmodulesFoldername%\%GitSubmodule%
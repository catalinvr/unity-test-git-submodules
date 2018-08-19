call %~dp0\config.bat
CD /D %SubmodulesRoot%

SET GitSubmodule=%1

git submodule deinit -f -- %SubmodulesFoldername%\%GitSubmodule%
rm -rf .git\modules\%SubmodulesFoldername%\%GitSubmodule%
git rm -f %GitSubmodule%
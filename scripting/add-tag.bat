REM Example: scripting\add-tag unity-sample-project DummyProject 2018.2.4f1

SET Submodule=submodules\%1
SET Project=%2
SET TAG=%Project%-%3
SET Message="Used as submodule in %Project%"

SET CurrentDirectory=%cd%

CD %Submodule%

REM git checkout -b submodule-%Project%
REM git tag -a %TAG% -m %Message%
REM git push origin %TAG%

CD %CurrentDirectory%
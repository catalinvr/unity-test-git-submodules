scripting\add-submodule https://github.com/lars-wobus/unity-sample-project unity-sample-project
scripting\symlink-submodule submodules\unity-sample-project\SampleProject\Assets\com.company.product DummyProject\Assets\com.company.product_2
scripting\unlink-submodule DummyProject\Assets\com.company.product_2
scripting\remove-submodule unity-sample-project


REM Tip: If you see something like this:
REM 'submodules\unity-sample-project' already exists in the index”
REM then check if the folder is already staged:
REM git ls-files --stage submodules
REM If that is true, then execute the following:
REM git rm --cached submodules\unity-sample-project
REM Step 1 - add submodule
scripting\add-submodule https://github.com/lars-wobus/unity-sample-project unity-sample-project

REM Step 2 - connect submodule with project
REM scripting\symlink-submodule submodules\unity-sample-project\SampleProject\Assets\com.company.product DummyProject\Assets\com.company.product_2

set SourceDNS=com.company.product
set TargetDNS=com.company.product
set SubmoduleAssetsPath=submodules\unity-sample-project\SampleProject\Assets
set ProjectPath=DummyProject\Assets

set folder[0]=Editor Default Resources
set folder[1]=Gizmos
set folder[2]=Plugins
set folder[3]=Standard Assets
set folder[4]=StreamingAssets

set subfolder[0]=Android
set subfolder[1]=iOS
set subfolder[2]=x86
set subfolder[3]=x86_64

scripting\symlink-submodule %SubmoduleAssetsPath%\%SourceDNS% %ProjectPath%\%TargetDNS%

scripting\symlink-submodule %SubmoduleAssetsPath%\!%folder[0]%!\%SourceDNS% %ProjectPath%\!%folder[0]%!\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[1]%\%SourceDNS% %ProjectPath%\%folder[1]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[2]%\%subfolder[0]%\%SourceDNS% %ProjectPath%\%folder[2]%\%subfolder[0]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[2]%\%subfolder[1]%\%SourceDNS% %ProjectPath%\%folder[2]%\%subfolder[1]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[2]%\%subfolder[2]%\%SourceDNS% %ProjectPath%\%folder[2]%\%subfolder[2]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[2]%\%subfolder[3]%\%SourceDNS% %ProjectPath%\%folder[2]%\%subfolder[3]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[3]%\%SourceDNS% %ProjectPath%\%folder[3]%\%TargetDNS%
scripting\symlink-submodule %SubmoduleAssetsPath%\%folder[4]%\%SourceDNS% %ProjectPath%\%folder[4]%\%TargetDNS%

REM Step 3 - disconnect submodule with project
REM scripting\unlink-submodule DummyProject\Assets\com.company.product_2
scripting\unlink-submodule %ProjectPath%\%TargetDNS%

scripting\unlink-submodule %ProjectPath%\%folder[0]%\%TargetDNS%
scripting\unlink-submodule %ProjectPath%\%folder[1]%\%TargetDNS%
scripting\unlink-submodule %ProjectPath%\%folder[2]%\%TargetDNS%
scripting\unlink-submodule %ProjectPath%\%folder[3]%\%TargetDNS%
scripting\unlink-submodule %ProjectPath%\%folder[4]%\%TargetDNS%

REM Step 4 - remove submodule
scripting\remove-submodule unity-sample-project


REM Tip: If you see something like this:
REM 'submodules\unity-sample-project' already exists in the index”
REM then check if the folder is already staged:
REM git ls-files --stage submodules
REM If that is true, then execute the following:
REM git rm --cached submodules\unity-sample-project
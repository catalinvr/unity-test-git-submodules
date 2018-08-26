# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

```diff
- Important Note: On windows, do not create symlinks, as stated below.
- Instead create shortcuts!
- When shortcuts are added/staged for the next commit, git will automatically add a .lnk file as placeholder.
- When cloning repositories containing .lnk files, git will automatically try to restore shortcuts.
```

## Abstract
Git submodules allow sharing files between projects. But using them in Unity projects, requires some preliminary steps. The proposed solution ~~uses symlinks~~ will use shortcuts and makes sure that gitignore files are kept up-to-date over the entire lifetime of projects. An additional mechanism prevents users from accidentally duplicating existing files into other repositories

## Implementation/Usage
The proposed workflow can be summarized into four steps:

```diff
- This section is being reworked
```

1. [Add submodule to project](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/scripting/add-submodule.bat) 
    - update .gitmodules file
2. [Use submodule in Unity](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/scripting/symlink-submodule.bat)
    - create symlinks between submodule and Assets folder
    - create .keep files within submodule
    - update .gitignore file (ignore all files in submodule except for .keep file)
3. [Stop using submodule in Unity](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/scripting/unlink-submodule.bat) 
    - remove symlinks within Assets folder
    - update .gitignore file (ignore no files in submodule)
4. [Remove submodule from project](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/scripting/remove-submodule.bat) 
    - remove submodule (including .keep file)
    - update .git/modules/submodules folder
    - update .gitmodules file

## Result
After executing step 1 and 2, users are enabled to checkout submodules and modify files within other projects. The obtained project structure should look similar to this:

```diff
- The image below propose to use of symlinks. Instead use shortcuts on Windows. Shortcuts should be availabel since Windows Vista.
```

![Achieved project structure](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/final-directory-structure.png)

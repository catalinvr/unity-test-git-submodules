# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

```diff
- Important Note: On windows, do not create symlinks, as stated below.
- Instead create shortcuts!
- When shortcuts are added/staged for the next commit, git will automatically add a .lnk file as placeholder.
- When cloning repositories containing .lnk files, git will automatically try to restore shortcuts.
```

## Abstract
Git submodules allow sharing files between projects. But using them in Unity projects, requires some preliminary steps. The proposed solution uses symlinks and makes sure that gitignore files are kept up-to-date over the entire lifetime of projects. An additional mechanism prevents users from accidentally duplicating existing files into other repositories

## Related Work
- [Symbolic links from submodules to plugins folder](http://prime31.github.io/A-Method-for-Working-with-Shared-Code-with-Unity-and-Git/)
- [Sparse checkouts](https://medium.com/@andybak_95963/neater-unity-2018-projects-with-git-submodules-and-sparse-checkout-3294e626a6f9)
- [Assembly Definition Files](https://docs.unity3d.com/Manual/ScriptCompilationAssemblyDefinitionFiles.html)

## Implementation/Usage
The proposed workflow can be summarized into four steps:

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
    
## Observations
[Github for Unity](https://unity.github.com/) shows local changes in submodules, but neither committing nor pushing files inside submodules is possible in version 1.0.0 and version 1.0.2. Additional note: Stashing files via the editor window does not seem to be supported. Unfortunately pulling from remote is only possible when everything which has changed was committed or reverted. That means working in teams on the same branch plus committing subsets of changed files becomes more difficult.

Repositories can be added multiple times as submodules with different names. So working with multiple branches at once, seems to be possible. But linking folders into the Assets folder becomes more difficult. There are much more situations for collisions, e.g. occurence of scripts with the same name and the same namespace.

## Result
After executing step 1 and 2, users are enabled to checkout submodules and modify files within other projects. The obtained project structure should look similar to this:

![Achieved project structure](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/final-directory-structure.png)

## Final Thoughts

### About Unity 
- Unity might display some warnings mentioning that GUIDs are already in use. One consequence of that behaviour could be frequent updates of .meta files in shared projects.

### About Git
- Git does not add empty folders, but Unity adds a .meta file for each folder on creation. When other team members are checking out the repository for the first time, Unity will complain about .meta files having no relation to any existing folder. Cause there are so many possible situations were users create empty folders, I think each folder within Assets should get its own .keep file right from the beginning. 

- .gitignore requires forward slashes But the provided batch files require paths containing backslashes. To convert strings, one can use the following command: 
```batch
SET MyVar=%MyVar:\=/%
```

- When adding a submodule, it might be a wise choice to create another branch in that submodule, named after the project using the submodule. This should become in handy, when submodules were created in the past when another version of Unity was in use. If both projects are still maintained, merging files from the master branch into the newly created branch, seems to be the safest way to integrate new features.

### About Assembly Definition Files
- The use of assembly definition files must be still evaluated!
- One major question to answer is, if assembly definition files should be shared or not. Right now, I would say yes. Not sharing them should not bring any advantages. And modifying or replacing them would result in maintaining another branch for each submodule.
- Important note:
> It is highly recommended that you use assembly definition files for all the scripts in the Project, or not at all. Otherwise, the scripts that are not using assembly definition files always recompile every time an assembly definition file recompiles. This reduces the benefit of using assembly definition files.
>
> &mdash; <cite>[docs.unity3d.com](https://docs.unity3d.com/Manual/ScriptCompilationAssemblyDefinitionFiles.html)</cite>

## Further reading:
- [Gitattributes/Callapsing diffs](https://robots.thoughtbot.com/how-to-git-with-unity)

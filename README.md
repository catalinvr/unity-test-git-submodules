# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

## Abstract
Git submodules allow sharing files between projects. But using them in Unity projects, requires some preliminary steps. The proposed solution uses symlinks and makes sure that gitignore files are kept up-to-date over the entire lifetime of projects. An additional mechanism prevents users from accidentally duplicating existing files into other repositories

## Related Work
- [Symbolic links from submodules to plugins folder](http://prime31.github.io/A-Method-for-Working-with-Shared-Code-with-Unity-and-Git/)
- [Sparse checkouts](https://medium.com/@andybak_95963/neater-unity-2018-projects-with-git-submodules-and-sparse-checkout-3294e626a6f9)
- [Assembly Definition Files](https://docs.unity3d.com/Manual/ScriptCompilationAssemblyDefinitionFiles.html)

## Assumptions
<details>

For some time, I am watching my colleagues using Perforce as their main version control system. It looks like a proper way to bypass the problem many people have with git when they try to share assets between projects. In Perforce it is pretty easy to modify the import paths of streams to sync files into projects. But keeping all projects up-to-date is still a time-consuming task.

Git offers submodules and subtrees. At least one of those features should enable us to share files between projects. Right now, I am still not convinced, that creating symlinks pointing into the Plugins folder is the proper way to share files. The main reason is, that some projects might have important assets stored in some of Unity's special folders (see one of my [other repositories](https://github.com/lars-wobus/unity-blank-asset-directory) for more information). A consequence of this would be the creation of multiple symlinks per repository. Some are pointing into the Plugins folder. The rest must be manually setup to point to other locations. Moreover, as far as I know, committing symlinks on Windows does not work. That means, one has to develop a complex strategy to ignore specific files and folders plus team members have to repeat all steps to create symlinks on their own.

While reading some threads and blog posts about the mentioned problem, I had an idea to create a special branch to store submodules. That means, one can pick required files and add them into other branches. But updating those files becomes more complicated. Moreover applying this strategy would lead to duplicated files and a rapid increase of repository sizes.

There is still another problem to solve. How can those files be identified by other users. The first thing I came up with, is the creation of project-related folders in each of Unity's special folders. The result could look like this:

![Sample content in Assets folder](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/sample-directory-structure.png)
  
> What would happen, if some ideas of both strategies above will be combined?

Submodules will be placed outside of the current projects Assets folder. Their content is sym-linked into subfolders, which are already prepared in the Assets folder. Those folders must be identifiable and mentioned in .gitignore files. Shell and Batch scripts could take care of creating a couple of symlinks. The main advantage is, that users can manually remove symlinks, if they are certain, that some content will never be used to build their current project.

That sounds like a solution worth evaluating!

</details>

## Implementation/Usage
The proposed workflow can be summarized in four steps:

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

![Achieved project structure](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/final-directory-structure.png)

## Final Thoughts

### About Unity 
- Unity might display some warnings mentioning that GUIDs are already in use. One consequence of that behaviour could be frequent updates of .meta files in all shared projects.

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

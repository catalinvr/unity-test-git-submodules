# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

## Different strategies:
- [Symbolic links from submodules to plugins folder](http://prime31.github.io/A-Method-for-Working-with-Shared-Code-with-Unity-and-Git/)
- [Sparse checkouts](https://medium.com/@andybak_95963/neater-unity-2018-projects-with-git-submodules-and-sparse-checkout-3294e626a6f9)

Further reading:
- [Gitattributes/Callapsing diffs](https://robots.thoughtbot.com/how-to-git-with-unity)

## Provisional Decision

For some time, I am watching my colleagues using Perforce as their main version control system. It looks like a proper way to bypass the problem many people have with git when they try to share assets between projects. In Perforce it is pretty easy to modify the import paths of streams to sync files into projects. But keeping all projects up-to-date is still a time-consuming task.

Git offers submodules and subtrees. At least one of those features should enable us to share files between projects. Right now, I am still not convinced, that creating symlinks pointing into the Plugins folder is the proper way to share files. The main reason is, that some projects might have important assets stored in some of Unity's special folders (see one of my [other repositories](https://github.com/lars-wobus/unity-blank-asset-directory) for more information). A consequence of this would be the creation of multiple symlinks per repository. Some are pointing into the Plugins folder. The rest must be manually setup to point to other locations. Moreover, as far as I know, committing symlinks on Windows does not work. That means, one has to develop a complex strategy to ignore specific files and folders plus team members have to repeat all steps to create symlinks on their own.

While reading some threads and blog posts about the mentioned problem, I had an idea to create a special branch to store submodules. That means, one can pick required files and add them into other branches. But updating those files becomes more complicated. Moreover applying this strategy would lead to duplicated files and a rapid increase of repository sizes.

There is still another problem to solve. How can those files be identified by other users. The first thing I came up with, is the creation of project-related folders in each of Unity's special folders. The result could look like this:

![Sample content in Assets folder](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/sample-directory-structure.png)

### Update

> What would happen, if some ideas of both strategies above will be combined?

Submodules will be placed outside of the current projects Assets folder. Their content is sym-linked into subfolders, which are already prepared in the Assets folder. Those folders must be identifiable and mentioned in .gitignore files. Shell and Batch scripts could take care of creating a couple of symlinks. The main advantage is, that users can manually remove symlinks, if they are certain, that some content will never be used to build their current project.

That sounds like a solution worth evaluating!

## Final Thoughts

The proposed way seems to work. Users can checkout submodules and modify files within other projects. Unity might display some warnings mentioning that GUIDs are already in use. One consequence of that behaviour could be frequent updates of .meta files in all of your shared projects.

> Cause there are so many possible situations were users create empty folders, I think each folder within Assets should get its own .keep file right from the beginning.

### About Git
.gitignore requires forward slashes But the provided batch files require paths containing backslashes. To convert strings, one can use the following command:

```batch
SET MyVar=%MyVar:\=/%
```

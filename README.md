# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

## Different strategies:
- [Symbolic links from submodules to plugins folder](http://prime31.github.io/A-Method-for-Working-with-Shared-Code-with-Unity-and-Git/)
- [Sparse checkouts](https://medium.com/@andybak_95963/neater-unity-2018-projects-with-git-submodules-and-sparse-checkout-3294e626a6f9)

Further reading:
- [Gitattributes/Callapsing diffs](https://robots.thoughtbot.com/how-to-git-with-unity)

## Provisional Decision

For some time, I am watching my colleagues using Perforce as their main version control system. It looks like a proper way to bypass the problem many people have with git when they try to share assets between projects. In Perforce it is pretty easy to modify the import paths of streams to sync files into projects. But keeping all projects up-to-date is still a time-consuming task.

Git offers submodules and subtrees. At least one of those features should enable us to share files between projects. Right now, I am still not convinced, that creating symlinks pointing into the Plugins folder is the proper way to share files. The main reason is, that some projects might have important assets stored in some of Unity's special folders (see [A](https://github.com/lars-wobus/unity-blank-asset-directory)). A consequence of this would be the creation of multiple symlinks per repository. Some are pointing into the Plugins folder. The rest must be manually setup to point ot other locations. Moreover, as far as I know, committing symlinks on Windows does not work.

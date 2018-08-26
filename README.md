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

## Workflow

![State machine describing workflow for creating new repositories containing submodules](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/workflow-1.png)


## Result
After executing step 1 and 2, users are enabled to checkout submodules and modify files within other projects. The obtained project structure should look similar to this:

![Achieved project structure](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/final-directory-structure.png)

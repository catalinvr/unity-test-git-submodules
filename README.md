# unity-test-git-submodules
Repository to evaluate strategies in terms of sharing code by using git submodules

```diff
- Important Note:
- The proposed workflow is currently reworked!
- Uniy and Rider can resolve symlinks but not windows shortcuts
- Git can restore shortcuts when checking out the repo on another machine, but not symlinks
- The best solution right now, seems to manually symlink folders again on each machine checking a repository including submodules
```

## Abstract
Git submodules allow sharing files between projects. But using them in Unity projects, requires some preliminary steps. The proposed solution uses symlinks (and probably shortcuts someday) to link folders into the Assets folder. Simultaneously it makes sure that gitignore files are kept up-to-date over the entire lifetime of the project.

## Workflow

![State machine describing workflow for creating new repositories containing submodules](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/workflow-1.png)


## Result
The obtained project structure should look similar to this:

![Achieved project structure](https://github.com/lars-wobus/unity-test-git-submodules/blob/master/res/umlet/final-directory-structure.png)

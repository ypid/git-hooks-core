# git-hooks-core

> *An opinionated use of the `core.hooksPath` feature released in Git 2.9.*

## About

This repository is meant to be used as the directory that the Git `core.hooksPath` config value is pointed at.

It exists because using the `core.hooksPath` feature is used in place of any local, repository-specific hooks in `.git/hooks`. This isn't necessarily what you want, as you may have repository-specific hooks that you want to run in addition to some hooks that should be global.

If you use this repository as your `core.hooksPath`, you will be able to:

* Retain any repository-specific hooks in `.git/hooks`
* Add hooks that will apply to all repositories in their respective *.d* folder in `~/.config/git/global_hooks`
* Use multiple files for hooks rather than a single file, as Git expects

And now that the hooks dir is outside of your repository, you can commit the global hooks for example in your dotfiles repo. Hooray!

## Installation

### Installing git-hooks-core

Clone this repo to your directory of choice, e.g. `~/.config/git/global_hooks/git-hooks-core`.
Point `core.hooksPath` at the installation directory.

```
git clone https://github.com/ypid/git-hooks-core.git ~/.config/git/global_hooks/git-hooks-core.
git config --global --add core.hooksPath ~/.config/git/global_hooks/git-hooks-core
```

### (Optional) Adding global hooks

Add any global hooks you'd like to their respective *.d* folder:

```
chmod +x my-commit-msg-hook
cp my-commit-msg-hook ~/.config/git/global_hooks/commit-msg.d
```

## Links

* [githooks](https://git-scm.com/docs/githooks)

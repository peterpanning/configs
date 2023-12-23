On zsh, bash, config files, and terminal emulators

In most Linux operating systems, opening a terminal emulator and starting a bash shell starts an interactive shell which is not a login shell--the way it is supposed to as according to bash's manual:

```
When an interactive shell that is not a login shell is started, Bash reads and
executes commands from `~/.bashrc', if that file exists. (This may be inhibited
by using the `--norc' option. The `--rcfile file' option will force Bash to
read and execute commands from file instead of `~/.bashrc').
```

That specifically does not load `/etc/profile` or other profile startup files, but those are loaded when you eg. run X or SSH to a server:

```
When Bash is invoked as an interactive login shell or as a non-interactive shell with the `--login` option (eg to start a bash shell in a script as if logged in as a particular user), it first uses `/etc/profile`, if that file exists, then uses the first readable file of `~/.bash_profile', `~/.bash_login', and `~/.profile', in that order.
```

This notably does not load .bashrc at all, so most `~/.bash_profile`s contains the line

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

after (or before) any login-specific initializations.


What about zsh?


Zsh's manual has a much shorter startup file section:

```
There are five startup files that zsh will read commands from:

$ZDOTDIR/.zshenv
$ZDOTDIR/.zprofile
$ZDOTDIR/.zshrc
$ZDOTDIR/.zlogin
$ZDOTDIR/.zlogout
If ZDOTDIR is not set, then the value of HOME is used; this is the usual case.

`.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
It should contain commands to set the command search path, plus other important
environment variables. `.zshenv' should not contain commands that produce output
or assume the shell is attached to a tty.

`.zshrc' is sourced in interactive shells. It should contain commands to set up
aliases, functions, options, key bindings, etc.

`.zlogin' is sourced in login shells. It should contain commands that should be
executed only in login shells. `.zlogout' is sourced when login shells exit.
`.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'.
`.zprofile' is meant as an alternative to `.zlogin' for ksh fans; the two are
not intended to be used together, although this could certainly be done if desired.
`.zlogin' is not the place for alias definitions, options, environment variable
settings, etc.; as a general rule, it should not change the shell environment at
all. Rather, it should be used to set the terminal type and run a series of external
commands (fortune, msgs, etc).
```

So zsh will ALWAYS (always) source the .zshenv, then the .zprofile if you have it,
your .zshrc, your .zlogin if you have it, and the .zlogout when you log out. Easy.


So Linux and bash use one startup process, but MacOS (which does not use X to load .bash_profile and now uses zsh as the default shell) uses another and we want our config files to be useful in both situations so that we can have as similar an environment as possible when we SSH to a Linux server. Furthermore, even if you use zsh, some programs assume you use bash and write important info to your .bashrc, .bash_profile, or .profile. So we need config files which allow us to use and load as much of both of these as we can. 


.profile has all our path modifications and known environment variables that we
want to load no matter which shell we're using, but does not produce or modify output. Then .bash_profile and .zshenv
load that file and add in new special-case settings for each shell (i.e. loading
.bashrc at the end of the bash_profile), and .bashrc and .zshrc have shell-specific
aliases, prompt modifications, etc. This ensures that the changes we make to the
.profile are always available, *even when we run Bourne shell scripts
with `sh`.*

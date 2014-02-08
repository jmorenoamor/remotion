Remotion: Remote interaction made simple
========================================

## What is Remotion?

Remotion is a shell function library for interacting with remote hosts, combining OpenSSH and expect

It's intended to be simple for the common cases, yet configurable for special needs

Enjoy it, share it, and send me a line if it makes your life easier

## Why?

Probably you will think of multiple ways to interact with remote hosts, SSH Public-Key Authentication being usually the best. But in some scenarios, I've faced the inability of enabling it, for instance, when you have an underprivileged readonly user without it's own home filesystem in the remote host. Or when the OpenSSH server is so misconfigured that there's no way of using a standard way of interacting with multiple hosts in a common way.

## Configuration

Zero configuration is needed, Remotion comes ready out of the box, as long as the very basic dependencies are available, OpenSSH and Expect.

### Managing verbosity

Remotion comes with all the interaction silenced, but you can enable it easily redefining the following variables in your script, after importing the library, this is useful for development time, to investigate errors and malfunctions.

    EXP_LOG_USER=0          # Change to 1 to enable the expect logging being sent to stdout
    EXP_NOECHO="-noecho"    # Disable the echoing produced by the spawn command, set to "" to enable it

Keep in mind that EXP_LOG_USER has precedence over everything else, disabling it will mute all the interaction

## Loading the library

As with any shell script, you can load the library by calling the source file from your script (preferable option) or if you want to embed it, you can just paste the contents directly in your script.

    # Load the logger library
    source ./remotion.sh

## Using the functions

Once loaded, using the library is as easy as calling the corresponding functions.

### Execute a command in a remote host
    remote_execute user password some_host "ls -ltr /tmp"

### Transfer a file from a remote host
    remote_getfile user password some_host /tmp/my_file /home/local_user/my_file

### Transfer a file to a remote host
    remote_putfile user password some_host /home/local_user/my_file /tmp/my_file

## Things to do

* Document error codes
* Work on configuration options
* Manage output redirections

## Contribute

* Check for open issues or open a new one to start a discussion around a feature idea or a bug.
* Fork the repository, make your changes and send a pull request.

## License

MIT license. See LICENSE for full text.

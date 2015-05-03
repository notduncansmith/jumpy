# jumpy

A simple command-line jump utility

## Usage (lite)

```sh
cd /Users/duncan/working
jump -a # Adds `/Users/duncan/working` as `working`
cd ~/Documents
jump working
pwd # /Users/duncan/working
```

## Usage

*Protip: Add `alias j='jump'` to your `~/.bashrc` file*

`j -a` - adds the current directory to your alias list

`j -a --as foo` - as above, but aliased to `foo` rather than the directory name

`j -r foo` - removes the `foo` alias

`j -l` - print all current aliases

`j -h` - show the help screen


Copyright Duncan Smith 2015
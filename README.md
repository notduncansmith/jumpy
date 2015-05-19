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


Before you can use it, you should probably install it!

### Step 1 - npm
`npm install -g jumpy`

### Step 2 - your bashrc/zshrc/whateverrc
Add the following line: `source /.npm-packages/lib/node_modules/jumpy/jump`

*Protip: Add `alias j='jump'` while you're there*

### Now use it

`j -a` - adds the current directory to your alias list

`j -a --as <alias>` - as above, but aliased to `<alias>` rather than the directory name

`j -s <server> --as <alias>` - adds the given server to the alias list under the given alias

`j -r` - removes the current directory from your alias list

`j -r foo` - removes the `foo` alias

`j -l` - print all current aliases

`j -h` - show the help screen


Copyright Duncan Smith 2015

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

`j -a --as foo` - as above, but aliased to `foo` rather than the directory name

`j -r foo` - removes the `foo` alias

`j -l` - print all current aliases

`j -h` - show the help screen


Copyright Duncan Smith 2015
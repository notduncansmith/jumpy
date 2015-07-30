fs = require 'fs'
touch = require 'touch'
path = require 'path'
pretty = require 'prettyjson'

CWD = process.cwd()
DIR = CWD.split('/').pop()

args = require('yargs')
.usage 'Usage: $0 <command> [options] or $0 <directory>'
.wrap null

.option 'a',
  describe: 'Add the current directory to the alias list'
  type: 'boolean'
  alias: 'add'

.option 's',
  describe: 'Add the given server to the alias list'
  type: 'string'
  alias: 'server'
.implies 's', 'as'

.option 'as',
  describe: 'Add the current directory to the alias list under the specified alias'
  example: '$0 -a --as foo', 'Add the current directory as "foo"'
  type: 'string'

.option 'd',
  describe: 'Remove the given alias'
  type: 'boolean'
  alias: ['delete', 'r', 'remove']

.help 'h'
.alias 'h', 'help'
.argv

FILE = "#{process.env.HOME}/.jumprc"
COMPLETIONS_DIR = "#{process.env.HOME}/.jump_completions"
COMPLETIONS_FILE = "#{process.env.HOME}/.jump_completions/_jump"

read = -> JSON.parse (fs.readFileSync(FILE, 'utf8') or '{}')
write = (paths) -> fs.writeFileSync FILE, JSON.stringify(paths)

# Make sure the file exists so we don't blow up
touch.sync FILE
mkdirp.sync COMPLETIONS_DIR
touch.sync COMPLETIONS_FILE

data = read()

add = (dir=DIR) ->
  data[dir] = CWD
  write data
  console.log "Added `#{CWD}` as `#{dir}`"

addServer = (server, alias) ->
  unless server?
    "Sorry, you must provide a server to alias (e.g. `j -s foo --as bar`)"
  else
    data[alias] = '$' + server
    write data
    console.log "Added `#{server}` as `#{alias}`"

remove = (target) ->
  if target is true
    target = args._

  if !data[target]
    console.log "`#{target}` is not a current alias"
  else
    old = data[target]
    delete data[target]
    write data
    console.log "Removed `#{target}`:`#{old}`"

list = ->
  if Object.keys(data).length is 0
    console.log "You don't have any aliases yet."
    console.log "Why don't you try adding one: `j -a`"
  else
    out = pretty.render data#, {noColor: true}
    console.log out

match = (dir) ->
  matches = Object.keys(data).filter (k) ->
    k.indexOf(dir) is 0

  data[matches[0]]

jump = (dir) ->
  target = data[dir]
  matched = match dir

  if target
    if target[0] is '$'
      process.stdout.write target
    else
      process.stdout.write "%#{target}"
  else if matched
    if matched[0] is '$'
      process.stdout.write matched
    else
      process.stdout.write "%#{matched}"
  else
    console.log "`#{dir}` is not a currently defined alias"

if args.l
  list()

else if args.a
  add args.as

else if args.s
  addServer args.s, args.as

else if args.d
  remove args.d

else if args.r
  remove args.r

else
  jump args._

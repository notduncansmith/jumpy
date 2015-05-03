#!/usr/bin/env node
var CWD, DIR, FILE, add, args, data, fs, jump, list, match, path, pretty, read, remove, touch, write;

fs = require('fs');

touch = require('touch');

path = require('path');

pretty = require('prettyjson');

CWD = process.cwd();

DIR = CWD.split('/').pop();

args = require('yargs').usage('Usage: $0 <command> [options] or $0 <directory>').wrap(null).option('a', {
  describe: 'Add the current directory to the alias list',
  type: 'boolean',
  alias: 'add'
}).option('as', {
  describe: 'Add the current directory to the alias list under the specified alias',
  example: '$0 -a --as foo'
}, 'Add the current directory as "foo"', {
  type: 'string'
}).implies('as', 'a').option('d', {
  describe: 'Remove the given alias',
  type: 'boolean',
  alias: ['delete', 'r', 'remove']
}).help('h').alias('h', 'help').argv;

FILE = process.env.HOME + "/.jumprc";

read = function() {
  return JSON.parse(fs.readFileSync(FILE, 'utf8') || '{}');
};

write = function(paths) {
  return fs.writeFileSync(FILE, JSON.stringify(paths));
};

touch.sync(FILE);

data = read();

add = function(dir) {
  if (dir == null) {
    dir = DIR;
  }
  data[dir] = CWD;
  write(data);
  return console.log("Added `" + CWD + "` as `" + dir + "`");
};

remove = function(target) {
  var old;
  if (target === true) {
    target = args._;
  }
  if (!data[target]) {
    return console.log("`" + target + "` is not a current alias");
  } else {
    old = data[target];
    delete data[target];
    write(data);
    return console.log("Removed `" + target + "`:`" + old + "`");
  }
};

list = function() {
  var out;
  if (Object.keys(data).length === 0) {
    console.log("You don't have any aliases yet.");
    return console.log("Why don't you try adding one: `jumpy -a`");
  } else {
    out = pretty.render(data);
    return console.log(out);
  }
};

match = function(dir) {
  var matches;
  matches = Object.keys(data).filter(function(k) {
    return k.indexOf(dir) === 0;
  });
  return data[matches[0]];
};

jump = function(dir) {
  var matched, target;
  target = data[dir];
  matched = match(dir);
  if (target) {
    return process.stdout.write("%" + target);
  } else if (matched) {
    return process.stdout.write("%" + matched);
  } else {
    return console.log("`" + dir + "` is not a currently defined alias");
  }
};

if (args.l) {
  list();
} else if (args.a) {
  add(args.as);
} else if (args.d) {
  remove(args.d);
} else if (args.r) {
  remove(args.r);
} else {
  jump(args._);
}

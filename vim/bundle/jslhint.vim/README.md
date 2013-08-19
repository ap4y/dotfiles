jslhint.vim
===========
jslint and jshint all in one with good performance.

##Performance

If you use `jslint.vim` and/or `jshint.vim` to check JavaScript code at real
time, you will find that the cursor moves slowly, especially on windows.

So you should use `jslhint.vim`, for it is optimized and has good performance.

##Installation
1. First of all, you should install node.js and you can find instructions for installing node.js on the [node.js website](http://nodejs.org/).


2. Then,  copy the directory `ftplugin/` into your Vim `ftplugin` directory.
Usually this is `~/.vim/ftplugin/`. On Windows it is `~/vimfiles/ftplugin/`.

3. Finally, activate filetype plugins in your `.vimrc`, by adding the following line:

```vim
filetype plugin on
```


##Usage

- This plugin automatically checks the JavaScript source and highlights the
  lines with errors.

  All errors will be displayed in `quickfix` window in vim. So you should open
  the  `quickfix` window with the command `:copen`.

  It also will display more information about the error in the command line if
  the cursor is in the same line.

- You also can call it manually via `:JSUpdate`.

- You can toggle `jslint` and `jshint` engines with the command `:JSToggle`.

- You can toggle automatically checking on or off with the command
`:JSToggleEnable`.  You can modify your `~/.vimrc` file to bind this command to
a key or to turn off error checking by default.

- (optional) Putting all jslint options into one file -- `.jslintrc` . The
  `.jslintrc` file should be placed under the root of project. It will be used as
  global options for all JavaScript files in the project. If `.jslintrc` file
  is not found in the project, the plugin will try to find `~/.jslintrc` file.
  You can putting jslint options into `.jslintrc` file like this:

```javascript
/*jslint browser: true, regexp: true */
/*global jQuery, $ */

```

- (optional) Putting all jshint options into one file -- `.jshintrc` . The
  `.jshintrc` file should be placed under the root of project. It will be used as
  global options for all JavaScript files in the project. If `.jshintrc` file
  is not found in the project, the plugin will try to find `~/.jshintrc` file.
  You can putting jshint options into `.jshintrc` file like this:

```json
{
  "undef": true,
  "unused": true,
  "globals": { "MY_GLOBAL": false }
}

```

##Configuration

* `g:JSLHint_jshint_default`

Set `jshint` as the default JavaScript checking engine or not, default value is
`1`. If you want to set `jslint` as the default JavaScript checking engine,
please add this line in `.vimrc`:

```vim
let g:JSLHint_jshint_default = 0
```

* `g:JSLHint_auto_check`

Checking JavaScript code at real time and automatically or not, default value
is `1`. If you want to manually call command manually, please disable auto
checking in `.vimrc`. For example:

```vim
"disable auto checking
let g:JSLHint_auto_check = 0
"to check JavaScript code when entering/writing buffer
au BufEnter,BufWritePost *.js JSUpdate
```

* `g:JSLHint_highlight_error`

Highlight error line or not, default is `1`.

##Next
* open quick-fix window automatically



# Keybindings

- "Keymaps" - Data structures that record key bindings

- Reserved key sequences are those consisting of `C-c` followed by a
  letter, and function keys `F5` through to `F9` without modifiers.

## Keymaps

- "Key sequence" ("key" for short) is a sequence of "input events"that
  have a meanin as a unit.

- "Global keymap" - most important keymap that's always in effect. 
  Defines keys for Fundamental mode.
  
- Each major or minor mode can have its own keymap that overrides the
  global definitions of some keys.
  
- `C-h b` - View current key bindings

## Prefix Keymaps

- The definition of a prefix key is usually the keymap to use for 
  looking up the following event. I.e. The binding of `C-x` is the
  symbol `Control-X-prefix`, whose function definition is the 
  keymap for `C-x` commands.

- The definitions of `C-c`, `C-x`, `C-h`, and `<ESC>` as prefix keys
  appear in the global map, so these prefix keys are always available.

Some prefix keys are stored in variables with names:

| Variable          | Description                                                                    |
|-------------------|--------------------------------------------------------------------------------|
| ctl-x-map         | Variable name for the map used for characters that follow `C-x`.               |
| hep-map           | Variable name for the map used for characters that follow `C-h`.               |
| esc-map           | For characters that follow `\<ESC\>`. All Meta characters defined in this map. |
| ctl-x-4-map       | For characters that follow `C-x 4`.                                            |
| mode-specific-map | For characters that follow `C-c`.                                              |

## Local Maps

- Major modes customize Emacs by providing their own key bindings in
  "local keymaps". I.e. C mode overrides TAB to make it indent the
  current line.
  
- Minor modes can also have local keymaps, overriding the major mode
  and global keymaps.
  
- Generally, Emacs checks the minor mode keymaps for minor modes that
  are enabled, then it checks the major mode's keymap, and then it
  checks the global keymap.

## Minibuffer Keymaps

The minibuffer has its own set of local keymaps; they contain various
completion and exit commands.

| Local Keymap                            | Desription                                                      |
|-----------------------------------------|-----------------------------------------------------------------|
| minibuffer-local-map                    | Used for ordinary input (no completion).                        |
| minibuffer-local-ns-map                 | Similar, except that `\<SPC\>` exits just like `\<RET\>`.       |
| minibuffer-local-completion-map         | For permissive completion.                                      |
| minibuffer-local-must-watch-map         | For strict completion and for cautious completion.              |
| minibuffer-local-filename-map           | and ..                                                          |
| minibuffer-local-filename-must-match-up | Specifically for file name completion. Do not bind to `\<SPC\>` |


## Changing Key Bindings Interactively

How to make key rebindings for the present Emacs session.

| Command                                   | Descriptio                                               |
|-------------------------------------------|----------------------------------------------------------|
| M-x global-set-key \<RET\> CMD \<RET\>    | Define KEY globally to run CMD.                          |
| M-x local-set-key \<RET\> KEY CMD \<RET\> | Define KEY locally (in major mode in effect) to run CMD. |
| M-x global-unset-key \<RET\> KEY          | Make KEY undefined in the global map.                    |
| M-x-local-unset-key \<RET\> KEY           | Make KEY undefined locally (in major mode in effect).    |

- Example binds `C-z` to the `shell` command, replacing the normal
  global definition of `C-z` (confirm message follows):
  
  `M-x global-set-key <RET> C-z shell <RET>`

- You can redefine function keys and mouse events in the same way.
  Type function key or click mouse.
  
- You can rebind a key that contains more than one event. Emacs keeps
  reading the key to rebind until it is a complete key (not a prefix
  key). For example, redefine `C-x 4 $` to run fictitious command:
  
  `M-x global-set-key <RET> C-x 4 $ spell-other-window <RET>`

- Can use `M-x local-unset-key` to expose the key binding in the major
  mode above.


## Rebinding Keys In Your Init File

- Simplest way to write a key binding is to use the `kbd` function. For examples:

```
(global-set-key (kbd "C-z") 'shell)
(global-set-key (kbd "C-M-q") 'query-replace)
(global-set-key (kbd "<f5>") 'flyspell-mode)
(global-set-key (kbd "C-<f5>") 'display-line-numbers-mode)
(global-set-key (kbd "C-<right>") 'forward-sentence)
(global-set-key (kbd "<mouse-2>") 'mouse-save-then-kill)
```

- Instead of using `kbd`, you can use a Lisp string or vector to specify the
  key sequence. Only works for ASCII characters and Meta-modified ASCII characters.
  Example: bind `C-x M-l` to `make-symbolic-link`:
  
  `(global-set-key "\C-x\M-l" 'make-symbolic-link)`
  
- To bind `<TAB> <RET> <ESC> <DEL>`, the string should contain the Emacs
  Lisp escape sequence `\t \r \e \d` respectively. Example: Bind
  `C-x <TAB>` to `indent-rigidly`:
  
  `(global-set-key "\C-x\t" 'indent-rigidly)`

- When key sequence includes function keys, mouse event buttons, non-ASCII
  characters, can use a vector to specifiy key sequence. Each element in vector
  stands for an input event; elements are separated by space; surrounded by square
  brackets. Function keys represented as symbols.
  
  If a vector element is a character, write it as a Lisp character constant: 
  `?` followed by the character as it would appear in the string. Examples:
  
```
(global-set-key [?\C-=] 'make-symbolic-link)
(global-set-key [?\M-\C-=] 'make-symbolic-link)
(global-set-key [?\H-a] 'make-symbolic-link)
(global-set-key [f7] 'make-symbolic-link)
(global-set-key [C-mouse-1] 'make-symbolic-link)
(global-set-key [?\C-z ?\M-l] 'make-symbolic-link)`
```

 - Major and minor modes construct their keymaps when the mode is loaded for
   the first time in a session. The function `define-key` can make changes, 
   and unset keys (when passed `nil` as binding) in a specific keymap.
   
- A mode's keymaps are not constructed until it has been loaded. You must 
  delay running code which modifies them by putting it on a "mode hook". 
  Example, Texinfo mode runs the hook `texinfo-mode-hook`. How to use the
  hook to add local bindings for `C-c n` and `C-c p` and remove `C-c C-x x`:
 
```
(add-hook 'texinfo-mode-hook
           (lambda ()
             (define-key texinfo-mode-map "\C-cp"
                         'backward-paragraph)
             (define-key texinfo-mode-map "\C-cn"
                         'forward-paragraph)
             (define-key texinfo-mode-map "\C-c\C-xx" nil)))`
```

**Up to: 49.3.7 Modifier Keys**

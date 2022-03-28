# Fundamental Editing (2)

## Misc

| Command                    | Description                                       |
|----------------------------|---------------------------------------------------|
| M-x pwd                    | Print working directory.                          |
| M-x cd                     | Change default directory.                         |
| M-x b \*scratch\* <RET>    | Re-create scratch buffer.                         |
| C-x =                      | Echo area displays info about character at point. |
| message-log-max            | Max line length of *Messages* buffer.             |
| buffer-file-name           | Variable holding current buffer filename.         |
| C-h k \<Click GUI Button\> | Open documentation for command linked to button.  |
| F10                        | (menu-bar-open) Open first menu bar item.         |
| describe-variable          | Display full documentation for a variable.        |
| M-x speedbar               | Open explorer type interface.                     |


## Keys

By default, the prefix keys in Emacs are `C-c`, `C-h`, `C-x`, `C-x
<RET>`, `C-x @`, `C-x a`, `C-x n`, `C-x r`, `C-x t`, `C-x v`, `C-x 4`,
`C-x 5`, `C-x 6`, <ESC>, `M-g`, and `M-o`.

`F1` and `F2` are aliases for `C-h` and `C-x 6`.


## Keys and Commands

The bindings between keys and commands are recorded in tables called "keymaps".


## Entering Emacs

| Command                | Description                                            |
|------------------------|--------------------------------------------------------|
| inhibit-startup-screen | When non-nil, startup screen not displayed.            |
| initial-buffer-choice  | Force Emacs to display a file or directory at startup. |


## Exiting Emacs

| Command              | Description                                                         |
|----------------------|---------------------------------------------------------------------|
| C-x C-c              | (save-buffers-kill-terminal) Exit Emacs and prompt to save buffers. |
| C-z                  | (suspend-frame) Suspend in terminal or iconify Emacs GUI.           |
| confirm-kill-process | When nil, C-x C-c doesn't prompt to save files (t by default).      |
| M-x kill-emacs       | Kill Emacs without save prompt.                                     |


## Basic Insert Commands

Auto Fill Mode: Minor mode that splits lines automatically when they get too long.
Overwrite Mode: Inserted characters overwrite existing ones.

| Command     | Description                                                               |
|-------------|---------------------------------------------------------------------------|
| C-j         | Insert new line without indentation (if Electric Indent mode is enabled). |
| C-q         | Followed by any non-graphic character to insert that character.           |
| C-x 8 <RET> | (insert-char) Prompts for Unicode name or code-pint of character.         |


## Changing the Location of Point

| Command                | Description                                                                  |
|------------------------|------------------------------------------------------------------------------|
| line-move-visual       | Set to nil to force point to move according to logical (continuation) lines. |
| track-eol              | Related variable for end of line behavior.                                   |
| next-line-add-newlines | Set to non-nil to have C-n create a new line at the end of the buffer.       |


|             |                                                         |
|-------------|---------------------------------------------------------|
| M-r         | Moves cursor to center, top, bottom of window in cycle. |
| C-u 10 M-r  | Move cursor 10 lines from top of window.                |
| C-u -10 M-r | Move cursor 10 lines from bottom of window.             |
| M-g c       | Move point to entered buffer position (char position).  |
| M-g M-g     | (goto-line) Move point to beginning of entered line.    |
| M-g g       | (goto-line)                                             |
| M-g \<TAB\> | Move point to column N in line.                         |


## Deleting Text

| Command    | Description                        |
|------------|------------------------------------|
| C-d, \<DEL\> | Delete character in frot of point. |


## Blank Lines

| Command | Description                                                              |
| C-o     | (open-line) Insert a blank line after the cursor.                        |
| C-x C-o | (delete-blank-lines) Delete all but one of many consecutive blank lines. |


## Continuation Lines

A long logical line is called a "continued line". Most commands that
act on lines act on logical lines, not screen lines.

Line Truncation: Can truncate long lines; each line occupies one
screen line Auto Fill mode: Use Filling for Emacs to enter a new line
automatically Visual Line mode: Enables word wrapping; useful for a
file with many long lines Wraps at space or tabs.


## Cursor Position Information

| Command                  | Description                                                                |
|--------------------------|----------------------------------------------------------------------------|
| M-x what-line            | Display line number of point in echo area.                                 |
| M-x line-number-mode     | Toggle line number display in mode line.                                   |
| M-x column-number-mode   | Toggle display of current column number.                                   |
| M-=                      | (count-words-region) Display number of lines, words, characters in region. |
| M-x count-words          | Display number of lines, words, characters in buffer.                      |
| C-x =                    | Display character code, char position and column of character after point. |
| M-x hl-line-mode         | Enable or disable highlighting of current line.                            |
| M-x size-indication-mode | Toggle display of the size of the buffer on mode line.                     |


## Numeric Arguments

Hold down META key and type a number before a command. For example:

| Command   | Description            |
|-----------|------------------------|
| M-5 C-n   | Move down five lines.  |
| M-5 0 C-n | Move down fifty lines. |
| M-5 C-u 0 | Insert 5 copies of 0.  |

|             |                                      |
|-------------|--------------------------------------|
| C-u         | Has special meaning of "four times". |
| C-u C-u     | Multiples by 16.                     |
| C-u C-u C-f | Move forward 16 characters.          |
| C-u C-k     | Kill 4 lines.                        |
| C-u C-u C-n | Move down large portion of screen.   |
| C-u C-n     | Move down 4 lines.                   |
| C-u 64 C-u  | Insert 64 ones.                      |


## Repeating a Command

`C-x z` provides another way to repeat an Emacs command many times. It
repeats the previous Emacs command, whatever that was. The same
arguments are used as before. Continue to press `z` to repeat the
command.

| Command    | Description                             |
|------------|-----------------------------------------|
| C-u 20 C-d | Delete 20 characters.                   |
| C-x z z z  | Repeat 3 times, deleting 60 characters. |


## The Minibuffer

**Minibuffer Electrical Default Mode:**
A global minor mode; Emacs hides the default argument as soon as you
modify the contents of the minibuffer.

Enable this minor mode: `(minibuffer-electric-default-mode)`

Change to non-nil value to display default arguement as (DEFAULT-ARG)
instead of (default DEFAULT-ARG) to save some screen space:
`(setq-default minibuffer-eldef-shorten-default 1)`

### Minibuffer for File Names

| Command                  | Description                                                      |
|--------------------------|------------------------------------------------------------------|
| M-<DEL>                  | Kill directory names backwards (or type ../)                     |
| C-a C-k                  | Kill complete directory.                                         |
| //                       | Double slash causes Emacs to ignore everything before 2nd slash. |
| ///                      | For remote files. `//` only ignores file name part.              |
| ~/                       | Home directory. Any path behind it is ignored.                   |
| insert-default-directory | Set to nil to start minibuffer as empty.                         |

### Editing in the Minibuffer

`<TAB>`, `<SPC>`, `?` are often bound to completion commands.

| Command                | Description                                                          |
|------------------------|----------------------------------------------------------------------|
| C-a                    | move-to-beginning-of-line                                            |
| resize-mini-window     | `'grow-only'` by default. `t` also shrinks it. `nil` also available. |
| max-mini-window-height | Minibuffer window max height. Default 0.25. Integer is max lines.    |
| C-M-v                  | Scroll help text in other window.                                    |
| C-q C-j                | Insert new line in mini buffer.                                      |

### Completion

| Command | Description                                                                           |
|---------|---------------------------------------------------------------------------------------|
| ?       | See a list of completion alternatives.                                                |
| M-v     | Selects window showing completion list.                                               |
| q       | Quits the completion window.                                                          |
| z       | (kill-current-buffer) While in completion list buffer, kill it and delete its window. |

|                                       |                                                     |
|---------------------------------------|-----------------------------------------------------|
| read-file-name-completion-ignore-case | Ignore case differences or not for file names.      |
| read-buffer-completion-ignore-case    | Ignore case differences or not for buffer names.    |
| completion-auto-help                  | `nil` won't display completion list buffer, use `?` |
| completion-cycle-threshold            | Customize cycling through alternatives.             |

### Minibuffer History

All arguments entered into the minibuffer are saved in a "minibuffer history list".

| Command                    | Description                                                                  |
|----------------------------|------------------------------------------------------------------------------|
| M-p                        | (previous-history-element) Move to previous item in history.                 |
| M-n                        | (next-history-element) Move to next item in history.                         |
| M-r                        | (previous-matching-history-element) Move to earlier item that matches regex. |
| M-s                        | (next-matching-history-element) Move to later item that matches regex.       |
| history-length             | Max length of minibuffer history list. `t` means no max length (def 100)     |
| history-delete-duplication | Whether to delete duplicates in history.                                     |

### Repeating Minibuffer Command

| Command                  | Description                                                                |
|--------------------------|----------------------------------------------------------------------------|
| C-x <ESC> <ESC>          | (repeat-complex-command) Re-execute a recent minibuffer command from list. |
| M-x list-command-history | Display the entire command history.                                        |


## Running Commands by Name

| Command                             | Description                                                   |
|-------------------------------------|---------------------------------------------------------------|
| suggest-key-binding                 | Number. Seconds to display alternative in echo. `nil` or `t`. |
| extended-command-suggestion-shorter | Suggests shorter command in echo area.                        |
| execute-extended-command            | Called when M-x pressed.                                      |

## Help

| Command              | Description                                                        |
|----------------------|--------------------------------------------------------------------|
| C-h C-h              | (help-for-help) View list of help commands. SPC and DEL to scroll. |
| C-h a TOPICS \<RET\> | Searches for commands whose names match TOPICS.                    |

|                                     |                                                     |
|-------------------------------------|-----------------------------------------------------|
| C-h i d m emacs <RET> i TOPIC <RET> | Searches for TOPIC in indices of Emacs info manual. |
| C-h i d m emacs <RET> s TOPIC <RET> | Similar, but searches text of the manual.           |

|                     |                                                                   |
|---------------------|-------------------------------------------------------------------|
| C-h C-f             | Displays Emacs FAQ                                                |
| C-h p               | Displays available Emacs packages based on keywords.              |
| C-h K KEY           | Displays section in Emacs manual that describes the command.      |
| C-h w COMMAND <RET> | (where-is) Lists the keys that are bound to COMMAND in echo area. |

|                              |                                                                        |
|------------------------------|------------------------------------------------------------------------|
| C-h F                        | Find function documentation in the manual.                             |
| C-c C-c                      | (help-follow-symbol) Show all documentation about the symbol at point. |
| C-h 4 i                      | (info-other-window) Display info buffer in other window.               |
| C-h e                        | Review recent echo messages.                                           |
| help-at-pt-display-when-idle | Set `t` to display help text in echo area automatically.               |


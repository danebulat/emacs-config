# Important Commands

## Killing and Moving Text

### Deleting and Killing

|             |                                                                                  |
|-------------|----------------------------------------------------------------------------------|
| M-\\        | (delete-horizontal-space) Delete spaces and tabs around point.                   |
| M-\<SPACE\> | (just-one-space) Delete spaces and tabs around point, leaving one space.         |
| C-x C-o     | (delete-blank-lines) Delete blank lines around the current line.                 |
| M-^         | (delete-indentation) Join two lines by deleting intervening newline/indentation. |

|                         |                                                              |
|-------------------------|--------------------------------------------------------------|
| delete-duplicate-lines  | Make selection and invoke to remove duplicate lines.         |
| C-S-backspace           | (kill-whole-line) Kill an entire line at one.                |
| C-u 0 C-k               | Kill text before point. `C-x <DEL>` same.                    |
| C-w                     | (kill-region) Kill the region.                               |
| M-w                     | (kill-ring-save) Copy region into kill ring.                 |
| M-\<DEL\>               | (backward-kill-word) Kill one word backwards.                |
| C-x \<DEL\>             | (backward-kill-sentence) Kill back to beginning of sentence. |
| M-k                     | (kill-sentence) Kill to end of sentence..                    |
| C-M-k                   | (kill-sexp) Kill following balanced expression.              |
| M-z CHAR                | (zap-to-char) Kill through the next occurrence of CHAR.      |
| M-x zap-up-to-char CHAR | Kill up to, but not including the next occurrence of CHAR.   |

### Yanking

| Command       | Description                                                                         |
|---------------|-------------------------------------------------------------------------------------|
| C-M-w         | (append-next-kill) Cause the following kill command to append to the previous kill. |
| C-u 4 C-y     | Insert 4th most recent kill.                                                        |
| kill-ring-max | Max number of entries in kill ring. Default 60.                                     |

### Cut and Paste (GUIs)

| Command                           | Description                                                       |
|-----------------------------------|-------------------------------------------------------------------|
| yank-pop-change-selection         | `M-y` saves new yank to clipboard.                                |
| select-enable-clipboard           | Set to `nil` to prevent kill/yank accessing the clipboard.        |
| x-select-enable-clipboard-manager | Emacs transfers data to clipboard manager from clipboard exiting. |

**Primary Selection:** Drag mouse over text, paste with MMB (mouse 2)

`select-active-region`: `nil` for Emacs to avoid saving active regions
to primary selection. mouse-2 (`mouse-yank-primary`) to yank copied
text.





# Texinfo

You can use the `info` program within Emacs via the `info` shell command.

## Basics

| Command | Description                                               |
|---------|-----------------------------------------------------------|
| d       | (info-directory) Gets you to the Directory node.          |
| t       | (info-top-node) Move to top node of the manual.           |
| ?       | See a summary of all available commands in `info` reader. |
|         | `H` in standalone info reader.                            |
| SPC     | Move forward through text and see another screenful.      |
| \<DEL\> | Move to previous screenful. `SPC-Shift` in GUI Emacs.     |

|   |                                                                 |
|---|-----------------------------------------------------------------|
| n | Go to next node (at same level)                                 |
| p | Go to previous node (at same level)                             |
| [ | Go forward one node (through all levels)                        |
| ] | Go back one node (through all levels)                           |
| r | Move forward step-by-step in history to nodes you have visited. |
| L | Opens window with history of visited nodes.                     |
| i | Searches index file for a given topic (node) and goes to it.    |

|                           |                                                                         |
|---------------------------|-------------------------------------------------------------------------|
| \<PageUp\>                | Scroll up screenful (doesn't leave node)                                |
| \<PageDown\>              | Scroll down screenful (doesn't leave node)                              |
| b                         | Go to beginning of node.                                                |
| e                         | Go to end of node.                                                      |
| m                         | Go to a subnode; can type abbreviation.                                 |
| \<TAB\>                   | Move to the next subtopic line or cross reference.                      |
| M-\<TAB\>                 | Move to previous subtopic line or cross reference.`S-<TAB>` also works. |
| u                         | Go to parent node.                                                      |
| f                         | Enter name of cross reference to go to that node.                       |
| f?                        | Show all cross references in file.                                      |
| q                         | (quit-window) Get out of info.                                          |
| M-x visible-mode          | Toggle to show invisible text (minor mode)                              |
| info-hide-note-references | `nil` to always show invisible text.                                    |


## Advanced

| Command                 | Description                                                               |
|-------------------------|---------------------------------------------------------------------------|
| C-q ?                   | Inserts special character as normal character, such as `?`.               |
| s                       | Search a whole info file for a string.                                    |
| C-s or C-r              | Can search through multiple nodes.                                        |
|                         | Disable this incremental search by setting `info-isearch-search` to `nil` |
| i                       | Looks up subject in the indicies. Press `,` to repeat.                    |
|                         | `iC-<RET>` Read description of C-l key                                    |
|                         | `icomplete<RET>` Search index entries with `complete`.                    |
| I                       | (info-virtual-index) Behaves like `i`, but lists results.                 |
| M-x info-apropos        | Looks up string in all info documents on your system.                     |
| g                       | To to node with specified name.                                           |
| `g(dir)Top<RET>`        | Include filename in parenthesis.                                          |
| `g(emacs)Top<RET>`      |                                                                           |
| `g*<RET>`               | Search the whole current file.                                            |
| `g(FILENAME)*<RET>`     | Search all of another file.                                               |
| `gFurther Reading`      | Check node names by going to top (`t`).                                   |
| 1..9                    | Go to menu items by index; `0` goes to last item.                         |
| M-n                     | Create a new independent info buffer (clone current one)                  |
| C-u g                   | Go to node in new info buffer in another window.                          |
| C-u 2 C-h i             | Go to info buffer and open in new window.                                 |
| M-x info-display-manual | Show an info manual by name.                                              |


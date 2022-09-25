# Haskell Customization

## Links

- https://wiki.haskell.org/Emacs
- https://haskell.github.io/haskell-mode/manual/latest/index.html#Top
- https://haskell-language-server.readthedocs.io/en/latest/configuration.html?highlight=emacs#emacs
- https://emacs-lsp.github.io/lsp-mode/page/installation/

## Steps for Installing HLS

Reference links:

- https://github.com/Avi-D-coder/implicit-hie
- https://github.com/haskell/hie-bios
- https://hackage.haskell.org/package/ghcide
- https://www.reddit.com/r/haskell/comments/hcu5sf/mystified_by_hieyaml/

The following command sets the defualt version of GHC that `ghc` will use. 
Make sure the PATH finds `ghc` in the correct location, such as 
`~/.ghcup/bin`:

```
ghcup set ghc
# GHC 8.10.7 successfully set as default version.
```

If the PATH is searching for HLS components in `~/.ghcup/bin`, make sure that
Cabal is also installed locally and install the required components to 
`~/.cabal/bin` including:

```
cabal install ghcide
```

Emacs uses separate PATH variables to locate binaries and packages within Emacs.
Update the PATH variables in `init.el` so they know where `~/.ghcup/bin` is
located:`

```
;; https://www.emacswiki.org/emacs/ExecPath
;; Add .ghcup to Emacs exec-path
(setq exec-path (append exec-path '("/home/dane/.ghcup/bin")))

;; Add .ghcup to environment PATH
(setenv "PATH" (concat (getenv "PATH") ":/home/dane/.ghcup/bin"))
```

Make sure the following code is added to `init.el` to start Haskell LSP when 
Haskell Mode is enabled. The `lsp-haskell-process-path-hie` and
`lsp-haskell-process-args-hie` variables must also be set:

```
(require 'lsp)
(require 'lsp-haskell)

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(setq lsp-haskell-process-path-hie "ghcide")
(setq lsp-haskell-process-args-hie '())
```

Install `implicit-hie`:

```
cabal install implicit-hie
```

Generate `hie.yaml` in the Haskell project root directory:

```
gen-hie > hie.yaml
```

Edit the `hie.yaml` file such that HLS is sent the project's components to 
perform code completion and analysis:

```
cradle:
  cabal:

    - path: "./app/Main.hs"
      component: "testproject:exe:testproject"

#    - path: "./app/Main.hs"
#      component: "lib:haskell-language-server"
```

### Troubleshooting

There may be a global installation of the Haskell toolchain located at
`/usr/bin`, in addition to a local installation located at `~/.ghcup/bin`.
Make sure the PATH is referencing binaries such as `ghc`, `ghcide`, 
`haskell-language-server-wrapper` and `ghc-pkg` from the same bin location
so all the versions match up.

### Misc

Add to `init.el` for hasktags to generate tags when saving a Haskell file:

```
;; Generate tags when saving using external program Hasktags
(setq haskell-tags-on-save t)

;; Revert tags tables automatically (reread TAGS table without querying)
(setq tags-revert-without-query t)
```

Enable company mode globally in `init.el`:

```
(add-hook 'after-init-hook 'global-company-mode)
```

Setting some `lsp-ui` variables (optional):

```
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-position "at-point")
(setq lsp-ui-doc-delay 0.1)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse t)
```

## Stylish Haskell

Commands for aligning imports:

| Command                     | Description                           |
|-----------------------------|---------------------------------------|
| haskell-mode-format-imports | (C-c C-,) Format (sort, align) import |
| haskell-sort-imports        | Sort imports                          |
| haskell-align-imports       | Align imports                         |

- haskell-mode can use the program `stylish-haskell` to format imports.
  Install with stack or cabal via `cabal install stylish-haskell`

- Customise via `M-x customize-variable RET haskell-stylish-on-save`

## Profiling and Debugging Support

- **TODO:** C-c C-s (haskell-mode-toggle-scc-at-point) to add or remove an
  SCC annotation at point.

## Syntax Highlighting

- Quasi quotes for HTML, XML, shell scripts, Hamlet templates, and SQL are
  supported out of the box. Customise `haskell-font-lock-quasi-quote-modes` 
  to make sure your quoters are supported.

Customisation variables for faces:

| Command                       | Description                                          |
|-------------------------------|------------------------------------------------------|
| haskell-keyword-face          | For keywords                                         |
| haskell-type-face             | For type names and type class names                  |
| haskell-constructor-face      | For constructors                                     |
| haskell-definition-face       | Function and operator name at the definition place   |
| haskell-operator-face         | Operators                                            |
| haskell-pragma-face           | GHC pragmas                                          |
| haskell-literate-comment-face | Literate comments                                    |
| haskell-quasi-quote-face      | Quasi quotes unless using mode specific highlighting |
| haskell-c2hs-hook-pair-face   | c2hs hooks                                           |
| haskell-c2hs-hook-name-face   | crhs hook names                                      |

## Completion Support

Company popup commands and key bindings:

| Command              | Description                                          |
|----------------------|------------------------------------------------------|
| M-x company-complete | Invoke popup                                         |
| M-n and M-p          | Select from company popup                            |
| \<Return\>           | Complete all                                         |
| \<TAB\>              | Complete common part                                 |
| C-s, C-r, C-o        | Search through completions                           |
| M-(digit)            | Complete with one of first 10 candidates             |
| F1                   | Display candidate documentation                      |
| C-w                  | See candidate source (not all backends support this) |


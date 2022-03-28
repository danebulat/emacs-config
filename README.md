# Emacs Configuration

## Before Use

The configuration assumes you have installed the Haskell tool chain and Haskell Language Server binaries within your home directory's `.ghcup` directory. Feel free to consult the Haskell markdown documents within `doc/custom` for more information on how to configure Haskell IDE features within Emacs. 

After confirming this, set the relevant paths to point to your `.ghcup` location in `init.el`:

```lisp
;; Add .ghcup to Emacs exec-path
(setq exec-path (append exec-path '("/path/to/.ghcup/bin")))

;; Add .ghcup to environment PATH
(setenv "PATH" (concat (getenv "PATH") ":/path/to/.ghcup/bin"))
```

Also set a preferred email address on the following line for built-in Emacs features and packages:

```lisp
;; Specify email address
(setq user-email-address "your@email.com")
```

## Todo

- IDE features for major  languages
  - C/C++, JSON, JavaScript, etc.

- Flycheck

## Integrated

- **Themes**
  - iceberg-theme
  - color-theme-sanityinc-solarized
  - color-theme-sanityinc-tomorrow

- **Completion**
  - company
  - ivy

- **Haskell**
  - haskell-mode
  - lsp-mode
  - lsp-ui
  - lsp-haskell
  - ghcide
  - gen-hie 

- **Configuration**
  - leaf
  - use-package

- **Terminal**
  - vterm

- **File Explorer**
  - neotree

- **Project Manager**
  - project.el

- **Workspace Manager**
  - perspective.el

## Notes

Haskell Mode is a Haskell development Environment for GNU Emacs version 24.3 or later.
It provides syntax-based indentation, font locking, editing cabal files, and supports
running an inferior Haskell interpreter (e.g. GHCi).

## Package Management

- [Package Management](https://www.reddit.com/r/emacs/comments/1lmse1/how_should_i_manage_packages_with_elpa/)

| Command        | Description                  |
|----------------|------------------------------|
| list-packages  | List all packages.           |
| package-delete | Delete an installed package. |


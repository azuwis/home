;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-show-snippets-in-popup t
                      auto-completion-tab-key-behavior 'complete)
     better-defaults
     emacs-lisp
     git
     markdown
     org
     (shell :variables
            shell-default-shell 'eshell)
     spell-checking
     syntax-checking
     version-control
     ;; Additional layers
     ansible
     clojure
     github
     html
     javascript
     lua
     mu4e
     python
     ranger
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(howdoi)
   ;; A list of packages that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when downloading packages.
   ;; Possible values are `used', `used-but-keep-unused' and `all'. `used' will
   ;; download only explicitly used packages and remove any unused packages as
   ;; well as their dependencies. `used-but-keep-unused' will download only the
   ;; used packages but won't delete them if they become unused. `all' will
   ;; download all the packages regardless if they are used or not and packages
   ;; won't be deleted by Spacemacs. (default is `used')
   dotspacemacs-download-packages 'used))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(todos bookmarks recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Noto Sans Mono CJK SC"
                               :size 22
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 2
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.3
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols (if (display-graphic-p) t nil)
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; manually set tramp-ssh-controlmaster-options to avoid hanging
  ;; https://github.com/emacs-helm/helm/issues/1000#issuecomment-119487649
  (setq tramp-ssh-controlmaster-options
        "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  ;; Magit
  ;; (setq-default git-magit-status-fullscreen t)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ;; Common
  ;; clipboard manager cause slow quitting
  (setq x-select-enable-clipboard-manager nil)
  ;; default major mode
  ;; (setq-default major-mode 'text-mode)
  ;; set title to 'buffer @ file'
  (setq frame-title-format "%b @ %f")
  ;; always add new line at the end of file
  (setq-default require-final-newline t)
  ;; faster tramp
  (setq tramp-default-method "ssh")

  ;; Auto complete
  (global-company-mode)

  ;; Smooth scrolling
  (setq smooth-scroll-margin 3)

  ;; Display
  (setq powerline-default-separator (if (display-graphic-p) 'zigzag nil))
  (add-to-list 'default-frame-alist '(width . 100))
  (add-to-list 'default-frame-alist '(height . 43))
  ;; font
  ;; (setq face-font-rescale-alist '(("WenQuanYi Micro Hei" . 1.2)))
  ;; (when window-system
  ;;   ;; "CJK Unified Ideographs" (han) U+4E00 - U+9FFF
  ;;   (set-fontset-font "fontset-default"
  ;;                     (cons (decode-char 'ucs #x4e00)
  ;;                           (decode-char 'ucs #x9fff))
  ;;                     "-*-WenQuanYi Micro Hei-*-*-*-*-24-*-*-*-*-*-*-*"))

  ;; Org
  (setq org-directory "~/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-capture-templates
        '(
          ("b"
           "Bookmark"
           entry
           (file+headline (concat org-directory "/notes.org") "Bookmarks")
           "* %c\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%i"
           :empty-lines 1)
          ))
  (use-package org-protocol
    :defer 3)

  ;; Ansible
  (setq ansible/ansible-filename-re
        "\\(site\.yml\\|roles/.+\.yml\\|playbooks/.+\.yml\\|group_vars/.+\\|host_vars/.+\\)")

  ;; AsciiDoc
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))

  ;; Magit
  (global-git-commit-mode t)
  (setq magit-repository-directories '("~/src/"))
  (setq magit-log-auto-more t)

  ;; Howdoi
  (use-package howdoi
    :defer t
    :commands howdoi-query
    :init
    (spacemacs/set-leader-keys "a h" 'howdoi-query))

  ;; FontAwesome
  ;; (use-package fontawesome
  ;;   :defer t
  ;;   :commands helm-fontawesome
  ;;   :init
  ;;   (spacemacs/set-leader-keys "a f" 'helm-fontawesome))

  ;; Ranger
  (setq ranger-cleanup-eagerly t)

  ;; Msmtp
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "msmtp"
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil t)

  ;; Mu4e
  (with-eval-after-load 'mu4e
    ;; Accounts
    (setq mu4e-account-alist
          '(("gmail"
             (user-full-name "Zhong Jianxin")
             (user-mail-address "azuwis@gmail.com")
             (mu4e-sent-folder "/gmail/sent")
             (mu4e-drafts-folder "/gmail/drafts"))
            ))
    (let ((mu4erc (concat user-home-directory ".mu4e.local")))
      (if (file-exists-p mu4erc) (load mu4erc)))
    (mu4e/mail-account-reset)
    ;; My Email addresses
    ;; https://github.com/jonEbird/dotfiles/blob/master/.emacs.d/my_configs/email_config.el
    (setq mu4e-user-mail-address-list (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
                                              mu4e-account-alist))

    (setenv "XAPIAN_CJK_NGRAM" "1")
    (require 'mu4e-contrib)
    (setq mu4e-get-mail-command "mbsync -a"
          mu4e-update-interval 300
          mu4e-sent-messages-behavior 'delete
          mu4e-view-show-images t
          mu4e-view-show-addresses t
          mu4e-attachment-dir  "~/Downloads"
          ;; Show related mails in search
          mu4e-headers-include-related t
          mu4e-html2text-command 'mu4e-shr2text
          ;; mu4e-html2text-command "w3m -dump -T text/html"
          ;; mu4e-headers-fields '((:human-date . 12)
          ;;                       (:flags . 6)
          ;;                       (:mailing-list . 10)
          ;;                       (:from-or-to . 22)
          ;;                       (:subject))
          mu4e-compose-dont-reply-to-self t
          mu4e-compose-signature-auto-include nil
          message-kill-buffer-on-exit t)
    ;; (when (fboundp 'imagemagick-register-types)
    ;;   (imagemagick-register-types))

    ;; Desktop notification
    ;; http://www.tokle.us/tools/2014/06/28/taking-email-offline-ii/
    (defun my-mu4e-notify-new-mail ()
      (call-process-shell-command (concat "subject=\"$(mu find flag:unread --fields s --after="
                                          (number-to-string (- (truncate (float-time)) mu4e-update-interval))
                                          " 2>/dev/null)\"; test -n \"$subject\" && notify-send \"New Mail\" \"$subject\" &")
                                  nil 0))
    (add-hook 'mu4e-index-updated-hook 'my-mu4e-notify-new-mail)

    ;; Toggle plain text and html
    ;; https://groups.google.com/forum/#!msg/mu-discuss/u3Fy86-N-rg/zcdvIlnV0L8J
    (defun my-mu4e-view-toggle-html ()
      "Toggle between html and non-html views of a message. The current
 message is refreshed with the new setting, but the setting applies to all
 messages."
      (interactive)
      (message (if (setq mu4e-view-prefer-html (not mu4e-view-prefer-html))
                   "html view"
                 "text view"))
      (mu4e-view-refresh))
    (add-to-list 'mu4e-view-actions
                 '("toggle html" . (lambda (MSG) (my-mu4e-view-toggle-html))) t)

    ;; Org-mu4e
    ;; http://www.brool.com/index.php/using-mu4e
    ;; (require 'org-mu4e)
    (setq org-mu4e-convert-to-html t)
    (defalias 'org-mail 'org-mu4e-compose-org-mode)
    )
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

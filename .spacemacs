;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t)
     markdown
     org
     (shell :variables
            shell-default-shell 'eshell)
     syntax-checking
     version-control
     ;; Additional layers
     ansible
     clojure
     eyebrowse
     python
     )
   ;; List of additional packages that will be installed wihout being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '(jinja2-mode)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Inconsolata"
                               :size 24
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f) is replaced.
   dotspacemacs-use-ido nil
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state t
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols (if (display-graphic-p) t nil)
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   )
  ;; User initialization goes here
  )

(defun dotspacemacs/config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."
  ;; Common
  ;; clipboard manager cause slow quitting
  (setq x-select-enable-clipboard-manager nil)
  ;; default major mode
  ;; (setq-default major-mode 'text-mode)
  ;; set title to 'buffer @ file'
  (setq frame-title-format "%b @ %f")
  ;; always add new line at the end of file
  (setq require-final-newline t)

  ;; Ansible
  (setq ansible/ansible-filename-re
        "\\(site\.yml\\|roles/.+\.yml\\|playbooks/.+\.yml\\|group_vars/.+\\|host_vars/.+\\)")

  ;; AsciiDoc
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))

  ;; Jinja2
  (use-package jinja2-mode
    :defer t
    :mode "\\.j2\\'")

  ;; Display
  (setq powerline-default-separator (if (display-graphic-p) 'zigzag nil))
  (add-to-list 'default-frame-alist '(width . 100))
  (add-to-list 'default-frame-alist '(height . 48))
  ;; (setq git-gutter-fr:side 'left-fringe)

  ;; Font
  ;; (setq face-font-rescale-alist '(("WenQuanYi Micro Hei" . 1.2)))
  ;; (when window-system
  ;;   ;; "CJK Unified Ideographs" (han) U+4E00 - U+9FFF
  ;;   (set-fontset-font "fontset-default"
  ;;                     (cons (decode-char 'ucs #x4e00)
  ;;                           (decode-char 'ucs #x9fff))
  ;;                     "-*-WenQuanYi Micro Hei-*-*-*-*-24-*-*-*-*-*-*-*"))

  ;; Msmtp
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "msmtp"
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil t)

  ;; Mu4e
  (use-package mu4e
    :defer t
    :commands mu4e
    :init
    (evil-leader/set-key "am" 'mu4e)
    :config
    (progn
      (setenv "XAPIAN_CJK_NGRAM" "1")
      (require 'mu4e-contrib)
      (setq mu4e-get-mail-command "mbsync -a"
            mu4e-update-interval 300
            mu4e-sent-messages-behavior 'delete
            mu4e-view-show-images t
            ;; Show related mails in search
            mu4e-headers-include-related t
            mu4e-html2text-command 'mu4e-shr2text
            ;; mu4e-html2text-command "w3m -dump -T text/html"
            mu4e-headers-fields '((:human-date . 12)
                                  (:flags . 6)
                                  (:mailing-list . 10)
                                  (:from-or-to . 22)
                                  (:subject))
            mu4e-compose-dont-reply-to-self t
            mu4e-compose-signature-auto-include nil
            message-kill-buffer-on-exit t)
      ;; (when (fboundp 'imagemagick-register-types)
      ;;   (imagemagick-register-types))
      (add-to-list 'mu4e-view-actions
                   '("browser view" . mu4e-action-view-in-browser) t)

      ;; Multiple accounts
      ;; http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
      (defvar my-mu4e-account-alist
        '(("gmail"
           (user-full-name "Zhong Jianxin")
           (user-mail-address "azuwis@gmail.com")
           (mu4e-sent-folder "/gmail/sent")
           (mu4e-drafts-folder "/gmail/drafts"))
          ))
      ;; https://github.com/jonEbird/dotfiles/blob/master/.emacs.d/my_configs/email_config.el
      (setq mu4e-user-mail-address-list (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
                                          my-mu4e-account-alist))
      (defun my-mu4e-set-account ()
        "Set the account for composing a message."
        (let* ((account
                (if mu4e-compose-parent-message
                    (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                      (string-match "/\\(.*?\\)/" maildir)
                      (match-string 1 maildir))
                  (completing-read (format "Compose with account: (%s) "
                                           (mapconcat #'(lambda (var) (car var))
                                                      my-mu4e-account-alist "/"))
                                   (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                                   nil t nil nil (caar my-mu4e-account-alist))))
               (account-vars (cdr (assoc account my-mu4e-account-alist))))
          (if account-vars
              (mapc #'(lambda (var)
                        (set (car var) (cadr var)))
                    account-vars)
            (error "No email account found"))))
      (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

      ;; Init default account and reset when compose
      (defun my-mu4e-reset-account ()
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              (cdr (car my-mu4e-account-alist))))
      (my-mu4e-reset-account)
      (add-hook 'mu4e-compose-mode-hook 'my-mu4e-reset-account)

      ;; Desktop notification
      ;; http://www.tokle.us/tools/2014/06/28/taking-email-offline-ii/
      (defun my-mu4e-notify-new-mail ()
        (call-process-shell-command (concat "subject=\"$(mu find flag:unread --fields s --after="
                                            (number-to-string (- (truncate (float-time)) mu4e-update-interval))
                                            " 2>/dev/null)\"; test -n \"$subject\" && notify-send \"New Mail\n\" \"$subject\" &")
                                    nil 0))
      (add-hook 'mu4e-index-updated-hook 'my-mu4e-notify-new-mail)

      ;; Toggle plain text and html
      ;; https://groups.google.com/forum/#!msg/mu-discuss/u3Fy86-N-rg/zcdvIlnV0L8J
      (defun my-mu4e-view-toggle-html ()
        "Toggle between html and non-html views of a message. The current
 message is refreshed with the new setting, but the setting applies to all
 messages."
        (interactive)
        (setq mu4e-view-prefer-html (not mu4e-view-prefer-html))
        (mu4e-view-refresh))

      ;; Org-mu4e
      ;; http://www.brool.com/index.php/using-mu4e
      (require 'org-mu4e)
      (setq org-mu4e-convert-to-html t)
      (defalias 'org-mail 'org-mu4e-compose-org-mode)

      ;; Evilify
      (evilify mu4e-main-mode mu4e-main-mode-map
               "g" 'mu4e~headers-jump-to-maildir)
      (evilify mu4e-headers-mode mu4e-headers-mode-map
               "g" 'mu4e~headers-jump-to-maildir
               "J" 'mu4e-headers-view-message
               "K" 'mu4e-headers-view-message)
      (evilify mu4e-view-mode mu4e-view-mode-map
               "g" 'mu4e~headers-jump-to-maildir
               "J" 'mu4e-view-headers-next
               "K" 'mu4e-view-headers-prev)
      )
    )
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

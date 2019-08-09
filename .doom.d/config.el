;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-font (font-spec :family "Monospace" :size 22))
(setq doom-theme 'doom-gruvbox)
(setq projectile-project-search-path '("~/src/"))
(setq which-key-idle-delay 0.3)
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-script-padding 0)

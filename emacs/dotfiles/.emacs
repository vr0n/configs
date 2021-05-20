
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '(("melpa" . "https://melpa.org/packages/")
	     ("melpa-stb" . "https://stable.melpa.org/packages/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/")

(setenv "PATH" (concat (getenv "PATH") ":~/go/bin:/usr/local/go/bin"))

;; go-mode stuff
(require 'go-mode-load)
(setq exec-path (append exec-path '("/usr/local/go/bin")))
(setq exec-path (append exec-path '("~/go/bin")))
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yas-minor-mode)
(require 'company-lsp)
(push 'company-lsp company-backends)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(tool-bar-mode -1)
(menu-bar-mode -1)
(fringe-mode -1)
(scroll-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (spacegray)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "2050674326d536ddd3dcea87e077d27071cfbbe974a4540b1a57b6b672f64c51" "ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" "c560237b7505f67a271def31c706151afd7aa6eba9f69af77ec05bde5408dbcd" default)))
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (yasnippet flymake lsp-ui company lsp-mode go-eldoc vterm dashboard dmenu exwm challenger-deep-theme brutal-theme afternoon-theme ewal-doom-themes doom-themes ample-theme acme-theme ewal-spacemacs-themes spaceline-all-the-icons spacegray-theme soothe-theme)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; try to fix super key cuz i grok dwm
;;(setq
;; x-meta-keysym 'super
;; x-super-keysym 'meta
;; )

;; set alpha background for no-window mode
;;(set-background-color "ARGBBB000000")
;; set alpha background for window mode
(set-frame-parameter (selected-frame) 'alpha '(90 . 70))
(add-to-list 'default-frame-alist '(alpha . (90 . 70)))

;; set line numbers globally
(global-display-line-numbers-mode)   

;; set font
(add-to-list 'default-frame-alist
	     '(font . "FreeMono"))

;; exwm configs
(require 'exwm)
(use-package exwm
	     :ensure t
	     :config
	     (require 'exwm-config)
	     (fringe-mode 3)
	     (server-start)
	     (exwm-config-ido)
	     (setq exwm-workspace-number 1)
	     (exwm-input-set-key (kbd "s-r") #'exwm-reset)
	     (exwm-input-set-key (kbd "s-k") #'exwm-workspace-delete)
	     (exwm-input-set-key (kbd "s-w") #'exwm-workspace-swap)
	     (dotimes (i 10)
	       (exwm-input-set-key (kbd (format "s-%d" i))
				   `(lambda ()
				      (interactive)
				      (exwm-workspace-switch-create ,i)
				      (message "Workspace %d", i))))
             (exwm-input-set-key (kbd "s-&")
				 (lambda (command)
				   (interactive (list (read-shell-command "$ ")))
				   (start-process-shell-command command nil command)))
	     (exwm-enable))

;; dmenu config
(use-package dmenu
  :ensure t
  :bind
  ("s-;" . 'dmenu))

;; dashbaord config
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
			  (projects . 5)))
  (setq dashboard-banner-logo-title "test"))

(setq electric-pair-pairs '(
			    (?\{ . ?\})
			    (?\[ . ?\])
			    (?\( . ?\))
			    (?\" . ?\")
			    (?\< . ?\>)))
(electric-pair-mode t)
(auto-fill-mode t)

;;(global-set-key (kbd "s-.") 'pop-tag-mark)
; file: ~/.emacs.d/init.el - top level, not in your go hook
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'go-guru)

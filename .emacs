;; melpa config
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; use-package boilerplate
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

; use-package-ensure
; (use-package use-package-ensure)
(setq use-package-always-ensure t)

;; the packages themselves
(use-package yaml-mode)
(use-package flycheck)
(use-package dockerfile-mode)
(use-package company)
(use-package js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))
(use-package rjsx-mode)
(use-package markdown-mode)
(use-package helm)
(use-package use-package)
(use-package stylus-mode)
(use-package rainbow-delimiters)
(use-package projectile)
(use-package less-css-mode)
(use-package kill-ring-search)
(use-package nvm)
(use-package key-chord
  :init
  (key-chord-mode 1))
(use-package json-reformat)
(use-package jade-mode)
(use-package highlight)
(use-package flycheck)
(use-package f)
(use-package ensime)
(use-package dsvn)
(use-package coffee-mode)
(use-package browse-kill-ring)
(use-package auto-complete)
(use-package elpy
  :init
  (elpy-enable))
(use-package jedi
  :init
  (add-hook 'python-mode-hook 'jedi:setup))
(use-package magit)
(use-package thrift)
(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))



;; loadpath things
(add-to-list 'load-path "~/.emacs.d/loadpath")
(require 'zoom-frm)
(require 'markerpen)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; osx - command is meta too
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'control)

; so we can use emacsclient
(server-start)

(add-hook 'magit-mode-hook 'magit-load-config-extensions)

(autoload 'kill-ring-search "kill-ring-search"
  "Search the kill ring in the minibuffer."
  (interactive))
(global-set-key "\M-\C-y" 'kill-ring-search)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup nvm.el
;l (nvm-use "v10.15.3")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; ;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; http://stackoverflow.com/questions/8918910/weird-character-zsh-in-emacs-terminal
; (setq system-uses-terminfo nil)

; http://superuser.com/questions/125569/how-to-fix-emacs-popup-dialogs-on-mac-os-x
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


;;;;;;;
;; "i cant believe i actually need these lets disable them and find out"
;; (require 'company)
;; (require 'flycheck)

; company mode also comes from melpa
;; (require 'company)
;; (global-company-mode t)

; (require 'projectile)
; (require 'rainbow-delimiters)

;; package-initialize doesnt do the job for this one
; (require 'dired+)


;; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\t" 0 'trailing-whitespace prepend)))))

; draw tabs visibly
(standard-display-ascii ?\t "-   ")

; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

; these conflict with windmove and are annoying
(require 'org)
(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)
(define-key org-mode-map (kbd "<S-up>") nil)
(define-key org-mode-map (kbd "<S-down>") nil)

;; node.js shell
(setq inferior-js-program-command "node")
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string
                        ".*1G\.\.\..*5G" "... "
                        (replace-regexp-in-string ".*1G.*3G" "> " output))))))

;; mingus mpd client
(autoload 'mingus "mingus" nil t)

; dpaste auto paster
(require 'dpaste)
(global-set-key (kbd "C-c u") 'dpaste-region)

; fullscreener
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(defun revbufs ()
   "Iterate through the list of buffers and revert them, e.g. after a
    new branch has been checked out."
    (interactive)
    (when (yes-or-no-p "Are you sure - any changes in open buffers will be lost! ")
      (let ((frm1 (selected-frame)))
        (make-frame)
        (let ((frm2 (next-frame frm1)))
          (select-frame frm2)
          (make-frame-invisible)
          (dolist (x (buffer-list))
            (let ((test-buffer (buffer-name x)))
              (when (not (string-match "\*" test-buffer))
                (when (not (file-exists-p (buffer-file-name x)))
                  (select-frame frm1)
                  (when (yes-or-no-p (concat "File no longer exists (" (buffer-name x) "). Close buffer? "))
                    (kill-buffer (buffer-name x)))
                  (select-frame frm2))
                (when (file-exists-p (buffer-file-name x))
                  (switch-to-buffer (buffer-name x))
                  (revert-buffer t t t)))))
          (select-frame frm1)
          (delete-frame frm2)))))

; key to switch from frame to frame
(global-set-key (kbd "C-o") 'other-frame)

; no scroll bars.
(set-scroll-bar-mode nil)

(require 'grep-buffers)

; track recent files
(require 'recentf)
(recentf-mode 1)

; dont be throwing away my history
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 1000)

; revert all buffers key
(global-set-key (kbd "C-c v") 'revert-buffer)

; buffer-move
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; ; kill-orphan-buffers
(defun kill-orphan-buffers()
  (interactive)
  (dolist (buffer (buffer-list))
    (if (and (buffer-file-name buffer) (not (file-exists-p (buffer-file-name buffer)))) (kill-buffer buffer))))

; highlight whitespace in some modes
(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq show-trailing-whitespace t))))
      '(text-mode-hook
        emacs-lisp-mode-hook
        python-mode-hook
        js2-mode-hook
        css-mode-hook
        java-mode-hook
        coffee-mode-hook
        ))

; a prefix to put all my junk on
(define-prefix-command 'my-map)

; (r)emove newlines
(defun remove-newlines-in-region ()
  "Removes all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))))

;; helm
(global-set-key (kbd "C-c a") 'helm-mini)

; my prefix
(global-set-key (kbd "C-c m") 'my-map)

(define-key my-map (kbd "b") (lambda () (interactive) (shell-command "gmpc-remote -z")))
(define-key my-map (kbd "n") (lambda () (interactive) (shell-command "gmpc-remote -b")))
(define-key my-map (kbd "p") (lambda () (interactive) (shell-command "gmpc-remote -v")))

(define-key my-map (kbd "h") 'helm-mini)
(define-key my-map (kbd "r") 'remove-newlines-in-region)

(define-key my-map (kbd "i") 'insert-buffer)

; eclim stuff
(define-key my-map (kbd "t") 'company-complete-common)

(define-key my-map (kbd "g") 'projectile-grep)
(define-key my-map (kbd "f") 'projectile-find-file)

; volume control
(defun turn-volume-up ()
  (interactive)
  (mingus-vol-up)
  (mingus-vol-up)
  (mingus-vol-up)
  (mingus-vol-up)
  (mingus-vol-up))

(defun turn-volume-down ()
  (interactive)
  (mingus-vol-down)
  (mingus-vol-down)
  (mingus-vol-down)
  (mingus-vol-down)
  (mingus-vol-down))

(define-key my-map (kbd ".") 'turn-volume-up)
(define-key my-map (kbd ",") 'turn-volume-down)

;; ; set default browser
(setq browse-url-generic-program "open"
      browse-url-browser-function 'browse-url-generic)

; "locate" buffer (since i disable window title i need a convenient way to get the dir)
; (overrides default count-lines-page)
(global-set-key (kbd "C-x l") 'dired-at-point)

; nicer window switching
(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

; better window cycling
(global-set-key (kbd "C-c <down>") 'select-next-window)
(global-set-key (kbd "C-c <up>")  'select-previous-window)

;; add an extra confirmation dialog to the close procedure
; (setq kill-emacs-query-functions
;       (cons (lambda () (yes-or-no-p "Really end this emacs session? "))
;     kill-emacs-query-functions))

; easy shortcut to rename-buffer
(global-set-key (kbd "C-c r") 'rename-buffer)

;; uniquify duplicate buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; use js-mode for .json files
(setq auto-mode-alist (cons '("\\.json$" . js-mode) auto-mode-alist))

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; set a beautiful title bar
(setq frame-title-format
      '("%S: " (buffer-file-name "%f"
                                 (dired-directory dired-directory "%b"))))

;; meta G
(global-set-key "\M-g" 'goto-line)

;; dont show splash
(setq inhibit-splash-screen t)

;; winner mode for window layout undo/redo
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; mouse scroll wheel one line at a time
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control) . nil)))

(defun find-alternate-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
         buffer-file-name))))

;; keyboard one line at a time
; C-h d scroll-step suggests doing this instead of scroll-step 1
(setq scroll-conservatively 10000)
; (setq scroll-step 1)

;; paste at cursor position, not at mouse position
(setq mouse-yank-at-point t)

; by ashawley on #emacs on FreeNode
(defun ash-find-file-to-window (file window)
  "Open FILE in WINDOW."
  (interactive
   (list
    (read-file-name "Find file: " default-directory nil
                    (confirm-nonexistent-file-or-buffer))
    (let* ((win-buffs (mapcar (lambda (p) (cons (buffer-name (car p))
                                                (cdr p)))
                              (mapcar (lambda (w)
                                        (cons (window-buffer w) w))
                                      (window-list))))
           (buff (completing-read "Window: "
                                  (mapcar 'car win-buffs)))
           (win (assoc buff win-buffs)))
      (unless (consp win)
        (error "No window with buffer %s" buff))
      (cdr win))))
  (select-window wi<ndow)
  (find-file file))
(global-set-key (kbd "C-c w") 'ash-find-file-to-window)

;; coding style
(c-set-offset 'case-label '+)
(setq-default c-default-style "k&r")
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-label-offset 0)

;; ctrl-shift-s is grep-buffers
(global-set-key (quote [33554451]) (quote grep-buffers))

;; occur mode greatness
(global-set-key (kbd "C-c o") 'occur)

(global-set-key (kbd "M-S-<down>") 'next-error)
(global-set-key (kbd "M-S-<up>") 'previous-error)

; log timestamps when changing states.. define some custom states
; keep the first one TODO because C-M-RET creates new task with first item
(setq org-todo-keywords '((sequence "TODO(t!)" "WAIT(w!)" "|" "DONE(d!)" "NOTE(n!)" "CANC(c!)")))

;; unified diffs
(setq diff-switches "-u")

;; case insensitive searches
(setq case-fold-search t)

;; C-c # is comment-region
(global-set-key (kbd "C-c #") 'comment-region)

;; python 4 space indents please.
(setq-default py-indent-offset 4)

;; auto-complete for eclim
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; highlighter!
;  (global-set-key (kbd "C-c m") 'markerpen-mark-region)

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))

;; open up a remote shell through tramp
(defun remote-shell (&optional host)
  "Open a remote shell to a host."
  (interactive)
  (with-temp-buffer
    (let ((host (if host host (read-string "Host: ")))
          (explicit-shell-file-name "/bin/bash"))
      (cd (concat "/scp:" host ":"))
      (shell (concat "*" host "*")))))

; bip causes server messages to come in containing unsolicited channel
; user lists and other junk.  this hides it

(setq temporary-file-directory "~/.emacs.d/tmp/")

; no annoying lockfiles that interfere with grunt watch
(setq create-lockfiles nil)

; http://stackoverflow.com/questions/10041284/how-to-not-save-changes-in-file-and-in-temp-buffer-too
(when (boundp 'save-some-buffers-action-alist)
  (setq save-some-buffers-action-alist
        (cons
         (list
          ?u
          #'(lambda (buf)
              (with-current-buffer buf
                (set-buffer-modified-p nil))
              nil)
          "mark buffer unmodified.")
         (cons
          (list
           ?r
           #'(lambda (buf)
               (with-current-buffer buf
                 (revert-buffer t))
               nil)
           "revert buffer.")
          save-some-buffers-action-alist))))

;; tidy hook for cleaning xml/html
; http://www.hollenback.net/index.php?EmacsTidy
; Function to run Tidy HTML parser on buffer
; NOTE: this requires external Tidy program
(defun tidy-buffer ()
  "Run Tidy XML parser on current buffer."
  (interactive)
  (if (get-buffer "tidy-errs") (kill-buffer "tidy-errs"))
  (shell-command-on-region (point-min) (point-max)
                           "tidy -f /tmp/tidy-errs -i -xml" t)
  (find-file-other-window "/tmp/tidy-errs")
  (other-window 1)
  (delete-file "/tmp/tidy-errs")
  (message "buffer tidy'ed")
  )
(global-set-key (kbd "C-x t") 'tidy-buffer)
(global-set-key (kbd "C-x v") 'magit-status)
(global-set-key (kbd "C-c q") 'delete-trailing-whitespace)
(global-set-key (kbd "C-c g") 'rope-goto-definition)
(global-set-key (kbd "C-c d") 'rope-show-doc)
(global-set-key [f10] 'flycheck-error)
(global-set-key [f11] 'flycheck-previous-error)

(defun save-macro (name)
  "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
  (interactive "SName of the macro :")  ; ask for the name of the macro
  (kmacro-name-last-macro name)         ; use this name for the macro
  (find-file user-init-file)            ; open ~/.emacs or other user init file
  (goto-char (point-max))               ; go to the end of the .emacs
  (newline)                             ; insert a newline
  (insert-kbd-macro name)               ; copy the macro
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

;;; register population .. poor man's snippet library
(set-register ?i "import IPython; IPython.embed(simple_prompt=True)")
(set-register ?p "import pdb; pdb.set_trace()")
(set-register ?h "Reviewed by: TBD Approved by: Daniel")
(set-register ?w "<script src='http://10.200.200.6:8881/target/target-script-min.js#anonymous'></script>")
(set-register ?l "9HqfSvFjT4")

(put 'upcase-region 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-keyword-face ((t (:foreground "#FF8888"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#bcdcfc"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#c3a8e6"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#c3f6c8"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#f6c3c8"))))
 '(trailing-whitespace ((t (:background "#001b1b" :foreground "#314b4b")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu nil)
 '(ac-auto-start nil)
 '(ac-delay 0.3)
 '(ac-expand-on-auto-complete t)
 '(ac-show-menu-immediately-on-auto-complete nil)
 '(ac-trigger-commands (quote (self-insert-command)))
 '(ac-trigger-key "TAB")
 '(ac-use-fuzzy nil)
 '(ack-executable (executable-find "ack-grep"))
 '(ack-project-root-file-patterns (quote (".ropeproject")))
 '(ack-prompt-for-directory t)
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(backup-by-copying t)
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/tmp/"))))
 '(coffee-tab-width 4)
 '(comint-prompt-read-only nil)
 '(compilation-scroll-output t)
 '(css-indent-offset 2)
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("43032e2a6d0249ad2d7aef3dabcb1236f6cba8dd7223772c5411970fd3a1ef15" "78e95ad3d8aa41b5fffa63f7501d930e101c28755eab696c73e1e2d73ff688e1" "d064986c904fdcab986f5f981f1ff0f210045ecf27f9745f7b3addb020afc6f1" default)))
 '(dired-dwim-target t)
 '(diredp-hide-details-initially-flag nil)
 '(egg-buffer-hide-help-on-start
   (quote
    (egg-status-buffer-mode egg-log-buffer-mode egg-file-log-buffer-mode egg-reflog-buffer-mode egg-diff-buffer-mode egg-commit-buffer-mode)))
 '(egg-mode-key-prefix "C-c e")
 '(egg-show-key-help-in-buffers (quote (:status :log :file-log :reflog :diff :commit)))
 '(elpy-rpc-python-command "python3")
 '(erc-join-buffer (quote bury))
 '(erc-max-buffer-size 50000)
 '(erc-track-minor-mode nil)
 '(erc-track-mode nil)
 '(erc-truncate-mode t)
 '(exec-path
   (quote
    ("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin" "/usr/local/bin" "/home/sean/bin")))
 '(flycheck-flake8-maximum-line-length 120)
 '(flycheck-python-flake8-executable "python3")
 '(flycheck-python-pylint-executable "python3")
 '(git-commit-summary-max-length 190)
 '(global-flycheck-mode t nil (flycheck))
 '(indicate-empty-lines t)
 '(jde-jdk (quote ("1.7")))
 '(jde-jdk-registry
   (quote
    (("1.8" . "/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home")
     ("1.7" . "/Library/Java/JavaVirtualMachines/jdk1.7.0_65.jdk/Contents/Home"))))
 '(jedi:complete-on-dot t)
 '(menu-bar-mode nil)
 '(mingus-mode-always-modeline t)
 '(mingus-mpd-host "lockwood")
 '(mingus-use-mouse-p nil)
 '(nxml-child-indent 4)
 '(org-agenda-files nil)
 '(org-directory "~/Desktop/org")
 '(org-log-into-drawer t)
 '(org-mobile-directory "/home/sean/Desktop/org/mobile/")
 '(org-mobile-files (quote (org-agenda-files "~/Desktop/org/")))
 '(org-mobile-inbox-for-pull "~/Desktop/org/mobile/inbox.org")
 '(package-selected-packages
   (quote
    (mingus pymacs jedi exec-path-from-shell thrift rjsx-mode nvm auto-complete browse-kill-ring coffee-mode color-theme dsvn f highlight jade-mode json-reformat key-chord kill-ring-search projectile rainbow-delimiters stylus-mode helm markdown-mode js2-mode company dockerfile-mode flycheck yaml-mode use-package)))
 '(projectile-global-mode t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "node_modules")))
 '(projectile-globally-ignored-files (quote ("*.map" "TAGS" "*vendor.js" "./build/*")))
 '(projectile-mode t nil (projectile))
 '(projectile-project-root-files
   (quote
    (".projectile" ".git" ".hg" ".fslckout" ".bzr" "_darcs" "rebar.config" "project.clj" "pom.xml" "build.sbt" "build.gradle" "Gemfile" "Makefile" ".svn")))
 '(projectile-use-native-indexing nil)
 '(py-electric-comment-p nil)
 '(py-shell-name "/usr/bin/ipython")
 '(python-check-command "flake8")
 '(python-shell-interpreter "python3")
 '(recentf-auto-cleanup (quote mode))
 '(same-window-buffer-names (quote ("*shell*")))
 '(tool-bar-mode nil)
 '(typescript-indent-level 2)
 '(w3m-use-cookies t)
 '(wg-morph-on nil)
 '(window-number-mode t)
 '(winner-boring-buffers nil)
 '(winner-mode t nil (winner))
 '(winner-ring-size 300))

(load-theme 'Pio t)

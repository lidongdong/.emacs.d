;;;
;;;
;;; Extra config: general

;;; Usage: Append or require this file from init.el for bindings in Emacs.

;;; Contents:
;;;
;;;  - Core Packages

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Core Packages
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General: keybinding
(use-package general
  :ensure t

  :config
  ;; 设置leader键（类似Spacemacs/Doom Emacs）
  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC")  ; 在非 normal 模式下使用 Ctrl+Space
  
  ;; 定义 Space 为 Leader
  (general-define-key
    :states '(normal visual insert emacs)
    :keymaps 'override
    "SPC" nil  ; 清除默认绑定（如果有）
    "C-SPC" nil)

  ;; esc代替ctrl+g退出minibuffer
  (general-define-key
   :keymaps '(minibuffer-local-map 
	      minibuffer-local-ns-map
	      minibuffer-local-completion-map
	      minibuffer-local-must-match-map
	      minibuffer-local-filename-completion-map)
   "<escape>" 'keyboard-escape-quit)

  (general-define-key
   :keymaps '(evil-motion-state-map)
   "gd" 'xref-find-definitions
   "gr" 'xref-find-references)
)

;; 使用 my-leader-def 定义所有键绑定
(my-leader-def
  ;; 基础命令
  "SPC" '(execute-extended-command :wk "M-x")
  ":"   '(evil-ex :wk "ex command")
  "!"   '(shell-command :wk "shell command")
  
  ;; 缓冲区操作
  "b"   '(:ignore t :wk "buffer")
  "bb"  '(switch-to-buffer :wk "switch buffer")
  "bd"  '(kill-this-buffer :wk "kill buffer")
  "bn"  '(next-buffer :wk "next buffer")
  "bp"  '(previous-buffer :wk "previous buffer")
  "bs"  '(save-buffer :wk "save buffer")
  "bS"  '(save-some-buffers :wk "save all buffers")
  "bk"  '(kill-buffer :wk "kill buffer")
  
  ;; 窗口操作
  "w"   '(:ignore t :wk "window")
  "ww"  '(other-window :wk "other window")
  "wd"  '(delete-window :wk "delete window")
  "wh"  '(evil-window-left :wk "left window")
  "wj"  '(evil-window-down :wk "down window")
  "wk"  '(evil-window-up :wk "up window")
  "wl"  '(evil-window-right :wk "right window")
  "ws"  '(split-window-below :wk "split horizontal")
  "wv"  '(split-window-right :wk "split vertical")
  "w="  '(balance-windows :wk "balance windows")
  "wm"  '(delete-other-windows :wk "maximize window")
  
  ;; 文件操作
  "f"   '(:ignore t :wk "file")
  "ff"  '(find-file :wk "find file")
  "fs"  '(save-buffer :wk "save file")
  "fS"  '(write-file :wk "save as")
  "fr"  '(recentf-open-files :wk "recent files")
  "fd"  '(dired :wk "open dired")
  
  ;; 项目操作 (需要 projectile)
  "p"   '(:ignore t :wk "project")
  "pp"  '(project-switch-project :wk "switch project")
  "pf"  '(project-find-file :wk "find file in project")
  "ps"  '(projectile-save-project-buffers :wk "save project buffers")
  "pc"  '(project-compile- :wk "compile project")
  
  ;; 搜索
  "s"   '(:ignore t :wk "search")
  "ss"  '(swiper :wk "swiper search")
  "sr"  '(vr/replace :wk "visual replace")
  "sb"  '(consult-buffer :wk "search buffer")
  
  ;; 代码操作
  "c"   '(:ignore t :wk "code")
  "cc"  '(comment-line :wk "comment line")
  "cl"  '(comment-line :wk "comment line")
  "c/"  '(comment-line :wk "comment line")
  "ca"  '(eglot-code-actions :wk "code actions")
  "cr"  '(eglot-rename :wk "rename")
  "cf"  '(eglot-format :wk "format")
  
  ;; Git 操作 (需要 magit)
  "g"   '(:ignore t :wk "git")
  "gg"  '(magit-status :wk "magit status")
  "gl"  '(magit-log :wk "git log")
  "gb"  '(magit-branch :wk "git branch")
  "gc"  '(magit-commit :wk "git commit")
  "gp"  '(magit-push :wk "git push")
  "gd"  '(magit-diff :wk "git diff")
  
  ;; 切换/切换状态
  "t"   '(:ignore t :wk "toggle")
  "tn"  '(display-line-numbers-mode :wk "line numbers")
  ;; "tt"  '(treemacs :wk "treemacs")
  "tw"  '(whitespace-mode :wk "whitespace mode")
  "ts"  '(flyspell-mode :wk "spell check")
  
  ;; 帮助
  "h"   '(:ignore t :wk "help")
  "hf"  '(describe-function :wk "describe function")
  "hv"  '(describe-variable :wk "describe variable")
  "hk"  '(describe-key :wk "describe key")
  "hm"  '(describe-mode :wk "describe mode")
  "hp"  '(describe-package :wk "describe package")
  
  ;; 应用程序
  "a"   '(:ignore t :wk "apps")
  "ae"  '(eshell :wk "eshell")
  "at"  '(vterm :wk "vterm")
  "ac"  '(calendar :wk "calendar")
  "am"  '(mu4e :wk "email")
  
  ;; 退出/重启
  "q"   '(:ignore t :wk "quit")
  "qq"  '(save-buffers-kill-emacs :wk "quit Emacs")
  "qr"  '(restart-emacs :wk "restart Emacs")
  "qs"  '(save-buffers-kill-terminal :wk "save and quit")
  
  ;; ;; 特殊模式
  ;; "x"   '(:ignore t :wk "text")
  ;; "xl"  '(downcase-region :wk "to lowercase")
  ;; "xu"  '(upcase-region :wk "to uppercase")
  ;; "xc"  '(capitalize-region :wk "capitalize")
  
  ;; 自定义
  "o"   '(:ignore t :wk "own")
  "oc"  '(my-custom-command :wk "custom command"))


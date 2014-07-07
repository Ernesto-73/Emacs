;;;; 一些全局配置
(global-linum-mode t);显示行号
(tool-bar-mode 0)  
(menu-bar-mode 0)  
;(scroll-bar-mode 0) 
(customize-set-variable 'scroll-bar-mode 'right)
(global-set-key [f4] 'other-window)

;;;; 主题
(add-to-list 'load-path "~/.emacs.d/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-simple-1)

;;;; dired文件管理器
(setq dired-recursive-deletes t) ; 可以递归的删除目录
(setq dired-recursive-copies t) ; 可以递归的进行拷贝
(require 'dired-x) ; 有些特殊的功能
(global-set-key "\C-x\C-j" 'dired-jump) ; 通过 C-x C-j 跳转到当前目录的 Dired

;;;; 配置gdb
(setq-default compile-command "make")
(global-set-key [C-f7] 'compile)
(global-set-key [f6] 'gdb)
(global-set-key [f5] 'gud-go)
(global-set-key [f9] 'gud-break)
(global-set-key [f10] 'gud-next)
(global-set-key [f11] 'gud-step)

;;;; CC-mode配置，缩进控制  
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;;; C/C++语言编辑策略
(defun my-c-mode-common-hook()
    (setq-default indent-tabs-mode nil)
    (setq tab-width 4 c-basic-offset 4)
    ;; hungry-delete and auto-newline
    (c-toggle-auto-hungry-state 1)
    
    ;;按键定义
    (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
    (define-key c-mode-base-map [(return)] 'newline-and-indent)
    (define-key c-mode-base-map [(f7)] 'compile)
    (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
    ;;(define-key c-mode-base-map [(tab)] 'hippie-expand)
    (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
    (define-key c-mode-base-map [(meta n)] 'semantic-ia-complete-symbol-menu)

    ;;预处理设置
    (setq c-macro-shrink-window-flag t)
    (setq c-macro-preprocessor "cpp")
    (setq c-macro-cppflags " ")
    (setq c-macro-prompt-flag t)
    (setq hs-minor-mode t)
    (setq abbrev-mode t)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;; C++语言编辑策略
(defun my-c++-mode-hook()
    (setq tab-width 4 indent-tabs-mode nil)
    (c-set-style "stroustrup")
    ;;  (define-key c++-mode-map [f3] 'replace-regexp)
)   

;;;; CEDET
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(setq semanticdb-project-roots 
      (list
        (expand-file-name "/")))

(defun my-indent-or-complete ()
   (interactive)
   (if (looking-at "\\>")
      (hippie-expand nil)
      (indent-for-tab-command))
 )

(global-set-key [(control tab)] 'my-indent-or-complete)

(autoload 'senator-try-expand-semantic "senator")

(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
)

(global-set-key [f8] 'semantic-ia-fast-jump)
(global-set-key [(f12)] 'speedbar)

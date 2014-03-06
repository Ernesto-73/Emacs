;显示行号
(global-linum-mode t)

(setq-default compile-command "make")
(global-set-key [C-f7] 'compile)
(global-set-key [f6] 'gdb)
(global-set-key [f5] 'gud-go)
(global-set-key [f9] 'gud-break)
(global-set-key [f10] 'gud-next)
(global-set-key [f11] 'gud-step)


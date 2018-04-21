;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)
; 开启全局 Company 补全
(global-company-mode 1)
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)
;; 关闭文件滑动控件
(scroll-bar-mode -1)
;; 显示行号
(global-linum-mode 1)
;;显示光标所在的行
(global-hl-line-mode t)
;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
;; 更改显示字体大小 16pt
(set-face-attribute 'default nil :height 160)
;;改变光标样式
(setq-default cursor-type 'bar)
;;选中后输入会替换掉你选中部分的文字
(delete-selection-mode 1)
;;禁止备份文件的生成 例如init.el~ 因为用git管理了就没必要了
(setq make-backup-files nil)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)
;;最近打开的文件
;;require 从一个文件中会加载一个特性，recentf为作为它的文件名
(require 'recentf)
;;开启这个mode
(recentf-mode 1)
;;文件最大的保存个数
(setq recentf-max-menu-item 10)
;;括号匹配
;;添加一个钩子 添加在emacs-lisp-mode上面  然后show-paren-mode会生效
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))
;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;当Emacs的版本大于24的时候

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;;把melpa插件源加载到系统里面
  (add-to-list 'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/"))
  )

(require 'cl)
;;定义一个packages的列表
(defvar my/packages '(
		      ;;自动补全
		      company
		      ;;主题样式
		      monokai-theme
		      ;;空格方便删除
		      hungry-delete
		      ;;方便搜索等功能提示
		      swiper
		      counsel
		      ;;自动补全括号
		      smartparens
		      ;;Python开发环境
		      elpy
		      ;;Python虚拟环境
		      virtualenvwrapper
		      ;;Python实时语法检查
		      flycheck
		      ;;遵循PEP8规范
		      py-autopep8
		      ) "Default packages")
;;因为执行package-autoremove只考虑package-selected-packages里的包，不会考虑我们需要的的
;;所以把我们需要的包赋给它，在执行的时候就不会提示去删除需要的包了
(setq package-selected-packages 'my/packages)
;;定义一个方法用来判断my/packages中定义的packages是否安装了
;;全部安装完了返回nil 否则返回t
(defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

;;执行上面定义的方法，只要有一个没有安装就会安装它
(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;对应文件自动切换到对应mode
;;(setq auto-mode-alist
;;      (append
;;       '(("\\.py\\'" . elpy-mode))
;;       auto-mode-alist))

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
;;加载主题样式
(load-theme 'monokai t)
;;方便空格删除使用
(require 'hungry-delete)
(global-hungry-delete-mode)
;;方便搜索等功能提示
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
;;ivy-resume这个是记录你上一次的操作
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;;自动补全括号
(require 'smartparens-config)
(smartparens-global-mode t)

;;使用elpy
(require 'elpy)
(elpy-enable)
;;使用IPython
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;;虚拟环境配置
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells);;如果需要交互式shells支持
(venv-initialize-eshell);;如果需要shells支持
(setq venv-location "~/python_env/")

;;使用flycheck代替flymake
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;遵循pep8规范
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(custom-safe-themes
   (quote
    ("c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" default)))
 '(package-selected-packages
   (quote
    (elpy smartparens org monokai-theme hungry-delete counsel company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

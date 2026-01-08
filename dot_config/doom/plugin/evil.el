(use-package! evil-escape
  :ensure t
  :after evil
  :init
  (setq evil-escape-key-sequence "jk") ;; Set shortcut key sequence
  (setq evil-escape-delay 0.5) ;; Set the time between two key presses
  :config
  (evil-escape-mode 1))


  (map! :n "H" #'previous-buffer)
  (map! :n "L" #'next-buffer)
  (map! :n "L" #'next-buffer)
(map! :leader
  :desc "switch project"              "f p" #'projectile-switch-project
  :desc "switch buffer"               "f b" #'persp-switch-to-buffer
  :desc "switch buffer"               "f f" #'projectile-find-file
  )

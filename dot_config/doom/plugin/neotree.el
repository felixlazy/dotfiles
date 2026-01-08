;; dot_config/doom/plugin/neotree.el
(map! :leader
  (:when (modulep! :ui neotree)
  :desc "neotree open"              "e" #'neotree-toggle))

(use-package! doom-themes
  ;; improve integration w/ org-mode
  :hook (doom-load-theme . doom-themes-org-config)
  :init (setq doom-theme 'doom-one)
  ;; more Atom-esque file icons for neotree/treemacs
  (when (modulep! :ui neotree)
    (add-hook 'doom-load-theme-hook #'doom-themes-neotree-config)
    (setq doom-themes-neotree-enable-variable-pitch t
          doom-themes-neotree-file-icons t
          doom-themes-neotree-line-spacing 2))
  )

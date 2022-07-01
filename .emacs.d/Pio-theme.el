(deftheme Pio
  "Created 2013-09-13.")

(custom-theme-set-faces
 'Pio
 '(default ((t (:family "Inconsolata" :foundry "unknown" :width normal :height 95 :weight bold :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "white" :background "black" :stipple nil :inherit nil))))
 '(cursor ((t (:background "red"))))
 '(fixed-pitch ((t (:family "courier"))))
 '(variable-pitch ((t (:family "helv"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "medium blue"))))
 '(highlight ((t (:background "darkolivegreen"))))
 '(region ((t (:background "DarkSlateGray"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:background "SkyBlue4"))))
 '(trailing-whitespace ((t (:background "white"))))
 '(font-lock-builtin-face ((t (:foreground "SteelBlue"))))
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:slant oblique :foreground "#77DDFF"))))
 '(font-lock-constant-face ((t (:weight bold :foreground "#FF9999"))))
 '(font-lock-doc-face ((t (:foreground "BurlyWood" :slant oblique))))
 '(font-lock-function-name-face ((t (:weight bold :foreground "white"))))
 '(font-lock-keyword-face ((t (:foreground "#FF5555"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:weight bold :foreground "Gold"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:slant oblique :foreground "#55FF55"))))
 '(font-lock-type-face ((t (:family "Inconsolata" :weight bold :foreground "PaleGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "white"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "chocolate"))))
 '(button ((t (:inherit (link)))))
 '(link ((((class color) (min-colors 88) (background light)) (:underline (:color foreground-color :style line) :foreground "RoyalBlue3")) (((class color) (background light)) (:underline (:color foreground-color :style line) :foreground "blue")) (((class color) (min-colors 88) (background dark)) (:underline (:color foreground-color :style line) :foreground "cyan1")) (((class color) (background dark)) (:underline (:color foreground-color :style line) :foreground "cyan")) (t (:inherit (underline)))))
 '(link-visited ((default (:inherit (link))) (((class color) (background light)) (:foreground "magenta4")) (((class color) (background dark)) (:foreground "violet"))))
 '(fringe ((t (:family "courier new" :foundry "outline" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "Wheat" :background "grey4" :stipple nil))))
 '(header-line ((t (:height 0.9 :box (:line-width 3 :color "grey20" :style released-button) :foreground "grey75" :background "grey20" :family "Arial"))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
 '(mode-line ((t (:family "Arial" :height 1.0 :box (:line-width 1 :color "blue" :style released-button) :foreground "khaki" :background "blue"))))
 '(mode-line-buffer-id ((t (:family "Arial" :height 0.9 :weight bold :box (:line-width 1 :color "dark blue" :style released-button) :foreground "white" :background "blue"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:family "Arial" :height 1.0 :box (:line-width 1 :color "dark blue" :style released-button) :foreground "khaki" :background "#000055"))))
 '(isearch ((t (:background "palevioletred2"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((((class color) (min-colors 88) (background light)) (:background "paleturquoise")) (((class color) (min-colors 88) (background dark)) (:background "paleturquoise4")) (((class color) (min-colors 16)) (:background "turquoise3")) (((class color) (min-colors 8)) (:background "turquoise3")) (t (:underline (:color foreground-color :style line)))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'Pio)

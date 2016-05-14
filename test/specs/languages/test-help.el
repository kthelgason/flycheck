;;; test-help.el --- Flycheck Specs: Syntax checker help  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Sebastian Wiesner

;; Author: Sebastian Wiesner <swiesner@lunaryorn.com>

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Specs for `flycheck-describe-checker' and related functions.

;;; Code:

(describe "Syntax checker Help"
  (let ((checker 'haskell-ghc)
        inhibit-message-before)

    (before-each
      (setq inhibit-message-before inhibit-message
            inhibit-message t))

    (after-each
      (setq inhibit-message inhibit-message-before)
      (when (buffer-live-p (get-buffer (help-buffer)))
        (kill-buffer (help-buffer))))

    (describe "flycheck-describe-checker"
      (it (format "pops up a help buffer for %s" checker)
        (flycheck-describe-checker checker)
        (expect (help-buffer) :to-be-live)
        (expect (help-buffer) :to-be-visible))

      (it (format "documents %s in the help buffer" checker)
        (flycheck-describe-checker checker)
        (expect (help-buffer) :to-contain-match
                (rx symbol-start (group (1+ nonl) symbol-end)
                    " is a Flycheck syntax checker"))
        (with-current-buffer (help-buffer)
          (expect (match-string 1) (symbol-name checker))))

      (it (format "navigates to the source of %s" checker))

      (it (format "shows next checkers in the help of %s" checker))

      (it (format "shows the executable name in the help of %s" checker))

      (it (format "shows the executable variable in the help of %s" checker))

      (it (format "shows the configuration file variable in the help of %s"
                  checker))

      (it (format "shows the option variables in the help of %s"
                  checker)))))

;;; test-help.el ends here

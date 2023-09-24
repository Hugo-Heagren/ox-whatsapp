;; ox-whatsapp.el --- Org mode whatsapp exporter   -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Hugo Heagren

;; Author: Hugo Heagren <hugo@heagren.com>
;; Keywords: outlines, hypermedia, calendar, wp
;; Version: 0.1
;; Package-Requires: ((emacs "24.4"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A simple org mode exporter for WhatsApp markup.

;;; Code:

(require 'org-element')
(require 'ox)

(defun ox-whatsapp-italic (_italic contents _info)
  "Transcode italic from Org to Whatsapp markup.
CONTENTS is the text with italic markup.  INFO is a plist holding
contextual information."
  (format "_%s_" contents))

(defun ox-whatsapp-strike-through (_strike-through contents _info)
  "Transcode STRIKE-THROUGH from Org to Whatsapp markup.
CONTENTS is text with strike-through markup.  INFO is a plist
holding contextual information."
  (format "~%s~" contents))

(defun ox-whatsapp-code (code _contents info)
  "Return a CODE object from Org to Whatsapp markup.
CONTENTS is nil.  INFO is a plist holding contextual
information."
  (format "```%s```" (org-element-property :value code)))

(defun ox-whatsapp-export-as-whatsapp
    (&optional async subtreep visible-only body-only ext-plist)
"Export current buffer to a text buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the ‘org-export-stack’ interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don’t export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, strip title and
table of contents from output.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Ox-Whatsapp Export*\", which
will be displayed when ‘org-export-show-temporary-export-buffer’
is non-nil."
  (interactive)
  (org-export-to-buffer 'whatsapp "*Ox-Whatsapp Export*"
    async subtreep visible-only body-only ext-plist (lambda () (text-mode))))

(org-export-define-derived-backend 'whatsapp 'ascii
  :translate-alist
  '((italic . ox-whatsapp-italic)
    (strikethrough . ox-whatsapp-strike-through)
    (code . ox-whatsapp-code))
  :menu-entry
  '(?t 1
       ((?W "As ASCII buffer (Whatsapp markup)"
	    ox-whatsapp-export-as-whatsapp))))

(provide 'ox-whatsapp)
;;; ox-whatsapp.el ends here

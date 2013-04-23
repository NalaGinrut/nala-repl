;;  -*-  indent-tabs-mode:nil; coding: utf-8 -*-
;;  Copyright (C) 2013
;;      "Mu Lei" known as "NalaGinrut" <NalaGinrut@gmail.com>
;;  This is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.

;;  This is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (nala src)
  #:use-module (system repl command)
  #:use-module (system vm program)
  #:use-module (system repl common)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim))

(define (skip-lines port n)
  (cond
   ((zero? n) port)
   (else (read-line port) (skip-lines port (1- n)))))

(define (mk-re name)
  (make-regexp (format #f "^\\(define (~a|\\(~a.*\\))" name name)))

(define (is-def? re str)
  (regexp-exec re str))

(define (read-between in start end)
  (seek in 0 SEEK_SET) ; back to begining
  (skip-lines in (1- start)) ; jump to start line
  (call-with-output-string
   (lambda (out)
     (let lp((line (read-line in)) (l start))
       (cond
        ((or (eof-object? line) (> l end)) (close in))
        (else 
         (format out "~a~%" line) 
         (lp (read-line in) (1+ l))))))))

(define (get-src source pname)
  (let* ((fn (source:file source))
         (filename (any (lambda (x) 
                          (let ((f (string-append x "/" fn))) 
                            (if (file-exists? f) f #f))) %load-path))
         (re (mk-re pname)))
    (call-with-input-file filename
      (lambda (in)
        (let lp((line (read-line in)))
          (cond
           ((eof-object? line) #f)
           ((is-def? re line) 
            (unread-string line in)
            (let* ((start (port-line in))
                   (end (begin (read in) (port-line in))))
              (read-between in start (1+ end))))
           (else (lp (read-line in)))))))))

(define (get-program-src p)
  (let ((source (program-source p 0)))
    (cond
     ((not source) "It's inner procedure implemented with C\n")
     ((not (source:file source)) #f)
     (else (get-src source (symbol->string (procedure-name p)))))))

(define (print-src p)
  (let ((src (and (program? p) (get-program-src p))))
    (and src (display src))))

(eval-when (compile load eval)
(define-meta-command ((src nala) repl (form))
   "Print source code of specified Scheme procedure."
   (call-with-values (repl-prepare-eval-thunk repl (repl-parse repl form))
     (lambda args (for-each print-src args)))))

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

(define-module (nala shell)
  #:use-module (system repl command)
  #:use-module (system vm program)
  #:use-module (system repl common)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim))

(define (cmd-run . args)
  (system (string-join args " ")))

(eval-when (compile load eval)
(define-meta-command ((shell nala) repl . args)
   "Run exp as shell command."
   (apply cmd-run (map object->string args))))

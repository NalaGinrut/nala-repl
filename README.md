This is an enhanced REPL for GNU Guile.
Only support Guile-2.0.9 and later.

This project currently provided:

1. Scheme source code printing
2. Colorized REPL
3. Run shell command

=== Scheme source code printing ===
* TEST

Copy these lines below to your REPL for test:
``` scheme
(use-modules (nala src))
,src map
```

* ENJOY

Add this to your ~/.guile
``` scheme
(use-modules (nala src))
```

=== Colorized REPL ===

* TEST

Copy these lines below to your REPL for test:
``` scheme
(use-modules (oop goops) (rnrs) (ice-9 colorized))
(activate-colorized)
`(this-is-a-symbol 1 2.5 2/5 #\c "asdf" ,(lambda () #t) ,(cons 1 2) ,(vector 1 2 3) #2u32@2@3((1 2) (3 4)) ,(make-bytevector 10 99) ,<object>)
```

* ENJOY

And you may add these to your ~/.guile
``` scheme
(use-modules (ice-9 colorized))
(activate-colorized)
```


=== Run shell command ===
``` scheme
(use-modules (nala shell))
,shell uname -r
``` 


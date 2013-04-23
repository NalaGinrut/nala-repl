MOD := nala
TARGET := $(shell guile -c "(display (car %load-path))")
MOD_PATH := $(TARGET)/$(MOD)

all:
	echo "just type 'sudo make install'"

install:
	cp -frdp $(MOD) $(MOD_PATH)

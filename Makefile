MOD := nala
TARGET := $(shell guile -c "(display (%global-site-dir))")

all:
	echo "just type 'make install'"

install:
	cp -frdp $(MOD) $(TARGET)

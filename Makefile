PRODUCT_NAME := Messager

.PHONY: setup
setup:
	$(MAKE) xcodegen-generate
	$(MAKE) install-bundler
	$(MAKE) install-pod

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-pod
install-pod:
	pod install

.PHONY: xcodegen-generate
xcodegen-generate:
	mint run xcodegen generate

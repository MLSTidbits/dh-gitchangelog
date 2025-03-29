#!/bin/env make -f

PACKAGE = dpkg-changelog
VERSION = $(shell bash scripts/set-version)

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

INSTALL = dpkg-dev, git
BUILD = debhelper (>= 11), git, make (>= 4.1), dpkg-dev

HOMEPAGE = https://github.com/MichaelSchaecher/dpkg-changelog

PACKAGE_DIR = package

ARCH = $(shell dpkg --print-architecture)

export PACKAGE_DIR PACKAGE VERSION MAINTAINER INSTALL BUILD HOMEPAGE ARCH

# Phony targets
.PHONY: all debian clean help

# Default target
all: debian

debian:

	@echo "Building package $(PACKAGE) version $(VERSION)"

	@scripts/set-control

	@dpkg-changelog $(PACKAGE_DIR)/DEBIAN/changelog
	@dpkg-changelog $(PACKAGE_DIR)/usr/share/doc/$(PACKAGE)/changelog
	@gzip -d $(PACKAGE_DIR)/DEBIAN/*.gz
	@mv $(PACKAGE_DIR)/DEBIAN/changelog.DEBIAN $(PACKAGE_DIR)/DEBIAN/changelog

	@scripts/mkdeb

install:

	@dpkg -i package/$(PACKAGE)_$(VERSION)_$(ARCH).deb

clean:
	@rm -Rvf ./package

help:
	@echo "Usage: make [target] <variables>"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build the debian package and install it"
	@echo "  debian    - Build the debian package"
	@echo "  install   - Install the debian package"
	@echo "  clean     - Clean up build files"
	@echo "  help      - Display this help message"
	@echo ""

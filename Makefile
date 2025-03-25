#!/bin/env make -f

PACKAGE = dpkg-changelog
VERSION = $(shell cat VERSION)

# dpkg Section option
SECTION = utils

# Set priority of the package for deb package manager
# optional, low, standard, important, required
PRIORITY = optional

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

DESCRIPTION = Change log generator from git commits log for debian packages

HOMEPAGE = https:\/\/github.com\/MichaelSchaecher\/dpkg-changelog

# Architecture (amd64, i386, armhf, arm64, ... all)
AARCH = amd64

DEPENDS = bash, coreutils, dpkg

ROOTDIR = $(shell pwd)

# Build path
BUILDDIR = build/$(PACKAGE)_$(VERSION)_$(AARCH)

export ROOTDIR BUILDDIR

# Phony targets
.PHONY: debian clean help

# Default target
all: debian

debian:

	@mkdir -pv $(BUILDDIR)/DEBIAN \
		$(BUILDDIR)/usr/bin \
		$(BUILDDIR)/usr/share/doc/$(PACKAGE)

	@cp -vf src/$(PACKAGE) $(ROOTDIR)/$(BUILDDIR)/usr/bin/
	@cp -vf $(ROOTDIR)/doc/copyright $(ROOTDIR)/$(BUILDDIR)/usr/share/doc/$(PACKAGE)/
	@cp -vf $(ROOTDIR)/debian/* $(ROOTDIR)/$(BUILDDIR)/DEBIAN/

	@chmod +x $(ROOTDIR)/$(BUILDDIR)/usr/bin/$(PACKAGE)

	@git-changelog $(ROOTDIR)/$(BUILDDIR)/usr/share/doc/$(PACKAGE)/changelog

	@sed -i "s/Version:/Version: $(VERSION)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Section:/Section: $(SECTION)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Priority:/Priority: $(PRIORITY)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Architecture:/Architecture: $(AARCH)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Depends:/Depends: $(DEPENDS)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Maintainer:/Maintainer: $(MAINTAINER)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Install-Size:/Install-Size: `du -s $(BUILDDIR) | cut -f1`/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Description:/Description: $(DESCRIPTION)/" $(BUILDDIR)/DEBIAN/control
	@sed -i "s/Homepage:/Homepage: $(HOMEPAGE)/" $(BUILDDIR)/DEBIAN/control

	@help/install-size

	@git-changelog $(BUILDDIR)/DEBIAN/changelog
	@gzip -d $(BUILDDIR)/DEBIAN/changelog.gz

# Create the MD5sums file omitting the DEBIAN directory
	@find $(BUILDDIR)/usr -type f -exec md5sum {} \; > $(BUILDDIR)/DEBIAN/md5sums
	@sed -i "s|$(BUILDDIR)/||" $(BUILDDIR)/DEBIAN/md5sums

	@dpkg-deb --root-owner-group --build $(BUILDDIR) build/$(PACKAGE)_$(VERSION)_$(AARCH).deb

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build and install the ddns application"
	@echo "  debian    - Build the debian package"
	@echo "  clean     - Clean up build files"
	@echo "  help      - Display this help message"

---
title: DH_GITCHANGELOG.CONF
section: 5
header: Configuration File
footer: dh_gitchangelog.conf(5)
date: 2025-04-20
authors:
    - Michael Schaecher
---

# NAME

dpkg-changelog - process Debian changelogs

# SYNOPSIS

`$HOME/.config/dh_gitchangelog.conf`

# DESCRIPTION

Generate changelogs for Debian/Ubuntu packages using **git** commit messages. If more than one commit for a given date then all commits are combined into a single entry.

# CONFIGURATION

## `PACKAGE_NAME`

The name of the package to generate changelogs for. This is used to determine the path to the changelog file.

---

:   default: \$(basename "\$(pwd)")

---

:   example: `PACKAGE_NAME="my-package"`

## `CHANGELOG_FILE`

The path to the main changelog file that will be generated and used for the package.

---

:   default: `debian/changelog`

---

:   example: `CHANGELOG_FILE="debian/changelog"`

## `MAJOR_COUNT`

The number of commits to before a new major version is created. This is used to determine when to create a new major version for the package.

---

:   default: 12

---

:   example: `MAJOR_COUNT=12`

## `MINOR_COUNT`

The number of commits to before a new minor version is created. This is used to determine when to create a new minor version for the package.

---

:   default: 6

---

:   example: `MINOR_COUNT=6`

## `PATCH_COUNT`

The number of commits to before a new patch version is created. This is used to determine when to create a new patch version for the package.

---

:   default: Adds both the major and minor version together.

---

:   example: `PATCH_COUNT=((MAJOR_COUNT + MINOR_COUNT))`

## `DATE_PATCH_COUNT`

Use the number of days-in-year of that commit was made to determine the total commits.

---

:   default: true

---

:   example: `DATE_PATCH_COUNT=true`

# FILES

/etc/default/dpkg-changelog

# COPYRIGHT

Copyright (C) 2025 Michael L. Schaecher

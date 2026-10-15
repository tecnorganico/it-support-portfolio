# Support Scripts

This folder contains simple scripts used for basic system checks and troubleshooting in IT Support environments.
These scripts help collect essential system and network information commonly requested during initial diagnostics.

---

## system-info.sh

Bash script for Linux systems that collects basic system and network information for troubleshooting purposes.

---

## system-info-macos.sh

Script designed for macOS to collect system details commonly used in IT Support diagnostics.

---

## system-info.ps1

PowerShell script for Windows systems that collects basic system information, including:

* Computer name
* Current user
* Operating system version
* System uptime
* IP address
* Disk space

These details are commonly requested during initial IT Support troubleshooting and documentation.

## windows-health-check.ps1

Read-only Windows health inventory script that collects hardware, storage, security, startup, process, and installed-software information. It can display the results or export them to a timestamped text report with `-OutputDirectory`. It does not install, uninstall, stop, disable, or modify anything.

## recover-pdf-from-tmp.ps1

Safe recovery helper that scans a user-selected folder for `.tmp` files whose header is `%PDF-`. It renames only verified PDF files, never overwrites an existing PDF, supports `-WhatIf`, and records each action.

Scripts avoid collecting passwords, tokens, MFA information, or personal files. Review output before sharing a report.

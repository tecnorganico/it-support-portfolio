# PDF Temporary File Recovery

This is an anonymized real-world support scenario. Identifying client information has been removed.

## Problem

A user's browser and cloud workflow occasionally saved valid PDF documents with a `.tmp` extension. The user needed the documents recovered without accidentally renaming unrelated temporary files or overwriting existing work.

## Diagnosis

The extension alone was not reliable evidence of file type. The technician inspected the file signature, also called a magic number. A valid PDF begins with the ASCII header `%PDF-`, so the first five bytes were checked before any rename was considered.

## Actions

* Scanned only a user-selected folder.
* Inspected `.tmp` files without opening them as documents.
* Renamed only files whose header began with `%PDF-`.
* Ignored files that did not match the signature.
* Skipped any destination where the corresponding `.pdf` already existed.
* Used `-WhatIf` first when reviewing an unfamiliar folder.
* Logged every rename, skip, and ignored file.

Example:

```powershell
.\scripts\recover-pdf-from-tmp.ps1 -Folder "C:\Users\User\Downloads" -WhatIf
```

## Validation

The recovered files were opened and checked after the rename. Existing PDFs were preserved, non-PDF temporary files remained unchanged, and the log provided an audit trail of the actions.

## Outcome

The valid PDF documents became usable without broad file renaming or destructive cleanup.

## Lessons Learned

* File extensions are user-facing labels, not proof of file type.
* File signatures provide a safer basis for narrowly scoped recovery automation.
* A dry run, collision check, and action log reduce data-loss risk.
* Recovery work should preserve the original data and validate the result before further cleanup.

# OneDrive User Backup

This guide describes a practical OneDrive configuration for a typical Microsoft 365 home user. It is intended to protect important user folders while keeping local storage understandable.

## Recommended Configuration

Enable Known Folder Backup for:

* Desktop
* Documents
* Pictures

Enable **Files On-Demand** so that files can be listed in File Explorer without requiring every file to be stored locally.

## Files On-Demand Status

* **Online-only:** visible on the device but downloaded when opened.
* **Locally available:** downloaded and available offline, but can be freed if storage management is enabled.
* **Always available:** marked to remain downloaded for offline use.

Explain these states to the user before changing storage settings.

## Office AutoSave

When files are stored in OneDrive, use Office AutoSave where supported. Confirm that the user understands the save location and that synchronization is active.

Do not automatically include the Downloads folder by default. Downloads often contains temporary installers, duplicates, and large files. Include it only after discussing the user's needs and storage impact.

## Verification and Restore Test

1. Confirm that OneDrive reports synchronization is complete.
2. Sign in to OneDrive on the web and verify Desktop, Documents, and Pictures.
3. Restore a test file or use version history on a suitable document.
4. Confirm that the user can identify the online copy and the local copy.
5. Document what is included and what is not included.

OneDrive synchronization is not a substitute for every backup requirement. Keep independent copies or additional protection for critical data where appropriate.

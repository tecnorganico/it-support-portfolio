# Windows 11 Health and Recovery

This is an anonymized real-world support scenario. Identifying client information has been removed.

## Problem

A user reported that a Windows 11 laptop had become slow and requested a general health check. The work also included preparing the device for Microsoft 365 and cloud backup.

## Environment

* Windows 11 laptop
* 16 GB RAM
* NVMe SSD
* Third-party antivirus installed
* Microsoft 365 required
* Cloud backup required

## Diagnosis

The initial inventory used:

```powershell
Get-ComputerInfo
Get-CimInstance Win32_OperatingSystem
Get-PhysicalDisk
Get-Volume
Get-MpComputerStatus
winget list
```

System integrity was then checked with:

```powershell
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
chkdsk C: /scan
```

The component store had corruption. SFC also found corrupted system files. The NVMe SSD reported healthy, and CHKDSK found no filesystem errors or bad sectors.

## Actions

* Repaired the Windows component store with DISM.
* Ran SFC and allowed it to repair corrupted files.
* Ran a non-disruptive CHKDSK scan.
* Removed the third-party antivirus after confirming the intended security configuration.
* Confirmed Microsoft Defender as the primary antivirus.
* Removed unnecessary applications at the user's request. This was a targeted cleanup, not a recommendation to debloat Windows indiscriminately.
* Installed Microsoft 365.
* Configured OneDrive backup for the agreed user folders.

## Verification

The final checks showed:

* No remaining component-store corruption.
* No remaining system integrity violations.
* No filesystem errors or bad sectors reported by the scan.
* SSD health remained OK.
* Microsoft Defender was active.
* Microsoft 365 applications launched successfully.
* OneDrive completed synchronization for the selected folders.

## Outcome

The laptop returned to a stable, supported configuration. The user had Microsoft 365 installed, Microsoft Defender as the primary antivirus, and a verified cloud backup configuration.

## Lessons Learned

* Start with evidence from system inventory instead of assuming that slowness is caused by one application.
* DISM and SFC address different layers of Windows integrity and are complementary.
* Storage health and filesystem integrity should be checked before attributing symptoms to software.
* Application removal should be based on user need and supportability, not indiscriminate debloating.
* Backup configuration is incomplete until synchronization and recovery behavior are verified.

# Windows System Integrity

Use this sequence when Windows shows instability, application errors, or signs of damaged system files. Start with inspection and record results before making repairs.

## Safe Sequence

1. **Inspect the system.** Record the Windows version, uptime, storage, recent symptoms, and relevant changes.
2. **Check disk health.** Review physical disk health and available volume space before interpreting software errors.
3. **Run DISM ScanHealth.**
   ```powershell
   DISM /Online /Cleanup-Image /ScanHealth
   ```
4. **Run DISM RestoreHealth when required.** Use it when ScanHealth reports component-store corruption or when repair is justified by the evidence.
   ```powershell
   DISM /Online /Cleanup-Image /RestoreHealth
   ```
5. **Run SFC.**
   ```powershell
   sfc /scannow
   ```
6. **Run a read-only filesystem scan.**
   ```powershell
   chkdsk C: /scan
   ```
7. **Reboot** when repairs or pending servicing operations require it.
8. **Perform final verification.** Repeat the relevant checks and confirm that the original symptoms and integrity findings have been addressed.

Do not interrupt DISM, SFC, or other repair operations unnecessarily. Progress can pause for a while; stopping a repair abruptly can leave the system in an incomplete state. If a command appears stalled for an unusual period, document the state and investigate safely before forcing a restart.

## What Each Tool Does

### DISM

Deployment Image Servicing and Management checks and repairs the Windows component store. The component store provides the files and packages used by Windows servicing and other repair tools. `ScanHealth` checks for corruption; `RestoreHealth` attempts a repair.

### SFC

System File Checker verifies protected Windows system files and replaces corrupted versions with valid copies. SFC complements DISM; repairing the component store first can give SFC a healthy source for replacements.

### CHKDSK

CHKDSK checks the filesystem structure and, depending on the options used, can repair filesystem errors or scan for bad sectors. `chkdsk C: /scan` is an online scan and is a safer first check than scheduling a disruptive offline repair without evidence.

## Notes

* Save command output in the support record.
* Keep the user informed before repairs and reboots.
* Escalate repeated corruption, storage-health warnings, encryption concerns, or failed repairs.

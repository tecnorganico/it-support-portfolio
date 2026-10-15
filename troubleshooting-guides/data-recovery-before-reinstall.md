# Data Recovery Before Reinstall

Use a data-first workflow when a user cannot access an old Windows installation and wants personal files recovered before formatting. Do not provide or use password-bypass techniques.

## Workflow

1. **Confirm ownership and authorization.** Verify that the requester is authorized to access the device and files.
2. **Check whether the machine boots.** If it does, avoid unnecessary changes and copy data using the existing authorized session.
3. **Check disk health.** Look for storage warnings before relying on the disk for recovery.
4. **Check BitLocker and other encryption.** Identify whether the volume is encrypted.
5. **Recover data only through legitimate authorized methods.** Use the user's authorized account, an approved recovery environment, or an organizational recovery process.
6. **If BitLocker is enabled, require the recovery key.** Without valid authorization and the key, stop and escalate.
7. **Copy files to separate storage.** Do not use the source disk as the only destination.
8. **Verify recovered files.** Open representative documents and compare counts, sizes, or hashes where appropriate.
9. **Only then reinstall Windows.** Confirm the user accepts the consequences of formatting and that recovery is documented.

## Safety Notes

* Do not format, repartition, or run destructive repairs before recovery is complete.
* Preserve the original disk state when the data is important or the disk may be failing.
* Keep personal files private and transfer them only to authorized storage.
* Escalate suspected hardware failure, encryption lockout, or unclear ownership.

# Backup Basics – IT Support Guide

This guide explains basic backup concepts and practices commonly used in IT Support environments.
The goal is to protect user data, reduce data loss, and support recovery in case of incidents.

---

## 🎯 Objectives

* Ensure critical user data is protected
* Reduce risk of data loss
* Support fast recovery after incidents
* Promote good data management practices

---

## 🧠 What Is a Backup?

A backup is a copy of data stored separately from the original source, allowing recovery in case of:

* Hardware failure
* Accidental deletion
* Malware or ransomware
* System corruption

Backups are a core responsibility of IT Support and Security teams.

---

## 🗂️ What Should Be Backed Up?

Common data to back up includes:

* User documents and work files
* Desktop and important folders
* Email data (if applicable)
* Application configuration files

System files may be backed up separately or through system images.

---

## 🔁 Types of Backups

* **Full Backup:** complete copy of all selected data
* **Incremental Backup:** copies only data changed since last backup
* **Differential Backup:** copies data changed since last full backup

Each method balances storage usage, speed, and recovery time.

---

## ☁️ Backup Locations

* Local external drives
* Network storage (NAS)
* Cloud storage solutions

Best practice is to follow the **3-2-1 rule**:

* 3 copies of data
* 2 different storage types
* 1 off-site copy

---

## 🔐 Security and Access

* Encrypt backup data when possible
* Restrict access to authorized users
* Protect backup credentials
* Regularly test backup restoration

A backup that cannot be restored is not a real backup.

---

## 🧑‍💻 User Education

IT Support should:

* Explain the importance of backups to users
* Clarify what is backed up and what is not
* Provide guidance on saving files in correct locations

User awareness reduces data loss incidents.

---

## 📝 Documentation Notes

Always document:

* Backup method and location
* Backup schedule
* Data included
* Test restoration results

Clear documentation supports audits and incident response.

---

## 🧩 When to Escalate

Escalate if:

* Backup failures are recurring
* Storage capacity is insufficient
* Security risks are identified
* Data restoration is unsuccessful

Timely escalation prevents larger incidents.

## OneDrive User Backup

For a practical Microsoft 365 home-user configuration, see [OneDrive User Backup](onedrive-user-backup.md). It covers Known Folder Backup, Files On-Demand, AutoSave, synchronization checks, and restore testing.

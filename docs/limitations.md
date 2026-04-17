# Limitations

This document outlines current limitations of the workflow.

---

## ⚙️ System Constraints

- Requires administrator privileges to execute scripts
- Script execution may be restricted by system policies (ExecutionPolicy)
- Depends on Windows environment (not cross-platform)

---

## 🔧 Hardware Constraints

- Some devices may not provide valid BIOS serial numbers
- MAC-based fallback depends on active network interfaces
- Different hardware vendors may return inconsistent data

---

## 💽 Deployment Constraints

- Requires a preconfigured Clonezilla environment
- GRUB configuration must be maintained manually
- No dynamic image detection (static menu entries)

---

## 📊 Logging Constraints

- Logs are stored locally on each machine (`C:\Logs`)
- No centralized log collection
- No remote monitoring or alerting

---

## 🌐 Infrastructure Constraints

- No network-based deployment (PXE) implemented yet
- No centralized image repository management

---

## 🧠 Notes

These limitations are expected in standalone deployment environments and are part of the planned future improvements.
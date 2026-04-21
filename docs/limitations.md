# Limitations

This document outlines current limitations of the workflow.

---

## ⚙️ System Constraints

- Requires administrator privileges to execute scripts
- Script execution may be restricted by system policies (ExecutionPolicy)
- Depends on Windows environment (not cross-platform)

---

## 🔧 Hardware Constraints

- Hardware-independent hostname generation reduces dependency on device-specific identifiers
- However, generated hostnames are not human-identifiable (random-based)
- No built-in mapping between hostname and physical device

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

These limitations are typical for standalone and offline deployment environments.

Some of them are intentionally accepted trade-offs to ensure reliability, simplicity and independence from external infrastructure.

Future improvements will focus on centralization, scalability and integration with asset management systems.
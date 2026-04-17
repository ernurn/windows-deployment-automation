# Naming Convention

## Overview

This project implements an automatic naming system to assign unique hostnames after deployment.

The goal is to ensure consistency, avoid conflicts and eliminate manual configuration.

---

## 🖥 Hostname Format

PC-XXXXX

Where:

- `PC` → device prefix
- `XXXXX` → unique identifier

---

## 🔍 Naming Logic

The identifier is generated automatically using the following priority:

1. **BIOS Serial Number (preferred)**
2. **MAC Address (fallback)**

### Process:

- Validate BIOS serial number
- If invalid → retrieve MAC address
- Extract last characters as unique ID
- Generate hostname

---

## Example

PC-A1B2C3

---

## Benefits

- Avoid duplicate hostnames
- Ensure uniqueness in network environments
- Fully automated process
- No technician intervention required
- Consistent naming across all deployments

---

## ⚙️ Implementation Notes

- Executed during post-deployment phase
- Integrated into the post-clone PowerShell script
- Works across different hardware vendors
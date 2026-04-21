# Naming Convention

## Overview

This project implements an automatic hostname generation system to ensure unique device identification after deployment.

The approach is designed to be reliable in offline environments and independent from hardware-specific attributes such as BIOS serial numbers or MAC addresses.

---

## 🖥 Hostname Format

PC-XXXXXXXX

Where:

- PC → device prefix
- XXXXXXXX → randomly generated unique identifier (8 characters)

---

## 🔍 Naming Logic

The hostname is generated automatically using a random unique ID.

### Process:

1. Generate a random identifier using a GUID-based method
2. Extract 8 characters from the generated value
3. Convert to uppercase
4. Assign hostname using the defined prefix

Example:

PC-A3F91C2D

---

## ✅ Benefits

- Avoid duplicate hostnames
- Fully hardware-independent
- Works in offline environments
- No dependency on BIOS or network interfaces
- Eliminates issues with invalid or duplicated serial numbers
- Prevents conflicts caused by virtual network adapters
- Fully automated process
- No technician intervention required
- Consistent naming across all deployments

---

## ⚙️ Implementation Notes

- Executed during post-deployment phase
- Integrated into the post-clone PowerShell script
- Uses GUID-based random generation
- Designed for large-scale deployment scenarios
- Suitable for heterogeneous hardware environments
# Architecture

## Overview

This document describes the architecture of the **Windows Deployment Automation** workflow.

The system is designed as a **modular, offline-capable deployment pipeline**, focused on reliability, consistency and minimal human intervention.

---

## 🧠 High-Level Architecture

```
        ┌────────────────────────────┐
        │   Preparation Stage        │
        │ (PowerShell Script)        │
        │                            │
        │ - System cleanup           │
        │ - Optimization             │
        │ - Log generation           │
        └─────────────┬──────────────┘
                      │
                      ▼
        ┌────────────────────────────┐
        │     Image Capture          │
        │     (Clonezilla)           │
        │                            │
        │ - Disk imaging             │
        │ - Image storage            │
        └─────────────┬──────────────┘
                      │
                      ▼
        ┌────────────────────────────┐
        │     Deployment Stage       │
        │        (GRUB)              │
        │                            │
        │ - Boot menu                │
        │ - Image selection          │
        │ - Automated restore        │
        └─────────────┬──────────────┘
                      │
                      ▼
        ┌────────────────────────────┐
        │   Post-Deployment Stage    │
        │   (PowerShell Script)      │
        │                            │
        │ - Random hostname          │
        │ - Final configuration      │
        │ - Logging                  │
        └─────────────┬──────────────┘
                      │
                      ▼
        ┌────────────────────────────┐
        │        Ready State         │
        │                            │
        │ - System deployed          │
        │ - Unique identity          │
        │ - Ready for delivery       │
        └────────────────────────────┘
```

---

## 🔧 Components

### 1. Preparation Script
- Cleans and optimizes Windows before imaging
- Removes unnecessary files and applications
- Applies system-level optimizations
- Generates structured logs

---

### 2. Clonezilla
- Responsible for disk imaging and restoration
- Ensures fast and reliable cloning process
- Works independently of the operating system

---

### 3. GRUB Bootloader
- Provides deployment interface
- Allows selection of images
- Automates boot into Clonezilla environment

---

### 4. Post-Clone Script
- Executes after deployment
- Generates a unique hostname using random ID
- Applies final system configuration
- Stores execution logs in C:\Logs

---

## 🔁 Data Flow

Preparation Script → Image → Clonezilla → GRUB → Target Machine → Post-Clone Script → Final System

---

## 🧩 Design Principles

### ✔ Hardware Independence
- No reliance on BIOS serial or MAC address
- Works across heterogeneous devices

### ✔ Offline Capability
- No network required during deployment
- Fully functional in isolated environments

### ✔ Automation First
- No manual intervention required
- Predictable and repeatable workflow

### ✔ Observability
- Logging at all stages
- Traceability for troubleshooting

### ✔ Simplicity
- Minimal dependencies
- Easy to maintain and extend

---

## ⚖️ Trade-offs

- Random hostnames are not human-readable
- No centralized control or orchestration
- GRUB configuration is static (manual updates required)

---

## 🚀 Future Evolution

- Network-based deployment (PXE)
- Centralized logging system
- Asset management integration
- Dynamic image orchestration
- Multi-environment deployment profiles

---

## 🧠 Summary

This system is not just a set of scripts, but a structured deployment pipeline designed for:

- Real-world IT operations
- High-volume environments
- Reliable and repeatable system provisioning

It prioritizes robustness, simplicity and scalability over unnecessary complexity.
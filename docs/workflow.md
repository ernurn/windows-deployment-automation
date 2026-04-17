# Workflow

## Overview

This document describes the automated workflow for Windows deployment using Clonezilla, GRUB and PowerShell scripts.

---

## Deployment Process

1. **Preparation**
   - Run the preparation script
   - Clean and optimize the system
   - Remove unnecessary applications
   - Generate execution logs

2. **Capture**
   - Capture the image using Clonezilla
   - Store it in the repository

3. **Deployment**
   - Boot using GRUB
   - Select deployment mode
   - Restore image automatically

4. **Post-Deployment**
   - Run post-clone script
   - Assign hostname (Serial → MAC fallback)
   - Apply final configuration
   - Generate execution logs

5. **Ready**
   - System is fully configured
   - Ready for delivery or use

---

## Key Characteristics

- Fully automated workflow
- No manual interaction required
- Consistent deployment process
- Logging at all stages
- Scalable for multiple machines

---

## Goal

- Reduce manual configuration
- Ensure consistency across devices
- Speed up deployment process
- Improve traceability and reliability
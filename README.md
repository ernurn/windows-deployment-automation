# Windows Deployment Automation

Automated workflow for preparing, optimizing and deploying Windows images using Clonezilla, PowerShell and GRUB.

---

## 👨‍💻 Author

**Ernesto Nurnberg**  
IT Infrastructure & Technical Support Specialist  
Founder of ITechBR  

---

## 🚀 Overview

This project provides a complete automation workflow for Windows deployment in real-world IT environments.

It is designed to streamline:
- System preparation
- Disk imaging
- Mass deployment
- Post-deployment configuration

---

## 🛠 Technologies Used

- PowerShell
- Batch scripting
- Clonezilla
- GRUB
- Windows 10 / 11

---

## ⚙️ Features

### 🧼 Image Preparation
- System cleanup (temp files, logs)
- Windows Update cache cleanup
- DISM optimization
- Automated Disk Cleanup (cleanmgr)
- Removal of unnecessary applications
- CompactOS optimization
- Fast Startup and hibernation disabled

---

### 💽 Deployment (Clonezilla + GRUB)
- Automated boot entries via GRUB
- Preconfigured deployment modes
- Unattended disk restore
- Repository-based image selection

---

### 🔧 Post-Deployment Automation
- Automatic hostname assignment (Serial → MAC fallback)

---

## 🔁 Workflow

1. Prepare Windows image (prep script)
2. Capture image using Clonezilla
3. Deploy image via GRUB
4. Run post-clone automation
5. System ready for delivery

---

## 📚 Documentation

Detailed documentation is available in the [docs](./docs) directory.

---



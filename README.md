# 🚀 Windows Deployment Automation

![PowerShell](https://img.shields.io/badge/PowerShell-Automation-blue)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-blue)
![Status](https://img.shields.io/badge/Status-Active-success)
![License](https://img.shields.io/badge/License-MIT-green)

Automated workflow for preparing, optimizing and deploying Windows images using Clonezilla, PowerShell and GRUB.

---

## 👨‍💻 Author

**Ernesto Nurnberg**  
IT Infrastructure & Technical Support Specialist  
Founder of ITechBR  

---

## 🚀 Overview

This project provides a **real-world automation workflow** for Windows deployment.

Designed to:
- Reduce manual setup time
- Ensure system consistency
- Standardize deployment processes
- Improve efficiency in IT environments

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
- Structured logging with timestamps

---

### 💽 Deployment (Clonezilla + GRUB)
- Automated boot entries via GRUB
- Preconfigured deployment modes
- Unattended disk restore
- Repository-based image selection

---

### 🔧 Post-Deployment Automation
- Automatic hostname assignment (Serial → MAC fallback)
- Standardized naming format (PC-XXXXX)
- Fully unattended execution
- Execution logging for traceability

---

## 🧾 Logging

A unified logging system is implemented across the workflow.

- Logs are stored in: `C:\Logs`
- Files are generated using timestamps
- Separate logs for preparation and post-deployment

Example:
```text
C:\Logs
├── 20260416_103000_prep.log
├── 20260416_104500_post.log
```

This enables:
- Full execution traceability
- Easier troubleshooting
- Historical tracking of deployments

---
## 🔁 Workflow

```text
Prepare → Capture → Deploy → Rename → Ready
```

```text
1. Prepare Windows image (prep script)
2. Capture image using Clonezilla
3. Deploy image via GRUB
4. Run post-clone automation
5. System ready for delivery
```

---

## 🏭 Production Ready

This workflow is designed for real-world IT environments:

- No manual interaction required
- Consistent execution across multiple machines
- Structured logging for observability
- Scalable deployment approach

---

## 📂 Project Structure

```
windows-deployment-automation/
│
├── README.md
├── LICENSE
│
├── scripts/
│   ├── executar_post_clone.bat
│   ├── executar_preparacao.bat
│   ├── post_clone.ps1
│   └── prep_imagem_win.ps1
│
├── grub/
│   └── grub.cfg
│
└── docs/
    ├── future-improvements.md
    ├── limitations.md
    ├── naming-convention.md
    ├── use-cases.md
    └── workflow.md
```

---

## 📌 Use Cases

- RMA (Repair workflows)
- Mass system deployment
- IT service environments
- Device standardization

---

## 📚 Documentation

Detailed documentation is available in the [docs](./docs) directory.

---

## ⚠️ Requirements

- Administrator privileges
- Basic knowledge of disk imaging
- Clonezilla environment configured

---

## 🧠 Key Highlights

- Real-world implementation (not theoretical)
- Automated and scalable workflow
- Designed for IT technicians and infrastructure teams
- Focused on efficiency, reliability and traceability

---

## 📈 Future Improvements

- Dynamic GRUB menu generation
- Network-based deployment
- Asset management integration

---

## 📄 License

MIT License

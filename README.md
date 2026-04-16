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
- Focused on efficiency and reliability

---

## 📈 Future Improvements

- Dynamic GRUB menu generation
- Network-based deployment
- Logging system
- Asset management integration

---

## 📄 License

MIT License

# 🧮 CRC32 Checksum Right-Click Tool for Windows

Easily calculate the CRC32 checksum of any file directly from the Windows Explorer context menu. The result is appended to the end of the selected file's name. Supports multi-file selection.

---

## ✅ Features

* **One-click CRC32 calculation** via the Windows right-click menu  
* **Automatically appends** the calculated checksum to the filename  

---

## 🔧 Setup Instructions

### 1. Install the script

* `git clone` the repo.
* Run `install-context-menu.bat`. Ensure the folder and its files are in their final location. The script uses its current path to register the context menu.

---

## ▶️ How to Use

1. Right-click on any file(s) in File Explorer.  
2. Click **Add CRC32 to Filename**.  
3. The checksum will be **automatically appended** to the end of each selected file's name.

---

## 📎 Tips

* Use this tool for verifying file integrity, comparing against known hashes, or quick checksum generation.
* For batch processing or alternative hash types (e.g., MD5, SHA256), the script can be extended easily.

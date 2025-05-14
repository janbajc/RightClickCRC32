# 🧮 CRC32 Checksum Right-Click Tool for Windows

Easily calculate the CRC32 checksum of any file directly from the Windows Explorer context menu. The result is instantly copied to your clipboard and shown in a message box.

---

## ✅ Features

* **One-click CRC32 calculation** via the Windows right-click menu
* **Automatic clipboard copy** of the calculated checksum
* **Popup message box** displaying the result
* **Lightweight PowerShell script** — no installation required

---

## 🔧 Setup Instructions

### 1. Download the Script

* Save the following PowerShell script as `calcCRC32.ps1` to a permanent location, e.g.,
  `C:\Scripts\calcCRC32.ps1`

---

### 2. Add to Windows Context Menu

#### 🔹 Open Registry Editor

* Press `Windows + R`, type `regedit`, and press `Enter`.

#### 🔹 Create Registry Keys

Navigate to:

```
HKEY_CLASSES_ROOT\*\shell
```

Create the following keys:

1. **Key**: `Copy CRC32`

   * **(Default)**: `Copy CRC32`

2. **Subkey**: `Copy CRC32\command`

   * **(Default)**:

     ```powershell
     powershell.exe -ExecutionPolicy Bypass -File "C:\Scripts\calcCRC32.ps1" "%1"
     ```

> ⚠️ **Important**: Replace the path above with the full path to your saved `calcCRC32.ps1`.

---

## ▶️ How to Use

1. Right-click on any file in File Explorer.
2. Click **Copy CRC32**.
3. A message box will display the CRC32 checksum.
4. The checksum will be **automatically copied to your clipboard**.

---

## 📎 Tips

* You can use this for verifying file integrity, comparing against known hashes, or quick checksum generation.
* For batch file support or alternate hash types (e.g., MD5, SHA256), the script can be extended easily.

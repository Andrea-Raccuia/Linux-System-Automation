# Linux System Automation Suite 🐧

This repository consists of a modular suite of Bash scripts designed for system monitoring, automated backups, and batch file management.

The project demonstrates a transition from high-level programming logic (C++) to low-level system automation and shell scripting.

## 🚀 Overview

The suite is centered around a main controller (`sysutil.sh`) that integrates specialized modules through **sourcing** and **process management**.

### 🛠️ Core Components

| Script | Responsibility | Key Features |
| :--- | :--- | :--- |
| **sysutil.sh** | Main Command Center | Interactive menu, `trap` for SIGINT, Modular sourcing. |
| **monitor.sh** | Health Diagnostics | Real-time CPU/RAM/Disk parsing using `awk` and `ps`. |
| **backhup.sh** | Data Preservation | `tar` compression with automated timestamping and path validation. |
| **rename.sh** | Batch Processing | Safety-first renaming with **Dry-Run** simulation and array handling. |

## 🧠 Technical Features

### 1. Robustness & Error Handling
Every script is built with a "fail-safe" mindset:
- **Input Validation**: Checks if directories exist before execution.
- **Safety Confirmation**: `rename.sh` asks for explicit user confirmation after showing a simulation of changes.
- **Signal Handling**: `sysutil.sh` uses `trap cleanup SIGINT` to ensure a graceful exit when pressing `Ctrl+C`.

### 2. Modular Architecture
Instead of one large, unmanageable file, the project uses **Sourcing**. 
`sysutil.sh` imports functions from `monitor.sh` dynamically, allowing for cleaner code and better maintenance—a principle carried over from my experience with C++ headers.

### 3. Professional Reporting
The **Report Generation** feature (added in Day 4) aggregates data from all modules into a timestamped `report_sistema.txt`, providing a snapshot of system health for administrative audits.

## 💻 Installation & Usage

1. Clone the repository:
   ```bash
   git clone [https://github.com/Andrea-Raccuia/Linux-System-Automation.git](https://github.com/Andrea-Raccuia/Linux-System-Automation.git)
2. Grant execution permissions:
   ```bash
   chmod +x *.sh
3. Launch the Utility:
   ./sysutil.sh

Before running the scripts, ensure you have the following installed:
- `bash` (v4.0 or higher)
- `tar` (for backup operations)
- `bc` (required for floating-point math in CPU monitoring)
- `awk` (standard utility for data parsing)

## 🛡️ Technical Insights & Best Practices

### Signal Handling (`trap`)
The main script implements a `cleanup` function triggered by the **SIGINT** signal (Ctrl+C). This prevents the terminal from hanging and ensures a clean exit, demonstrating professional process management.

### Modular Design (`source`)
Following the DRY (Don't Repeat Yourself) principle, `sysutil.sh` does not duplicate code. It uses the `source` command to import diagnostics from `monitor.sh`, allowing for a modular architecture that is easier to debug and scale.

### Safety-First File Management
The `rename.sh` module is designed with a **Dry-Run** first approach. It generates a preview of all changes and requires explicit user confirmation before executing any `mv` commands, mimicking professional deployment workflows.

# 🌟 Phoronix Test Suite Automation 🌟

Welcome to the Phoronix Test Suite Automation project! This project automates the setup and execution of the Phoronix Test Suite (PTS) for benchmarking. It includes a Makefile with various targets to streamline the process of installing prerequisites, configuring test runs, saving configurations, running tests, and cleaning up results.

## 🚀 Getting Started

Follow the instructions below to set up and use the automation scripts. Detailed explanation available in [documentation](https://github.com/SelamHemanth/pts-automation-tool/blob/main/documentation) file.

### Prerequisites

Ensure you have `make` installed on your system. The Makefile will handle the rest of the dependencies based on your Linux distribution.

## 🛠️ Example Workflow

* Install Prerequisites:
```sh
make install
```

* Configure Test Runs:
```sh
make menuconfig
```

* Save Configuration:
```sh
make saveconfig
```

* Run Tests:
```sh
make run
```
* Show Results:
```sh
make showresult
```

* Save Results:
```sh
make saveresult
```

* Clean Up:
```sh
make clean
```
* Deep clean up:
```sh
make deepclean
```

## 👤 Author
### Name: `Hemanth Selam`
### Email: `Hemanth.Selam@amd.com`

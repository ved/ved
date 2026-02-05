# VM Health Check Script

## Overview
This repository contains a shell script that analyzes the health of a virtual machine (VM) based on CPU, Memory, and Disk space utilization.

## Files
- `vm_health_check.sh` - Main health check script
- `issues.py` - Python script for issue tracking analysis

## VM Health Check Script

### Description
The `vm_health_check.sh` script monitors three key metrics:
- **CPU Utilization**: Percentage of CPU being used
- **Memory Utilization**: Percentage of RAM being used
- **Disk Space Utilization**: Percentage of root partition (/) being used

### Health Status Determination
- **HEALTHY**: All three metrics are less than 60% utilized
- **UNHEALTHY**: Any one or more metrics are at or above 60% utilized

### Usage

#### Basic Usage
Run the script without arguments to get a simple health status:
```bash
./vm_health_check.sh
```

Output:
```
HEALTHY
```
or
```
UNHEALTHY
```

#### Detailed Usage with Explanation
Pass the `explain` argument to get detailed information about each metric:
```bash
./vm_health_check.sh explain
```

Output example:
```
VM Health Status: HEALTHY

Detailed Analysis:
==================
CPU Usage: 5%
  Status: OK (below 60% threshold)

Memory Usage: 12%
  Status: OK (below 60% threshold)

Disk Usage: 37%
  Status: OK (below 60% threshold)

Overall: VM is HEALTHY because 
all metrics (CPU, Memory, Disk) are below 60% utilization.
```

### Requirements
- Ubuntu Linux (or compatible Linux distribution)
- Standard Unix utilities: `top`, `free`, `df`, `awk`, `sed`

### Permissions
Make sure the script has executable permissions:
```bash
chmod +x vm_health_check.sh
```

## Target Platform
This script is designed for Ubuntu virtual machines but should work on most Linux distributions with standard utilities installed.

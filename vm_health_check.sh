#!/bin/bash

# VM Health Check Script
# Analyzes VM health based on CPU, Memory and Disk utilization
# If all three metrics are less than 60% utilized: HEALTHY
# If any metric is 60% or more utilized: UNHEALTHY

# Function to get CPU utilization percentage
get_cpu_usage() {
    # Get CPU usage using top command (idle percentage)
    # We calculate used = 100 - idle
    local cpu_idle=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int($1)}')
    local cpu_used=$((100 - cpu_idle))
    echo $cpu_used
}

# Function to get Memory utilization percentage
get_memory_usage() {
    # Get memory usage percentage using free command
    local mem_usage=$(free | grep Mem | awk '{printf "%.0f", ($3/$2) * 100}')
    echo $mem_usage
}

# Function to get Disk utilization percentage
get_disk_usage() {
    # Get disk usage for root partition
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo $disk_usage
}

# Main health check logic
main() {
    local explain_mode=false
    
    # Check if "explain" argument is passed
    if [ "$1" == "explain" ]; then
        explain_mode=true
    fi
    
    # Get utilization metrics
    cpu_usage=$(get_cpu_usage)
    memory_usage=$(get_memory_usage)
    disk_usage=$(get_disk_usage)
    
    # Determine health status
    # HEALTHY if all three are less than 60%
    # UNHEALTHY if any one is 60% or more
    if [ $cpu_usage -lt 60 ] && [ $memory_usage -lt 60 ] && [ $disk_usage -lt 60 ]; then
        health_status="HEALTHY"
    else
        health_status="UNHEALTHY"
    fi
    
    # Output based on mode
    if [ "$explain_mode" = true ]; then
        echo "VM Health Status: $health_status"
        echo ""
        echo "Detailed Analysis:"
        echo "=================="
        echo "CPU Usage: ${cpu_usage}%"
        if [ $cpu_usage -lt 60 ]; then
            echo "  Status: OK (below 60% threshold)"
        else
            echo "  Status: WARNING (at or above 60% threshold)"
        fi
        echo ""
        echo "Memory Usage: ${memory_usage}%"
        if [ $memory_usage -lt 60 ]; then
            echo "  Status: OK (below 60% threshold)"
        else
            echo "  Status: WARNING (at or above 60% threshold)"
        fi
        echo ""
        echo "Disk Usage: ${disk_usage}%"
        if [ $disk_usage -lt 60 ]; then
            echo "  Status: OK (below 60% threshold)"
        else
            echo "  Status: WARNING (at or above 60% threshold)"
        fi
        echo ""
        echo "Overall: VM is $health_status because "
        if [ "$health_status" == "HEALTHY" ]; then
            echo "all metrics (CPU, Memory, Disk) are below 60% utilization."
        else
            echo "one or more metrics (CPU, Memory, Disk) are at or above 60% utilization."
        fi
    else
        echo "$health_status"
    fi
}

# Execute main function with all arguments
main "$@"

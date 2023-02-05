#!/bin/bash

# Set performance mode to cpu from 0 to 39

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

CPU_COUNT=39

for cpu_n in $(seq 0 $(($CPU_COUNT-1))); do
    echo $cpu_n
    echo performance > "/sys/devices/system/cpu/cpu$cpu_n/cpufreq/scaling_governor"
done

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
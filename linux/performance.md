# Performance

```shell script
# Show performance mode for cpu0
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Show performance mode for all cpus
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set performance mode for cpu0
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```

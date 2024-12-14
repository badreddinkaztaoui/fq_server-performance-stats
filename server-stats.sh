#!/bin/bash

BLUE='\033[1;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY_USAGE=$(free -m | grep Mem | awk '{print $3, $4, $3/$2*100}')
DISK_USAGE=$(df -h --total | grep total | awk '{print $3, $4, $5}')
CPU_PROCESSES=$(ps aux --sort=-%cpu | head -n 6 | awk '{printf "%-8s %-8s %-8s %-8s %s\n", $1, $2, $3, $4, $11}')
MEMORY_PROCESSES=$(ps aux --sort=-%mem | head -n 6 | awk '{printf "%-8s %-8s %-8s %-8s %s\n", $1, $2, $4, $3, $11}')


echo -e "${BLUE}SERVER PERFORMANCE STATS${NC}"

echo -e "${GREEN}CPU Usage: ${YELLOW}$CPU_USAGE%${NC}"
read -r USED FREE PERCENT <<< $MEMORY_USAGE
echo -e "${GREEN}Memory Usage: ${YELLOW}${USED}MB used, ${FREE}MB free, $PERCENT%${NC}"
read -r USED FREE PERCENT <<< $DISK_USAGE
echo -e "${GREEN}Disk Usage: ${YELLOW}$USED used, $FREE free, $PERCENT${NC}"
echo -e "${GREEN}Top 5 CPU Processes:${NC}"
echo -e "${CPU_PROCESSES}"
echo -e "${GREEN}Top 5 Memory Processes:${NC}"
echo -e "${MEMORY_PROCESSES}"

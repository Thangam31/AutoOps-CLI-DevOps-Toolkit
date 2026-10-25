cd ~/autoops-cli

cat << 'EOF' > autoops.sh
#!/bin/bash

# =================================================================
# AutoOps CLI — DevOps System Diagnostics & Operations Toolkit
# =================================================================

COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_RESET="\033[0m"

function show_help() {
    echo -e "${COLOR_BLUE}Usage: ./autoops.sh [command]${COLOR_RESET}"
    echo ""
    echo "Available Commands:"
    echo -e "  ${COLOR_GREEN}sysinfo${COLOR_RESET}   - Displays OS, Hostname, CPU, RAM and Disk summary"
    echo -e "  ${COLOR_GREEN}logs${COLOR_RESET}      - Scans /var/log/syslog for recent ERROR and WARNING entries"
    echo -e "  ${COLOR_GREEN}process${COLOR_RESET}   - Lists top memory and CPU consuming processes"
    echo -e "  ${COLOR_GREEN}help${COLOR_RESET}      - Displays this help menu"
}

function get_sysinfo() {
    echo -e "${COLOR_BLUE}=====================================================${COLOR_RESET}"
    echo -e "${COLOR_BLUE}               AUTOOPS SYSTEM DIAGNOSTICS${COLOR_RESET}"
    echo -e "${COLOR_BLUE}=====================================================${COLOR_RESET}"
    echo -e "Hostname      : $(hostname)"
    echo -e "OS Version    : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
    echo -e "Kernel        : $(uname -r)"
    echo -e "Uptime        : $(uptime -p)"
    echo -e "CPU Cores     : $(nproc)"
    echo -e "Memory Usage  : $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    echo -e "Disk Usage    : $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo -e "${COLOR_BLUE}=====================================================${COLOR_RESET}"
}

function parse_logs() {
    echo -e "${COLOR_YELLOW}[*] Scanning system logs for Errors & Warnings...${COLOR_RESET}"
    LOG_FILE="/var/log/syslog"
    
    if [ ! -f "$LOG_FILE" ]; then
        LOG_FILE="/var/log/dpkg.log"
    fi

    echo -e "\n${COLOR_RED}--- Top 5 Recent Errors ---${COLOR_RESET}"
    grep -i "error" "$LOG_FILE" 2>/dev/null | tail -n 5 || echo "No recent errors found."

    echo -e "\n${COLOR_YELLOW}--- Top 5 Recent Warnings ---${COLOR_RESET}"
    grep -i "warn" "$LOG_FILE" 2>/dev/null | tail -n 5 || echo "No recent warnings found."
}

function get_processes() {
    echo -e "${COLOR_GREEN}[*] Top 5 Memory Consuming Processes:${COLOR_RESET}"
    ps aux --sort=-%mem | awk 'NR==1 || NR<=6 {printf "%-10s %-8s %-8s %-8s %s\n", $1, $2, $3, $4, $11}'

    echo -e "\n${COLOR_GREEN}[*] Top 5 CPU Consuming Processes:${COLOR_RESET}"
    ps aux --sort=-%cpu | awk 'NR==1 || NR<=6 {printf "%-10s %-8s %-8s %-8s %s\n", $1, $2, $3, $4, $11}'
}

# CLI Argument Switcher
case "$1" in
    sysinfo)
        get_sysinfo
        ;;
    logs)
        parse_logs
        ;;
    process)
        get_processes
        ;;
    help|*)
        show_help
        ;;
esac
EOF

chmod +x autoops.sh

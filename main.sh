#!/usr/bin/env bash
# =====================================================
# REON DEV - SocketXP Manager
# Version: 1.0.0
# =====================================================

set -Eeuo pipefail

LOG_FILE="/var/log/reon-socketxp.log"

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;36m"
NC="\033[0m"

log() {
    echo "[$(date '+%F %T')] $*" | tee -a "$LOG_FILE"
}

banner() {
    clear
    echo -e "${BLUE}"
    cat << "EOF"

██████╗ ███████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔════╝██╔═══██╗████╗  ██║
██████╔╝█████╗  ██║   ██║██╔██╗ ██║
██╔══██╗██╔══╝  ██║   ██║██║╚██╗██║
██║  ██║███████╗╚██████╔╝██║ ╚████║
╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝

        SocketXP Manager
          Made by REON DEV

EOF
    echo -e "${NC}"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}Please run as root.${NC}"
        exit 1
    fi
}

detect_os() {
    if [[ -f /etc/debian_version ]]; then
        PKG="apt"
    elif [[ -f /etc/redhat-release ]]; then
        PKG="yum"
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
}

install_dependencies() {
    log "Installing dependencies"
    if [[ "$PKG" == "apt" ]]; then
        apt update
        apt install -y curl wget unzip
    else
        yum install -y curl wget unzip
    fi
}

install_socketxp() {
    echo -e "${GREEN}Installing SocketXP...${NC}"

    # --------------------------------------------------
    # REPLACE THIS SECTION WITH THE OFFICIAL SOCKETXP
    # INSTALL COMMAND FROM THEIR DOCUMENTATION.
    # --------------------------------------------------
    echo "Insert official SocketXP install commands here."
    # Example:
    # curl -fsSL <official-url> | bash
    # --------------------------------------------------

    log "SocketXP installation attempted"
}

start_service() {
    systemctl start socketxp || echo "Service not found."
}

stop_service() {
    systemctl stop socketxp || echo "Service not found."
}

restart_service() {
    systemctl restart socketxp || echo "Service not found."
}

status_service() {
    systemctl status socketxp --no-pager || true
}

uninstall_socketxp() {
    echo -e "${YELLOW}Uninstall placeholder.${NC}"
    # Add official uninstall commands here.
}

menu() {
    while true; do
        banner
        cat << EOF
1) Install SocketXP
2) Start Service
3) Stop Service
4) Restart Service
5) Service Status
6) Uninstall
7) Exit

EOF
        read -rp "Select an option: " opt

        case "$opt" in
            1) install_socketxp ;;
            2) start_service ;;
            3) stop_service ;;
            4) restart_service ;;
            5) status_service ;;
            6) uninstall_socketxp ;;
            7) exit 0 ;;
            *) echo "Invalid option." ;;
        esac

        echo
        read -rp "Press Enter to continue..."
    done
}

main() {
    check_root
    detect_os
    install_dependencies
    menu
}

main

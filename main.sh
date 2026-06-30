#!/usr/bin/env bash

clear

GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

banner() {
clear
echo -e "${CYAN}"
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

install_socketxp() {
echo -e "${GREEN}Installing SocketXP...${NC}"

curl -fsSL https://portal.socketxp.com/download/linux/amd64/socketxp \
-o /usr/local/bin/socketxp

chmod +x /usr/local/bin/socketxp

echo
read -p "Enter SocketXP Auth Token: " TOKEN
socketxp login "$TOKEN"

echo
echo -e "${GREEN}Installation Complete!${NC}"
read -n1 -r -p "Press any key to continue..."
}

start_tunnel() {
read -p "Enter Local Port: " PORT
socketxp tcp --ports "$PORT"
}

uninstall_socketxp() {
rm -f /usr/local/bin/socketxp
rm -f /etc/systemd/system/socketxp.service
systemctl daemon-reload

echo "SocketXP removed."
read -n1 -r -p "Press any key..."
}

while true; do
banner

echo "1) Install SocketXP"
echo "2) Start TCP Tunnel"
echo "3) Uninstall SocketXP"
echo "4) Exit"
echo
read -p "Select an option: " OPTION

case $OPTION in
1)
install_socketxp
;;
2)
start_tunnel
;;
3)
uninstall_socketxp
;;
4)
exit
;;
*)
echo "Invalid option."
sleep 1
;;
esac

done

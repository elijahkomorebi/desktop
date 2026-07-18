GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[1;0m"

THEME="$1"
THEME_DIR="$HOME/.config/desktop/$THEME"

if [ -z "$THEME" ]; then
    echo -e "${YELLOW}Usage: $0 <theme-name>${RESET}"
    exit 1
fi

if [ ! -d "$THEME_DIR" ]; then
    echo -e "${YELLOW}Theme '$THEME' does not exist"
    exit 1
fi

echo -e "${CYAN}Applying theme: ${RESET}${GREEN}$THEME${RESET}"
export THEME="$THEME"
echo $THEME > .current_theme

echo -e "${CYAN}Updating nvim configuration...${RESET}"
cp "$THEME_DIR/nvim/theme.lua" "$HOME/.config/nvim/lua"

echo -e "${CYAN}Updaing awww wallpaper...${RESET}"
awww img "$THEME_DIR/wallpaper.png" --transition-type wave --transition-fps 240

echo -e "${CYAN}Updating hypr configuration...${RESET}"
cp "$THEME_DIR/hypr/theme.lua" "$HOME/.config/hypr/config"
hyprctl reload

echo -e "${CYAN}Updaing kitty configuration...${RESET}"
cp "$THEME_DIR/kitty/theme.conf" "$HOME/.config/kitty"

echo -e "${CYAN}Updaing rofi configuration...${RESET}"
cp "$THEME_DIR/rofi/theme.rasi" "$HOME/.config/rofi"

exit 0

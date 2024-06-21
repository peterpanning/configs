#!/bin/bash

# Function to install Homebrew (brew)
install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

configure_homebrew() {
    local zprofile="$HOME/.zprofile"
    local brew_shellenv_command='eval "$(/opt/homebrew/bin/brew shellenv)"'

    # Check if brew shellenv command is already in zprofile
    if ! grep -qF "$brew_shellenv_command" "$zprofile"; then
        echo "Adding Homebrew configuration to $zprofile"
        echo >> "$zprofile"
        echo '# Configure Homebrew in current shell' >> "$zprofile"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$zprofile"
    else
        echo "Homebrew is already configured in $zprofile"
    fi

    # Run the brew shellenv command in current shell session
    eval "$brew_shellenv_command"
}

install_meslo_font() {
    local font_dir="$HOME/Library/Fonts"  # Change this to your preferred font directory if needed
    local font_url="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"

    # Check if Meslo Nerd Font is already installed
    if [[ -f "$font_dir/MesloLGS NF Regular.ttf" ]]; then
        echo "Meslo Nerd Font is already installed."
    else
        echo "Installing Meslo Nerd Font..."
        mkdir -p "$font_dir"
        curl -fsSL -o "$font_dir/MesloLGS NF Regular.ttf" "$font_url"
        echo "Meslo Nerd Font installed to $font_dir"
    fi
}


# Check if Homebrew is installed, if not, install it
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing..."
    install_homebrew
else
    echo "Homebrew is already installed."
fi

configure_homebrew

brew install antidote

install_meslo_font 

# Check if the directory to link from is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_to_link_from>"
    exit 1
fi

SOURCE_DIR=$(realpath "$1")
TARGET_DIR="$HOME"
SCRIPT_NAME=$(basename "$0")

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "The directory $SOURCE_DIR does not exist."
    exit 1
fi

# Loop through each file in the source directory
shopt -s dotglob
for FILE in "$SOURCE_DIR"/*; 
do
    if [ -f "$FILE" ]&& [ "$BASENAME" != "README.md" ] && [ "$BASENAME" != "$SCRIPT_NAME" ]; then
        BASENAME=$(basename "$FILE")
        ln -sf "$FILE" "$TARGET_DIR/$BASENAME"
        echo "Created symlink for $FILE in $TARGET_DIR"
    fi
done
shopt -u dotglob

echo "All symbolic links created."

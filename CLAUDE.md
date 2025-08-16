# Dotfiles Setup Guide

## Quick Reference for Setting Up Dotfiles from GitHub

### Prerequisites
- Git is installed and configured
- GitHub SSH keys are set up (or HTTPS access)
- User git config is set up (already done):
  - Name: Jonathan Wrobel
  - Email: jwrobes@gmail.com

### Standard Dotfiles Setup Process

#### 1. Clone Your Dotfiles Repository
```bash
# Navigate to home directory
cd ~

# Clone your dotfiles repo (replace with your actual repo URL)
git clone git@github.com:yourusername/dotfiles.git
# OR if using HTTPS:
# git clone https://github.com/yourusername/dotfiles.git
```

#### 2. Common Dotfiles Setup Methods

**Method A: Symbolic Links (Recommended)**
```bash
# Create symbolic links from dotfiles repo to home directory
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# For directories (like .ssh, .config)
ln -sf ~/dotfiles/.ssh ~/.ssh
ln -sf ~/dotfiles/.config ~/.config
```

**Method B: Copy Files**
```bash
# Copy files from dotfiles repo to home directory
cp ~/dotfiles/.bashrc ~/.bashrc
cp ~/dotfiles/.zshrc ~/.zshrc
cp ~/dotfiles/.vimrc ~/.vimrc
# etc.
```

**Method C: Use Install Script**
```bash
# Many dotfiles repos include an install script
cd ~/dotfiles
./install.sh
# OR
make install
```

#### 3. Reload Shell Configuration
```bash
# Reload shell configuration
source ~/.bashrc
# OR
source ~/.zshrc

# Or simply restart your terminal
```

### Common Commands

#### Check Current Dotfiles Status
```bash
# See what's currently linked
ls -la ~ | grep " -> "

# Check git status in dotfiles repo
cd ~/dotfiles && git status
```

#### Update Dotfiles
```bash
cd ~/dotfiles
git pull origin main
```

#### Add New Dotfile
```bash
# Move existing file to dotfiles repo
mv ~/.newconfig ~/dotfiles/.newconfig

# Create symbolic link
ln -sf ~/dotfiles/.newconfig ~/.newconfig

# Commit to repo
cd ~/dotfiles
git add .newconfig
git commit -m "Add .newconfig"
git push origin main
```

### Troubleshooting

#### Permission Issues
```bash
# Fix permissions for SSH keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

#### Broken Symbolic Links
```bash
# Find broken symlinks
find ~ -type l -exec test ! -e {} \; -print

# Remove broken symlink and recreate
rm ~/.broken_link
ln -sf ~/dotfiles/.correct_file ~/.correct_file
```

#### Backup Before Setup
```bash
# Create backup of existing dotfiles
mkdir ~/dotfiles_backup
cp ~/.bashrc ~/dotfiles_backup/ 2>/dev/null || true
cp ~/.zshrc ~/dotfiles_backup/ 2>/dev/null || true
cp ~/.vimrc ~/dotfiles_backup/ 2>/dev/null || true
```

### Notes for Claude
- Always check what dotfiles already exist before overwriting
- Use `ls -la` to see current symlinks and configurations
- Ask user for their GitHub dotfiles repository URL if not obvious
- Suggest backing up existing configurations before linking new ones
- Remember that macOS uses .bash_profile instead of .bashrc by default

### Including CLAUDE.md in Your Dotfiles

**Add CLAUDE.md to your dotfiles repo:**
```bash
# Copy this file to your dotfiles repository
cp ~/CLAUDE.md ~/dotfiles/CLAUDE.md

# Commit it to your repo
cd ~/dotfiles
git add CLAUDE.md
git commit -m "Add Claude setup instructions"
git push origin main
```

**When setting up a new computer:**
```bash
# After cloning dotfiles, link CLAUDE.md to home directory
ln -sf ~/dotfiles/CLAUDE.md ~/CLAUDE.md
```

**Benefits:**
- Claude instructions travel with your dotfiles
- Version controlled setup documentation
- Always have the latest instructions available
- Can add project-specific CLAUDE.md files too

### Your Current Git Config Location
Your git config is at: `/Users/jonathanwrobel/.gitconfig`
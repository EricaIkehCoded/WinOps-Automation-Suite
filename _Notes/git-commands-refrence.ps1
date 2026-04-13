# ============================================
# Git Commands Reference
# WinOps Automation Suite | MSSA Portfolio
# Author: Erica Ikeh
# ============================================

# --- ONE TIME SETUP ---

# Set your name and email (run once when Git is first installed)
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Confirm your config saved correctly
git config --list

# --- GETTING STARTED ---

# Clone a repo from GitHub to your local machine
git clone https://YOUR_TOKEN@github.com/USERNAME/REPO-NAME.git

# Open the project in VS Code from the terminal
code .

# --- THE CORE WORKFLOW (use these every time) ---

# Step 1 - Check what Git sees (red = untracked, green = staged)
git status

# Step 2 - Stage everything in the current folder
git add .

# Step 3 - Commit with a descriptive message
git commit -m "Your message here describing what you did"

# Step 4 - Push to GitHub
git push origin main

# --- GOOD COMMIT MESSAGE EXAMPLES ---
# "Initial structure: add 9 phase folders and notes snippet"
# "Phase 1: Add Get-SystemInventory.ps1"
# "Phase 1: Fix memory calculation rounding"
# "Notes: Add git commands reference file"

# --- HELPFUL EXTRAS ---

# See your commit history
git log

# See a shorter version of commit history
git log --oneline

# See what changed in a file before staging
git diff

# Start of each new phase
git checkout -b phase2-dev

# Work, test, commit as normal
git add .
git commit -m "Phase 2: description of what you did"
git push origin phase2-dev

# When phase is complete and reviewed by Claude
git checkout main
git merge phase2-dev
git push origin main
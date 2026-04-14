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

#Adding .gitignore file to exclude certain files/folders from being tracked by Git
New-Item -ItemType File -Name ".gitignore"

# When Git opens the Vim merge message editor
# Type this to save and exit:
:wq
# Then press Enter

# --- REPO RECOVERY (use when Git Desktop loses the repo) ---

# Step 1 - Verify the folder exists
Test-Path "C:\ClassFiles-EWI\WinOps-Automation-Suite"

# Step 2 - Delete corrupted .git folder
Remove-Item -Recurse -Force "C:\ClassFiles-EWI\WinOps-Automation-Suite\.git"

# Step 3 - Reinitialize with correct branch name (main)
git init -b main

# Step 4 - Stage and commit all local files
git add .
git commit -m "Restore repo"

# Step 5 - Re-add the remote (skip if error says already exists)
git remote add origin https://github.com/EricaIkehCoded/WinOps-Automation-Suite.git

# Step 6 - Pull from GitHub first if remote has existing commits
git pull origin main --allow-unrelated-histories

# Step 7 - If merge conflicts, accept GitHub's version for everything
git checkout --theirs .
git add .
git commit -m "Merge with remote"

# Step 8 - Push to GitHub
git push -u origin main
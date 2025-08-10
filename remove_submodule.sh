#!/bin/bash

echo "Removing SCTL submodule..."

# 1. Deinitialize the submodule
echo "Step 1: Deinitializing submodule..."
git submodule deinit -f extern/SCTL

# 2. Remove from .git/modules
echo "Step 2: Removing from .git/modules..."
rm -rf .git/modules/extern/SCTL

# 3. Remove from working directory
echo "Step 3: Removing from working directory..."
git rm -f extern/SCTL

# 4. Remove .gitmodules file
echo "Step 4: Removing .gitmodules file..."
rm .gitmodules

# 5. Commit changes
echo "Step 5: Committing changes..."
git add .
git commit -m "Remove SCTL submodule and .gitmodules file"

echo "Submodule removal completed successfully!"
echo "You may need to run: git push origin main" 
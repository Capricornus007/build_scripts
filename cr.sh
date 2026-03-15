#!/bin/bash

# =============================
#   CrDroid Build Script
#   For: Vanilla → Gapps
# =============================

# --- Remove old local manifests ---
rm -rf .repo/local_manifests
rm -rf .repo/manifests
rm -rf .repo/manifest.xml

# --- Init ROM repo ---
repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle && \

# ---your manifest here ---
git clone -b lineage-23.2 https://github.com/RMX3366-Development/local_manifests .repo/local_manifests

# Then run sync command
/opt/crave/resync.sh && \

# =============================
#  Build: Vanilla → Gapps
# =============================

# --- Vanilla Build ---
echo "===== Starting Vanilla Build ====="
. build/envsetup.sh && \
brunch rivena && \
make installclean && \
mka bacon

echo "===== All builds completed successfully! ====="

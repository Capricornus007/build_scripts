#!/bin/bash

# =============================
#   CrDroid Build Script
#   For: Vanilla → Gapps
# =============================

# --- Remove old local manifests ---
rm -rf .repo/local_manifests
rm -rf .repo/manifests
rm -rf .repo/manifest.xml

# --- Remove Device Settings --- (Reason: It Will fail sync when we re run this script)
rm -rf packages/resources/devicesettings

# --- Init ROM repo ---
repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle && \

# --- Sync ROM ---
#/opt/crave/resync.sh && \
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune && \

# --- Clone Device Tree ---
rm -rf device/realme
git clone https://github.com/RMX3366-Development/android_device_realme_rivena -b lineage-23.2 device/realme/rivena && \

# --- Clone Vendor Tree ---
rm -rf vendor/realme
git clone https://github.com/RMX3366-Development/proprietary_vendor_realme_rivena -b lineage-23.2 vendor/realme/rivena && \

# --- Clone Kernel Tree ---
rm -rf kernel/realme
git clone https://github.com/bijoyv9/android_kernel_realme_sm8250 -b Entropy-1.0 kernel/realme/sm8250 && \
#git clone https://github.com/MurtazaKolachi/android_kernel_xiaomi_apollo -b staging kernel/xiaomi/apollo && \

# --- Clone Hardware Tree ---
rm -rf hardware/oplus
git clone https://github.com/RMX3366-Development/android_hardware_oplus -b lineage-23.2 hardware/oplus && \

# --- Dolby ---
rm -rf hardware/dolby
git clone https://github.com/RMX3366-Development/android_hardware_dolby -b 16 hardware/dolby && \

# --- Vendor Common Device ---
git clone https://github.com/RMX3366-Development/proprietary_vendor_realme_sm8250-common -b lineage-23.2 vendor/realme/sm8250-common && \

# --- OPLUS Camera ---
git clone https://github.com/RMX3366-Development/proprietary_vendor_realme_sm8250-common -b lineage-23.1 vendor/oplus/camera && \
# WFD repos
# git clone https://github.com/PocoF3Releases/device_qcom_wfd device/qcom/wfd && \
# git clone https://github.com/PocoF3Releases/vendor_qcom_wfd vendor/qcom/wfd && \

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

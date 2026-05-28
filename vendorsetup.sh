#!/bin/bash

# Define colour codes
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

fatal() {
    echo -e "${RED}[FATAL] $1${NC}"
    return 1
}

info() {
    echo -e "${CYAN}$1${NC}"
}

success() {
    echo -e "${GREEN}$1${NC}"
}

warn() {
    echo -e "${YELLOW}$1${NC}"
}

info "Cloning All resources"

# Vendor
info "Cloning vendor tree"
git clone -b yaap --depth 1 https://github.com/Poco-F6-resources/android_vendor_xiaomi_peridot.git vendor/xiaomi/peridot || fatal "Vendor tree clone failed!"

# Kernel sources
info "Cloning Kernel sources"
git clone -b 16.2 --depth 1 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635 || fatal "Kernel source clone failed!"

# Kernel Modules
warn "Cleaning kernel modules directory"
rm -rf kernel/xiaomi/sm8635-modules
info "Cloning kernel modules"
git clone -b 16.2 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules || fatal "Kernel modules clone failed!"

# Kernel Device-Trees
warn "Cleaning kernel devicetrees directory"
rm -rf kernel/xiaomi/sm8635-devicetrees
info "Cloning kernel devicetrees"
git clone -b 16.2 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees || fatal "Kernel devicetrees clone failed!"

# Hardware xiaomi
info "Cloning hardware xiaomi from Lab"
warn "Cleaning hardware/xiaomi directory"
rm -rf hardware/xiaomi
git clone -b yaap git@github.com:peridot-lab/hardware_xiaomi_yaap.git hardware/xiaomi || fatal "Hardware xiaomi clone failed!"

# interfaces
warn "Removing lineage interfaces from yaap"
rm -rf hardware/lineage/interfaces
info "Cloning interfaces from Lab"
git clone -b sixteen git@github.com:peridot-lab/hardware_lineage_interfaces-yaap.git hardware/lineage/interfaces || fatal "interfaces clone failed!"

# sepolicy
warn "Removing lineage sepolicy from yaap"
rm -rf device/lineage/sepolicy
info "Cloning sepolicy from Lab"
git clone -b sixteen git@github.com:peridot-lab/device_lineage_sepolicy-yaap.git device/lineage/sepolicy || fatal "sepolicy clone failed!"

# Dolby
info "Cloning Lunaris Dolby"
warn "Cleaning Old Dolby repo"
git clone -b 16 https://github.com/Poco-F6-resources/hardware_dolby.git hardware/dolby || fatal "Dolby clone failed"

# ChargeControl
info "Cloning ChargeControl From Lab"
warn "Cleanig ChargeControl"
rm -rf packages/apps/ChargeControl
git clone -b main git@github.com:peridot-lab/packages_apps_ChargeControl.git -b main packages/apps/ChargeControl

# FastCharge
info "Cloning FastCharge From Lab"
warn "Cleanig FastCharge"
rm -rf packages/apps/FastCharge
git clone -b master git@github.com:peridot-lab/packages_apps_FastCharge.git -b master packages/apps/FastCharge

# Mi Cam
info "Cloning Mi Cam"
info "Cloning Miuicamera vendor"
git clone -b 16.2 --depth 1 https://github.com/Poco-F6-resources/vendor_xiaomi_peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera || fatal "Vendor miuicamera clone failed!"

info "Cloning Miuicamera device"
git clone -b 16.2 --depth 1 https://github.com/Poco-F6-resources/device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera || fatal "Device miuicamera clone failed!"

# Keys
info "Cloning Keys"
info "Cleaning Old Keys"
rm -rf vendor/yaap/signing
git clone git@github.com:Krtonia/keys.git -b yaap vendor/yaap/signing
success "All resources cloned successfully!"

return 0

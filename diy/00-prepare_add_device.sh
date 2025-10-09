#!/bin/bash

# 集成设备无线
mkdir -p package/base-files/files/lib/firmware/brcm
cp -a $GITHUB_WORKSPACE/configfiles/firmware/brcm/* package/base-files/files/lib/firmware/brcm/

# ================================================================
# 移植RK3399示例，其他RK3399可模仿
# ================================================================
# 增加tvi3315a设备
echo -e "\\ndefine Device/tvi_tvi3315a
  DEVICE_VENDOR := Tvi
  DEVICE_MODEL := TVI3315A
  SOC := rk3399
  UBOOT_DEVICE_NAME := tvi3315a-rk3399
  IMAGE/sysupgrade.img.gz := boot-combined | boot-script | pine64-img | gzip | append-metadata
endef
TARGET_DEVICES += tvi_tvi3315a" >> target/linux/rockchip/image/armv8.mk

# 替换package/boot/uboot-rockchip/Makefile
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

# 复制dts与配置文件到package/boot/uboot-rockchip
mkdir -p package/boot/uboot-rockchip/src/arch/arm/dts
mkdir -p package/boot/uboot-rockchip/src/configs
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/rk3399-tvi3315a.dts package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/rk3399-tvi3315a-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/tvi3315a-rk3399_defconfig package/boot/uboot-rockchip/src/configs/

# 复制dts到files/arch/arm64/boot/dts/rockchip
mkdir -p target/linux/rockchip/files/arch/arm64/boot/dts/rockchip
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/rk3399-tvi3315a.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/

# 添加dtb补丁到target/linux/rockchip/patches-6.6
cp -f $GITHUB_WORKSPACE/configfiles/linux-rockchip/Makefile target/linux/rockchip/Makefile
cp -f $GITHUB_WORKSPACE/configfiles/patch/211-rockchip-rk3399-add-support-more-devices.patch target/linux/rockchip/patches-6.6/211-rockchip-rk3399-add-support-more-devices.patch
# ================================================================
# RK3399示例结束
# ================================================================

# ================================================================
# 移植RK3566示例，其他RK35xx可模仿
# ================================================================
# 增加station-m2设备
echo -e "\\ndefine Device/firefly_station-m2
  DEVICE_VENDOR := Firefly
  DEVICE_MODEL := Station M2 / RK3566 ROC PC
  SOC := rk3566
  DEVICE_DTS := rockchip/rk3566-roc-pc
  SUPPORTED_DEVICES += firefly,station-m2 firefly,rk3566-roc-pc
  UBOOT_DEVICE_NAME := station-m2-rk3566
  IMAGE/sysupgrade.img.gz := boot-common | boot-script | pine64-img | gzip | append-metadata
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += firefly_station-m2" >> target/linux/rockchip/image/armv8.mk

# 复制dts与配置文件到package/boot/uboot-rockchip
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-roc-pc.dts package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/rk3566-station-m2-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/station-m2-rk3566_defconfig package/boot/uboot-rockchip/src/configs/

# 复制dts到files/arch/arm64/boot/dts/rockchip
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-roc-pc.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/
# ================================================================
# RK35xx示例结束
# ================================================================

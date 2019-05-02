################################################################################
#
# additional uboot configurations for Rockchips
#
################################################################################

# Rockchips firmware has been selected
ifeq ($(BR2_PACKAGE_RK_FIRMWARE),y)

define UBOOT_BUILD_RK3399
	$(HOST_DIR)/bin/loaderimage --pack --uboot $(@D)/u-boot-dtb.bin $(@D)/uboot.img 0x200000 --size 1024 1
	sed -e 's|uboot.img|$(@D)/uboot.img|' \
		-e 's|trust.img|$(BINARIES_DIR)/u-boot/trust.img|' \
		-e 's|bin/rk33|$(BINARIES_DIR)/firmware|g' \
		$(RK_FIRMWARE_PKGDIR)/spi.ini > $(@D)/spi.ini
	$(HOST_DIR)/bin/firmwareMerger -P $(@D)/spi.ini $(@D)
endef

define UBOOT_INSTALL_IMAGE_RK3399
	$(INSTALL) -D -m 0644 $(@D)/uboot.img $(BINARIES_DIR)/u-boot/uboot.img
	$(INSTALL) -D -m 0644 $(@D)/Firmware.img $(BINARIES_DIR)/u-boot/spi/uboot-trust-spi.img
	$(INSTALL) -D -m 0644 $(@D)/Firmware.md5 $(BINARIES_DIR)/u-boot/spi/uboot-trust-spi.img.md5
endef

UBOOT_POST_BUILD_HOOKS += UBOOT_BUILD_RK3399
UBOOT_POST_INSTALL_IMAGES_HOOKS += UBOOT_INSTALL_IMAGE_RK3399

endif # BR2_PACKAGE_RK_FIRMWARE

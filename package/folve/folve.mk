################################################################################
#
# folve
#
################################################################################

FOLVE_VERSION = 874063e136a44d8f7a0066ced85c7793f44283d4
FOLVE_SITE = https://github.com/hzeller/folve
FOLVE_SITE_METHOD = git
FOLVE_INSTALL_STAGING = YES
FOLVE_DEPENDENCIES = flac libfuse3 libmicrohttpd libsndfile zita-convolver
FOLVE_LICENSE = GPL3
FOLVE_LICENSE_FILES = COPYING

FOLVE_MAKE_ENV += " SNDFILE_INC= "
FOLVE_MAKE_ENV += " SNDFILE_LIB=-lsndfile"
FOLVE_MAKE_ENV += " FUSE_INC=-I$(STAGING_DIR)/usr/include/fuse3"
FOLVE_MAKE_ENV += " FUSE_LIB=-lfuse3"

define FOLVE_BUILD_CMDS
	$(MAKE) $(FOLVE_MAKE_ENV) CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D)
endef

define FOLVE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/folve $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))

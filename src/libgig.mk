# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgig
$(PKG)_WEBSITE  := https://linuxsampler.org/
$(PKG)_DESCR    := C++ library for accessing Gigasampler/GigaStudio, DLS, SoundFont and KORG sound files
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.4.1
$(PKG)_CHECKSUM := fdc89efab1f906128e6c54729967577e8d0462017018bc12551257df5dfe3aa4
$(PKG)_SUBDIR   := libgig-$($(PKG)_VERSION)
$(PKG)_FILE     := libgig-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://download.linuxsampler.org/packages/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libsndfile

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://download.linuxsampler.org/packages/' | \
    $(SED) -n 's,.*"libgig-\([0-9][^"]*\)\.tar.bz2.*,\1,p' | \
    tail -1
endef

# -std=gnu++11 -m32 -lrpcrt4

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-g++' \
        -Wall -Wextra -Wno-unused-parameter -std=c++11 \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libgig.exe' \
        `'$(TARGET)-pkg-config' gig --cflags --libs`
endef

$(PKG)_BUILD_SHARED =

# This file is part of MXE. See LICENSE.md for licensing information.

include src/qt/qt6/qt6-conf.mk

PKG := qt6-qt5compat
$(eval $(QT6_METADATA))

$(PKG)_CHECKSUM := 41c4bbe419158fc170ee3ef3ecffead506e70802109deec036d86e4244086009
$(PKG)_DEPS     := cc qt6-conf qt6-qtbase

QT6_PREFIX   = '$(PREFIX)/$(TARGET)/$(MXE_QT6_ID)'
QT6_QT_CMAKE = '$(QT6_PREFIX)/$(if $(findstring mingw,$(TARGET)),bin,libexec)/qt-cmake-private' \
                   -DCMAKE_INSTALL_PREFIX='$(QT6_PREFIX)'

define $(PKG)_BUILD
    $(QT6_QT_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --build . -j '$(JOBS)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --install .
endef

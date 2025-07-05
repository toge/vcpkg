vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO eyalz800/zpp_bits
    REF "v${VERSION}"
    SHA512 329a39d9eb72b74f0f2c6e40a0b7b907a723b1b5393b86ebde78dada1361dda3c5e4e23add45bc24d45637640a9f66dcaf1cfe0d84f338a86a0606911362b8bd
    HEAD_REF master
)

file(INSTALL "${SOURCE_PATH}/zpp_bits.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

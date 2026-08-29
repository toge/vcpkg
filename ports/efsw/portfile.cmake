vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SpartanJ/efsw
    REF "${VERSION}"
    SHA512 45d18dcc1095335d48af67f91dc2594356437148276bfb6462c988c7648c0977a9b281fced020fa62cef6a2c91b090f18f81ce1a3d335546c079959282ec8075
    HEAD_REF master
    PATCHES
        # https://github.com/SpartanJ/efsw/issues/218
        fix-project-version.patch
)

vcpkg_download_distfile(SFML_LICENSE
    URLS https://raw.githubusercontent.com/SFML/SFML/5383d2b3948f805af55c9f8a4587ac72ec5981d1/license.md
    FILENAME sfml-5383d2b3948f805af55c9f8a4587ac72ec5981d1-license.md
    SHA512 3315bb0a454f1df16fc5f817221447094f36bdfcc8cd068e1af49c844d0afac66c1592ef86ddac5b9ec9e7ab3d3f736fb6e20298d587d46433156465c1509df3
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" EFSW_BUILD_SHARED_LIB)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" EFSW_BUILD_STATIC_LIB)

# efsw CMakeLists sets up two targets "efsw" and "efsw-static" where the former is static or shared depending on BUILD_SHARED_LIBS and the latter is always static
vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DVERBOSE=OFF
        -DBUILD_TEST_APP=OFF
        -DBUILD_SHARED_LIBS=${EFSW_BUILD_SHARED_LIB}
        -DBUILD_STATIC_LIBS=0
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/efsw)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()

vcpkg_install_copyright(FILE_LIST
    "${SOURCE_PATH}/LICENSE"
    "${SFML_LICENSE}"
)

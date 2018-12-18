#!/bin/bash

if [ -z "$GENERATOR" ]; then
  echo "No Generator has been set"
  exit 1
fi

. ./versions.sh
VER=$IRICLIB_VER

rm -rf lib/src/iriclib
rm -rf lib/build/iriclib
rm -rf lib/install/iriclib

mkdir -p lib/src/iriclib
cp -r appveyor.yml bins/ build-iriclib.cmake build-iriclib.sh \
    CMakeLists.txt error_macros.h filelocker.cpp filelocker.h \
    fortran_macros.h iric_ftoc.c iriclib_bstream.cpp iriclib_bstream.h \
    iriclib_cgnsfile_base.cpp iriclib_cgnsfile_bc.cpp \
    iriclib_cgnsfile_cc.cpp iriclib_cgnsfile_complex_cc.cpp \
    iriclib_cgnsfile_geo.cpp iriclib_cgnsfile_grid.cpp iriclib_cgnsfile.h \
    iriclib_cgnsfile_sol.cpp iriclib.cpp iriclib_f.h iriclib_geo.cpp \
    iriclib_global.h iriclib.h iriclib_pointmap.cpp iriclib_pointmap.h \
    iriclib_polygon.cpp iriclib_polygon.h iriclib_polyline.cpp \
    iriclib_polyline.h iriclib.pro iriclib_riversurvey.cpp \
    iriclib_riversurvey.h iriclib_single.c iriclib.spec make_iric_ftoc.php \
    make_iriclib_singlefuncs_header.php make_iriclib_singlefuncs.php \
    private/ README.md release/ sort_iriclib_funcs.php \
    unittest_cg_open_modify/ unittest_cg_open_read/ unittest_lock/ \
    unittests/ unittests_cgnsfile/ lib/src/iriclib

ctest -S build-iriclib.cmake -DCONF_DIR:STRING=debug   "-DCTEST_CMAKE_GENERATOR:STRING=$GENERATOR" -C Debug   -VV -O $SGEN-iriclib-debug.log
ctest -S build-iriclib.cmake -DCONF_DIR:STRING=release "-DCTEST_CMAKE_GENERATOR:STRING=$GENERATOR" -C Release -VV -O $SGEN-iriclib-release.log

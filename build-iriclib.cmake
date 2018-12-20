set(CTEST_PROJECT_NAME "iriclib")
set(CTEST_BUILD_NAME "$ENV{SGEN}-iriclib")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

# TODO: de-hard-code these
set(VER "$ENV{IRICLIB_VER}")
set(SVER "${VER}")
set(CGNS_VER "3.2.1")
set(HDF5_VER "1.8.14")

set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/iriclib-${SVER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/iriclib-${SVER}/${CONF_DIR}")

find_package(HDF5)

# override LIBDIR to be consistent w/ hdf5 and cgns
set(BUILD_OPTIONS 
"-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/iriclib-${SVER}/${CONF_DIR}"
"-DCMAKE_PREFIX_PATH:PATH=${PREFIX_PATH}"
"-DCMAKE_INSTALL_LIBDIR:PATH=lib"
)

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
if (WIN32)
  file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${CGNS_VER}/${CONF_DIR}/bin/cgnsdll.dll"
       DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
       )
  if(${CONF_DIR} STREQUAL "debug")
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/hdf5_D.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/szip_D.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/zlib_D.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
  else()
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/hdf5.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/szip.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin/zlib.dll"
         DESTINATION "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}"
         )
  endif()
endif()
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET RUN_TESTS)
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)

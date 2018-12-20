Name:           iriclib
Version:        0.1
Release:        1%{?dist}
Summary:        International River Interface Cooperative library.

License:        BSD
URL:            http://i-ric.org/en/
Source0:        https://github.com/ashalper-usgs/%{name}/archive/rpmbuild.zip

BuildRequires:  cgnslib, cgnslib-devel
Requires:       cgnslib

%description
iRICXXX (International River Interface Cooperative) is a river flow
and riverbed variation analysis software package which combines the
functionality of MD_SWMS, developed by the USGS (U.S. Geological
Survey) and RIC-Nays, developed by the Foundation of Hokkaido River
Disaster Prevention Research Centers.


%package        devel
Summary:        Development files for %{name}
Requires:       %{name}%{?_isa} = %{version}-%{release}

%description    devel
The %{name}-devel package contains libraries and header files for
developing applications that use %{name}.


%prep
%setup -q -n %{name}-rpmbuild


%build
# See Fastmech-BMI/bin/build-gcc-solver.sh

GENERATOR="Unix Makefiles"
SGEN="gcc"

export GENERATOR SGEN

export IRICLIB_VER=%{version}

rm -rf lib/src/iriclib-%{version}
rm -rf lib/build/iriclib-%{version}
rm -rf lib/install/iriclib-%{version}

mkdir -p lib/src/iriclib-%{version}
cp -r CMakeLists.txt README.md appveyor.yml bins/ error_macros.h \
    filelocker.cpp filelocker.h fortran_macros.h iric_ftoc.c iriclib.cpp \
    iriclib.h iriclib.pro iriclib.spec iriclib_bstream.cpp \
    iriclib_bstream.h iriclib_cgnsfile.h iriclib_cgnsfile_base.cpp \
    iriclib_cgnsfile_bc.cpp iriclib_cgnsfile_cc.cpp \
    iriclib_cgnsfile_complex_cc.cpp iriclib_cgnsfile_geo.cpp \
    iriclib_cgnsfile_grid.cpp iriclib_cgnsfile_sol.cpp iriclib_f.h \
    iriclib_geo.cpp iriclib_global.h iriclib_pointmap.cpp \
    iriclib_pointmap.h iriclib_polygon.cpp iriclib_polygon.h \
    iriclib_polyline.cpp iriclib_polyline.h iriclib_riversurvey.cpp \
    iriclib_riversurvey.h iriclib_single.c make_iric_ftoc.php \
    make_iriclib_singlefuncs.php make_iriclib_singlefuncs_header.php \
    private/ release/ sort_iriclib_funcs.php unittest_cg_open_modify/ \
    unittest_cg_open_read/ unittest_lock/ unittests/ unittests_cgnsfile/ \
    lib/src/iriclib-%{version}

ctest -S build-iriclib.cmake -DCONF_DIR:STRING=release \
    "-DCTEST_CMAKE_GENERATOR:STRING=$GENERATOR" -C Release -VV \
    -O $SGEN-iriclib-release.log


%install
rm -rf $RPM_BUILD_ROOT
# TODO:
find -type f
find -type f -name '*.so*' -or -name '*.h'


%files
%doc
%{_libdir}/*.so

%files devel
%doc
%{_includedir}/*


%changelog
* Wed Dec 19 2018 Andrew Halper <ashalper@usgs.gov> - 0.1-1>
- Built on CentOS 7.

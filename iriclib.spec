Name:           iriclib
Version:        0.1
Release:        1%{?dist}
Summary:        International River Interface Cooperative library.

License:        BSD
URL:            http://i-ric.org/en/
Source0:        https://github.com/ashalper-usgs/%{name}/archive/rpmbuild.zip

BuildRequires:  cgnslib, cgnslib-devel

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
%setup -q -n %{name}


%build
GENERATOR="Unix Makefiles"
SGEN="gcc"

export GENERATOR SGEN

. ./versions.sh
VER=$IRICLIB_VER

rm -rf lib/src/%{name}
rm -rf lib/build/%{name}
rm -rf lib/install/%{name}

# CMake insists on building in a directory apart from the source.
mkdir -p lib/src/%{name}
cp -r appveyor.yml bins/ build-iriclib.cmake \
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
    unittests/ unittests_cgnsfile/ lib/src/%{name}

# Much commonality with cmake suspected here, but they appear to be
# using ctest because it has some additional features (like CMake
# packaging?)
ctest -S build-iriclib.cmake -DCONF_DIR:STRING=release \
    "-DCTEST_CMAKE_GENERATOR:STRING=$GENERATOR" -C Release -VV --debug

# TODO: this might not be necessary for RPM build
./create-paths-pri-solver.sh > paths.pri
./create-dirExt-prop-solver.sh > dirExt.prop


%install
rm -rf $RPM_BUILD_ROOT
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

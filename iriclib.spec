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

./build-iriclib.sh

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
* Tue Dec 18 2018 Andrew Halper <ashalper@usgs.gov> - 0.1-1>
- Built on CentOS 7.

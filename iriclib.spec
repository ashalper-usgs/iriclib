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
mkdir _build
cd _build
/usr/bin/cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr -DBUILD_SHARED_LIBS:BOOL=ON ..
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
cd _build && %make_install


%files
%doc
%{_libdir}/*.so

%files devel
%doc
%{_includedir}/*.h
%{_includedir}/private/*.h

%changelog
* Fri Dec 21 2018 Andrew Halper <ashalper@usgs.gov> - 0.1-1
- Built on CentOS 7.

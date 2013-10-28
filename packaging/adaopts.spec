Name:		adaopts
Version:	0.1
Release:	1%{?dist}
Summary:	Option parser for Ada

Group:		Development/Libraries
License:	GPLv2
URL:		http://ada-ru.org
Source0:	%{name}-%{version}.tgz

BuildRequires:	gcc-gnat fedora-gnat-project-common > 3 

%description
%{summary}

%package devel
Summary:    Devel package for %{name}
License:    GPLv2
Group:      Development/Libraries
Requires:   %{name}%{?_isa} = %{version}-%{release}
Requires:   fedora-gnat-project-common > 3

%description devel
%{summary}


%prep
%setup -q


%build
make %{?_smp_mflags}


%install
make install DESTDIR=%{buildroot} prefix=%{_prefix} libdir=%{_libdir}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%doc COPYING
%{_libdir}/%{name}/*.so.%{version}
%{_libdir}/*.so.%{version}

%files devel
%doc README*
%{_includedir}/%{name}
%{_libdir}/%{name}/*.ali
%{_libdir}/*.so
%{_libdir}/%{name}/*.so
%{_libdir}/%{name}/*.so.?
%{_libdir}/*.so.?
%{_GNAT_project_dir}/%{name}.gpr

%changelog


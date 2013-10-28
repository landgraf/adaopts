BUILDER ?= gprbuild -p -f -gnat12
FLAGS ?=
BUILD = $(BUILDER) ${FLAGS}
NAME = $(shell basename ${PWD})
PROJECT ?= adaopts
DESTDIR ?= 
prefix ?= /usr/local
libdir ?= ${prefix}/lib
includedir ?= ${prefix}/include
gprdir ?= ${prefix}/share/gpr
VERSION = 0.2


all: clean build
debug :clean build_debug
check_syntax: clean build_syntax
warn: clean build_all_warnings
strip: clean build_strip
prof: clean build_prof

build: 
	${BUILD} -P gnat/${PROJECT}_build 

build_prof: 
	${BUILD} -P gnat/${PROJECT}_build -ggdb -g -gnata -v -cargs -pg -largs -pg

build_gdb:
	 ${BUILD} -P gnat/${PROJECT}_build  -gnata -g -v  -cargs -O0  
	 #-bargs -shared

build_debug:
	${BUILD} -P gnat/${PROJECT}_build  -gnata -ggdb -g  -cargs -pg  

build_syntax:
	${BUILD} -P gnat/${PROJECT}_build  -gnata -ggdb -g -gnatwhwuwawiwc -gnatyy -gnatwu -gnatwa  -gnatwi -gnatwc  -cargs -pg  

build_all_warnings: 
	${BUILD} -v -g -Pgnat/${PROJECT}_build -gnata -gnatwu -cargs -O0 -pg 

clean:
	rm -rf bin/ obj/ lib/  tmp/ logadaliz/

release: clean
	sh dist/buildrpm.sh ${VERSION} ${VERSION} && echo "exit code: $?"

rpm: clean 
	sh dist/buildtemprpm.sh ${VERSION} && echo "exit code: $?"

install:
	install -d -m 0755 ${DESTDIR}/${libdir}/${PROJECT}
	install -d -m 0755 ${DESTDIR}/${includedir}/${PROJECT}
	install -d -m 0755 ${DESTDIR}/${gprdir}
	cp -r lib/*.ali ${DESTDIR}/${libdir}/${PROJECT}
	cp -r lib/*.so* ${DESTDIR}/${libdir}/${PROJECT}
	cp -r src/*.ad? ${DESTDIR}/${includedir}/${PROJECT}
	cp -r gnat/${PROJECT}.gpr ${DESTDIR}/${gprdir}
	cd ${DESTDIR}/${libdir} && ln -s ${PROJECT}/*.so* .

clean_rpm:
	rm -rf ${HOME}/rpmbuild/SOURCES/${NAME}-${VERSION}.tgz

rpm: clean_rpm
	git archive --prefix=${NAME}-${VERSION}/ -o ${HOME}/rpmbuild/SOURCES/${NAME}-${VERSION}.tgz HEAD
	rpmbuild -ba packaging/${NAME}.spec


ada_project_path ?= /usr/lib/gnat/
DESTDIR ?= /tmp
LIBDIR ?= /usr/local/lib
MKDIR?= mkdir -p 
OPTFLAGS ?= 
#-p  -f -gnat12 -cargs -O2
DBHOST = "192.168.0.1"
DBUSER = test 
DBNAME = test
DBPASSWORD = test
I_PRE ?= /usr/
I_DIR ?= ${I_PRE}/include
I_DAT ?= ${I_PRE}/share
I_DOC ?= ${I_DAT}/doc
I_LIB ?= ${I_DAT}/lib
I_NLIB ?= ${I_DAT}/lib/adaproj/
I_PROJ ?= ${I_LIB}/gnat
CP ?= /bin/cp -a 
GPRBUILD ?=  gprbuild -p -f -gnat12

all: clean build_debug

debug :clean build_debug
warn: clean build_all_warnings
strip: clean build_strip

build: 
	${GPRBUILD} -Pgnat/adaopts   ${OPTFLAGS}

build_debug: 
	${GPRBUILD} -Pgnat/adaopts -gnata -cargs -O0 -g    ${OPTFLAGS}

build_all_warnings: 
	${GPRBUILD} -Pgnat/adaopts  -gnata -gnatwu -cargs -O0 -g  -v  ${OPTFLAGS}

clean:
	rm -rf bin/ obj/ lib/

install:
	@mkdir -p ${DESTDIR}/${I_DIR} ${DESTDIR}/${I_DAT} ${DESTDIR}/${I_DOC} ${DESTDIR}/${I_LIB} ${DESTDIR}/${I_PROJ} ${DESTDIR}/${I_NLIB}
	find src/ -name "*.ad[bs]" -exec cp {} ${DESTDIR}/${I_DIR}\; 
	${CP} lib/*.so ${DESTDIR}/${I_LIB}
	${CP} obj/*.ali ${DESTDIR}/${I_LIB}
	@echo "Not implemented yet"
	exit 1

clean_db:
	psql -h ${DBHOST} -U ${DBUSER} ${DBNAME} <<< "DROP TABLE IF EXISTS erid; DROP TABLE IF EXISTS members; DROP TABLE IF EXISTS partner; DROP TABLE IF EXISTS lead_tc; DROP TABLE IF EXISTS sequence; DROP TABLE IF EXISTS bladeserver; DROP table IF EXISTS rackserver; DROP table IF EXISTS mgmtip;"
		
create_db: clean_db
	gnatcoll_db2ada -dbmodel dbmodel -dbhost ${DBHOST} -dbtype postgresql -dbuser ${DBUSER} -dbname ${DBNAME} -dbpasswd ${DBPASSWORD} -createdb

orm: create_db
	@mkdir -p src/db/generated/
	cp dbmodel src/db/generated/
	cd src/db/generated/ &&  gnatcoll_db2ada -dbmodel dbmodel -api Database -orm Orm && rm dbmodel


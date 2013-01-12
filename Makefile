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
all: clean build_debug

debug :clean build_debug
warn: clean build_all_warnings
strip: clean build_strip

build: 
	gprbuild -Pgnat/adaopts  -gnat12  -p -f ${OPTFLAGS}

build_debug: 
	gprbuild -Pgnat/adaopts -p  -f -gnat12 -gnata -cargs -O0 -g    ${OPTFLAGS}

build_ada05: 
	gprbuild -Pgnat/adaopts -p  -f -gnat12 -gnata -cargs -O0 -g   ${OPTFLAGS}

build_all_warnings: 
	gprbuild -Pgnat/adaopts -p   -f -gnat12 -gnata -gnatwu -cargs -O0 -g  -v  ${OPTFLAGS}

clean:
	rm -rf bin/ obj/ lib/

install:
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


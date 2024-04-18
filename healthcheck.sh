#!/usr/bin/bash

set -e

/opt/oracle/product/21c/dbhomeXE/bin/sqlplus ${APP_USER}/${ORACLE_PASSWORD}@//localhost:1521/XEPDB1 <<EOF
whenever sqlerror exit sql.sqlcode;
select count(*) from chinook.foo;
EOF

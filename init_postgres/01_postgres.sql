-- -*- sql-product: postgres; -*-

create extension if not exists oracle_fdw;

create server oracle foreign data wrapper oracle_fdw options (dbserver '//oracle:1521/XEPDB1');

create schema chinook;

create user mapping for current_user server oracle options (user 'chinook', password 'Password123#');

import foreign schema "CHINOOK" from server oracle into chinook ;

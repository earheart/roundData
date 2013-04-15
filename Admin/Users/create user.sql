-- to create a client login
-- replace <<schema>> with the client schema
-- replace <<password>> with the user password
-- replace <<username>> with firstname.lastname of the user

-- NOTE: if this is for rC Staff, schema should be *

GRANT USAGE ON `<<schema>>`.* TO `<<username>>`@`%` IDENTIFIED BY '<<password>>' REQUIRE NONE;
GRANT USAGE ON *.* TO `<<username>>`@`%` REQUIRE NONE;
GRANT Alter routine  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT USAGE  ON `<<schema>>`.* TO `<<username>>`@`%` WITH GRANT OPTION;
GRANT Event  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Select  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Alter  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Execute  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Show view  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Lock tables  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Create  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Create routine  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Create View  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Drop  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Insert  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Index  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Delete  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Create temporary tables  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Trigger  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT Update  ON `<<schema>>`.* TO `<<username>>`@`%`;
GRANT SELECT ON mysql.proc TO `<<username>>`@`%`;
GRANT SELECT ON mysql.func TO `<<username>>`@`%`;






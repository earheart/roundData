DROP PROCEDURE IF EXISTS CREATE_ARCHIVE_VIEWS;
CREATE PROCEDURE CREATE_ARCHIVE_VIEWS()
BEGIN
DROP TABLE IF EXISTS RS_CREATE_ARCHIVE_VIEW;
CREATE TABLE RS_CREATE_ARCHIVE_VIEW
as
        select @rownum:=@rownum+1 as rownum, main.*
        from
        (SELECT OBJECT_NAME FROM RC_ADMIN.rd_archive_api
        group by OBJECT_NAME) MAIN
        , (SELECT @rownum:=0) r;
SET @c1 = (select max(rownum) from  RS_CREATE_ARCHIVE_VIEW);
SET @p1 = 0;
set @r1 = '';
set @table_name = '';
set @object_name = '';

 REPEAT
    SET @p1 = @p1 + 1;
    set @object_name   = (select OBJECT_NAME from RS_CREATE_ARCHIVE_VIEW where rownum = @p1);
    SET @r1            = concat('call GET_ARCHIVE_VIEW_DEF(\'', @object_name,'\');');
    SET @execute_def   = @r1; 
   -- SELECT @EXECUTE_DEF;
    PREPARE execute_def_stmt from @execute_def;
    EXECUTE execute_def_stmt;
    DEALLOCATE PREPARE execute_def_stmt;
 UNTIL @p1 = @c1
END REPEAT;
drop table IF EXISTS RS_CREATE_ARCHIVE_VIEW;
END;

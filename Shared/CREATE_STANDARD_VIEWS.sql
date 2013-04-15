DROP PROCEDURE IF EXISTS CREATE_STANDARD_VIEWS;
CREATE PROCEDURE CREATE_STANDARD_VIEWS()
BEGIN
DROP TABLE IF EXISTS RS_CREATE_VIEW;
CREATE TABLE RS_CREATE_VIEW
as
        select @rownum:=@rownum+1 as rownum, main.*
        from
        (SELECT O.TABLE_NAME, O.OBJECT_NAME, F.COLUMN_NAME AS ARCHIVE_FIELD
        from rj_object o 
        join rj_field f on f.TABLE_NAME = o.TABLE_NAME
        where f.FIELD_NAME like '%archive_flag%'
        group by o.OBJECT_NAME
        union
        select o.TABLE_NAME, o.object_name, 'NONE'
        from rj_object o 
        join rj_field f on f.TABLE_NAME = o.TABLE_NAME
        where o.OBJECT_NAME not in 
        (select o.OBJECT_NAME
        from rj_object o 
        join rj_field f on f.TABLE_NAME = o.TABLE_NAME
        where f.FIELD_NAME like '%archive_flag%'
        group by o.OBJECT_NAME)
        group by o.OBJECT_NAME) main
        , (SELECT @rownum:=0) r;
SET @c1 = (select max(rownum) from rs_create_view);
SET @p1 = 0;
set @r1 = '';
set @table_name = '';
set @object_name = '';
set @archive_field = '';
REPEAT
    SET @p1 = @p1 + 1;
    set @table_name    = (select table_name    from RS_CREATE_VIEW where rownum = @p1);
    set @object_name   = (select case when right(OBJECT_name,3) = '__c' then left(OBJECT_name, length(OBJECT_name) - length(right(OBJECT_name,3))) else OBJECT_name end AS OBJECT_NAME  from RS_CREATE_VIEW where rownum = @p1);
    set @archive_field = (select archive_field from RS_CREATE_VIEW where rownum = @p1);
    SET @r1            = concat('call GET_STANDARD_VIEW_DEF(\'', @table_name, '\',\'',  @object_name, '\',\'', @archive_field, '\');');
    SET @execute_def   = @r1;     
    PREPARE execute_def_stmt from @execute_def;
    EXECUTE execute_def_stmt;
    DEALLOCATE PREPARE execute_def_stmt;
UNTIL @p1 = @c1
END REPEAT;
drop table RS_CREATE_VIEW;
END;
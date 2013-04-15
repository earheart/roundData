DROP PROCEDURE IF EXISTS RENAME_TABLE_IF_EXISTS;
CREATE PROCEDURE RENAME_TABLE_IF_EXISTS(IN PARAM_TABLE VARCHAR(255))
BEGIN
        set @schema := (select schema());
        set @hist_table := (select concat(param_table,'_', replace(curdate(), '-','_'),'_at_', replace(curtime(), ':','_')));
        set @unidef := (select COUNT(*)
        FROM INFORMATION_SCHEMA.tables
        WHERE table_schema = @schema
        AND table_name = param_table);
    IF @unidef <> 0 THEN
        SET @sql_cmd := CONCAT(
            'rename TABLE ',
            '`', @schema, '`', '.',
            param_table,
            ' TO ',             
            '`', @schema, '`', '.',
            @hist_table);
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        SET @sql_cmd := concat('Create table ', param_table, ' as select * from ', @hist_table);
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
     ELSE
        -- SET @SQL_CMD := (SELECT concat('CREATE TABLE ', PARAM_TABLE, ' (RECORD_NUMBER INT(11) not null AUTO_INCREMENT, TABLE_NAME VARCHAR(30) NOT NULL, FIELD_NAME VARCHAR(60) NOT NULL, COLUMN_NAME VARCHAR(30) NOT NULL, LABEL VARCHAR(70) NOT NULL, HELPTEXT LONGTEXT ASCII, UNIVERSE_NAME VARCHAR(100) NOT NULL, UNIVERSE_FIELD_NAME VARCHAR(100) NOT NULL, UNIVERSE_FIELD_NAME_OVERRIDE VARCHAR(100), INCLUDED VARCHAR(5) DEFAULT \'False\', ORDERBY INT(11), PRIMARY KEY (RECORD_NUMBER)) ENGINE = innodb ROW_FORMAT = DEFAULT'));
        SET @SQL_CMD := (SELECT concat('CREATE TABLE ', PARAM_TABLE, ' as SELECT * FROM RC_ADMIN.', PARAM_TABLE));
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
       IF PARAM_TABLE <> 'RD_ARCHIVE_API' THEN
        SET @SQL_CMD := (select concat('update ', PARAM_TABLE, ' u join rj_field f on u.field_name = f.FIELD_NAME and u.column_name = f.COLUMN_NAME set u.column_name = f.column_name where f.column_name <> u.column_name'));
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        ELSE SET @SQL_CMD := (select concat('update ', PARAM_TABLE, ' u join rj_field f on u.field_name = f.FIELD_NAME and u.column_name = f.COLUMN_NAME set u.column_name = f.column_name where f.column_name <> u.column_name'));
        END IF;
    END IF;
END;
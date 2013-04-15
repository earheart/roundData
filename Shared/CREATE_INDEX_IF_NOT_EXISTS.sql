DROP PROCEDURE IF EXISTS CREATE_INDEX_IF_NOT_EXISTS;
CREATE PROCEDURE CREATE_INDEX_IF_NOT_EXISTS(IN PARAM_TABLE CHAR(255), IN PARAM_INDEX CHAR(255), IN PARAM_COLUMN CHAR(255))
BEGIN

        -- SELECT 
        set @schema := (select schema());
        set @indexes := (select COUNT(*)
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE table_schema = @schema
        AND table_name = param_table
        AND INDEX_NAME = param_index);

    IF @indexes = 0 THEN
        SET @sql_cmd := CONCAT(
            'ALTER TABLE ',
            param_table,
            ' ADD INDEX ',
            '`', param_index, '` ',
            '(', param_column, ')');
        -- SELECT @sql_cmd;
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END;

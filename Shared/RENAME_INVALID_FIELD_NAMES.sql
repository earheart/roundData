DROP PROCEDURE IF EXISTS RENAME_INVALID_FIELD_NAMES;
CREATE PROCEDURE `RENAME_INVALID_FIELD_NAMES`(IN PARAM_TABLE VARCHAR(255))
BEGIN
        -- replaces % with PCT
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'%\', \'pct\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces (s) with nothing
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'(s)\', \'\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces + with plus
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'+\', \'plus\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces @ with _at_
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'@\', \'_at_\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces * with _x_
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'*\', \'_x_\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces & with and
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'&\', \'and\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces # with num
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'#\', \'num\') where included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces " with nothing
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' set UNIVERSE_FIELD_NAME_OVERRIDE = replace(UNIVERSE_FIELD_NAME_OVERRIDE, \'\"\',\'\') where IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME) like \'%\"%\' and included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces \ with nothing
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' set UNIVERSE_FIELD_NAME_OVERRIDE = replace(UNIVERSE_FIELD_NAME_OVERRIDE, \'\\\'\',\'\') where IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME) like \'%\\\'%\' and included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces__ with _
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = REPLACE(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME),\'__\', \'_\') where included = \'True\' and included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- looks for identical labels and pre-appends the object name where they are found
        SET @sql_cmd := CONCAT('UPDATE ', param_table, '  g join (SELECT IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME) naming FROM ', param_table, ' where included = \'True\' GROUP BY IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME) HAVING COUNT(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME))>1) n on n.naming = IFNULL(g.UNIVERSE_FIELD_NAME_OVERRIDE,g.UNIVERSE_FIELD_NAME) set UNIVERSE_FIELD_NAME_OVERRIDE = concat(get_object_name(table_name), \'_\', ifnull(g.UNIVERSE_FIELD_NAME_OVERRIDE, g.UNIVERSE_FIELD_NAME))');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        --  looks for remaining identical labels and used the column name (api name)
        SET @sql_cmd := CONCAT('UPDATE ', param_table, '  g join (SELECT IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME) naming FROM ', param_table, ' where included = \'True\' GROUP BY IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME) HAVING COUNT(IFNULL(UNIVERSE_FIELD_NAME_OVERRIDE,UNIVERSE_FIELD_NAME))>1) n on n.naming = IFNULL(g.UNIVERSE_FIELD_NAME_OVERRIDE,g.UNIVERSE_FIELD_NAME) set UNIVERSE_FIELD_NAME_OVERRIDE = G.COLUMN_NAME');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;
        -- replaces the final character of names ending in _ with nothing
        SET @sql_cmd := CONCAT('UPDATE ', param_table, ' SET UNIVERSE_FIELD_NAME_OVERRIDE = left(UNIVERSE_FIELD_NAME_OVERRIDE,(length(UNIVERSE_FIELD_NAME_OVERRIDE)-1)) where right((UNIVERSE_FIELD_NAME_OVERRIDE),1) = \'_\' and included = \'True\'');
        PREPARE stmt FROM @sql_cmd;
        EXECUTE stmt;        
        DEALLOCATE PREPARE stmt;
END;

DROP TABLE rS_data_dictonary;
CREATE TABLE rS_data_dictonary (
   ID                INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT 'GUID for item',
   Name              VARCHAR(255)       NOT NULL COMMENT 'Name of function or view',
   Type              VARCHAR(255)       NOT NULL COMMENT 'Type i.e. function, view, procedure, index',
   Related_Package   VARCHAR(255)                COMMENT 'Related rC package i.e. rC_Bios, rC_Giving, rC_Connect',
   Description       VARCHAR(255)                COMMENT 'Detailed description of what the function does',
   Input_1           VARCHAR(255)                COMMENT 'If item requires imputs, list them here',
   Input_2           VARCHAR(255)                COMMENT 'If item requires imputs, list them here',
   Input_3           VARCHAR(255)                COMMENT 'If item requires imputs, list them here',
   Input_4           VARCHAR(255)                COMMENT 'If item requires imputs, list them here',
   Input_5           VARCHAR(255)                COMMENT 'If item requires imputs, list them here',
   Return_Result     VARCHAR(255)                COMMENT 'If item returns a result, list it here',
   Developer         VARCHAR(255)                COMMENT 'The developer who built the code'
) ENGINE = InnoDB ROW_FORMAT = DEFAULT;

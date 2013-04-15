DROP TRIGGER IF EXISTS CAMPAIGNMEMBER_INSERT;
CREATE TRIGGER CAMPAIGNMEMBER_INSERT BEFORE INSERT ON `CAMPAIGNMEMBER`
     FOR EACH ROW 
     BEGIN
     DECLARE msg varchar(255);
    IF (NEW.contactid IS NULL AND  NEW.leadid is null)
     THEN
        SET msg = 'Constraint CAMPAIGNMEMBER_INSERT violated: Lead ID or Contact ID Required on CAMPAIGNMEMBER';
        SIGNAL sqlstate '45000' SET message_text = msg;
     END IF; 
     END
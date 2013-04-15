DROP TRIGGER IF EXISTS CAMPAIGNMEMBER_ALREADY_MEMBER_UPDATE; 
CREATE TRIGGER CAMPAIGNMEMBER_ALREADY_MEMBER_UPDATE BEFORE UPDATE ON `CAMPAIGNMEMBER`
     FOR EACH ROW 
     BEGIN
     DECLARE msg varchar(255);
     IF (concat(ifnull(NEW.CAMPAIGNID,'null'),'|',ifnull(NEW.contactid,'null'),'|',ifnull(NEW.leadid, 'null'))
     =
     (SELECT concat(ifnull(id,'null'),'|',ifnull(contactid,'null'),'|',ifnull(leadid, 'null'))  
    FROM CAMPAIGNMEMBER 
    WHERE CAMPAIGNMEMBER.CAMPAIGNID= NEW.CAMPAIGNID
      AND CAMPAIGNMEMBER.CONTACTID = NEW.CONTACTID
      AND CAMPAIGNMEMBER.LEADID    = NEW.LEADID))
     THEN
        SET msg = 'Constraint CAMPAIGNMEMBER_ALREADY_MEMBER violated: Campaign/Contact/Lead pair already exists!';
        SIGNAL sqlstate '45000' SET message_text = msg;
     END IF; 
     END
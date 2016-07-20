create table Doc_Spec
(
	DID int references Doctor(DID),
    SID int references Speciality(SID),
    Primary Key (DID,SID)
);

DELIMITER // 
create procedure InsertDocSpec(vDID int, vSID int)
BEGIN
	insert into Doc_Spec values(vDID, vSID);
END //
DELIMITER ;

DELIMITER //
create procedure UpdateDoctorsSpeciality(vDID int, oldSID int, newSID int)
BEGIN
	update Doc_Spec set SID = newSID where SID = oldSID AND DID = vDID;
END
DELIMITER ;


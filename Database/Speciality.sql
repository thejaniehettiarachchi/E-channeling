create table Speciality
(
	SID int Primary Key auto_increment,
    Name varchar(60)
);

DELIMITER //
create procedure AddSpeciality (
	vName varchar(60)
)
BEGIN
	insert into Speciality (Name) values (vName);
END //
DELIMITER ;

DELIMITER //
create procedure UpdateSpeciality ( 
	vSID int,
    vName varchar(60)
)
BEGIN
	update Speciality set Name = vName where SID = vSID;
END //
DELIMITER ;

DELIMITER // 
create procedure DeleteSPeciality(vSID int)
BEGIN
	delete from Speciality where SID = vSID;
END // 
DELIMITER ;
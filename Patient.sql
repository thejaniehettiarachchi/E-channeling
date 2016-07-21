use AMC;

create table Patient
(
	PID int primary key auto_increment,
    FName varchar(15) not null,
    LName varchar(30) not null,
    ANumber varchar(25),
    AStreet varchar(25),
    ACity varchar(25),
    Email varchar(50),
    NICNo varchar(10) not null,
    Title varchar(4),
    CMobile int(10),
    CHome int(10),
    IsLocal bool,
    isDeleted bool default false
);

DELIMITER //
create procedure AddPatient (

    vTitle varchar(4),	
    vFName varchar(15),
    vLName varchar(30),
    vANumber varchar(25),
    vAStreet varchar(25),
    vACity varchar(25),
    vEmail varchar(50),
    vNICNo varchar(10),
    vCMobile int(10),
    vCHome int(10),
    vIsLocal bool

)

Begin 

	insert into Patient (FName,LName,ANumber, AStreet,ACity,Email,NICNo,Title,CMobile,CHome,IsLocal) 
	values (vFName,vLName,vANumber,vAStreet,vACity,vEmail,vNICNo,vTitle,vCMobile,vCHome,vIsLocal);
	
END //
DELIMITER ;

drop procedure UpdatePatient;

DELIMITER //
create procedure UpdatePatient (
	vPID int,    
    vTitle varchar(4),
	vFName varchar(15),
    vLName varchar(30),
    vANumber varchar(25),
    vAStreet varchar(25),
    vACity varchar(25),
    vEmail varchar(50),
    vNICNo varchar(10),
    vCMobile int(10),
    vCHome int(10),
    vIsLocal bool

)
BEGIN 
	update Patient set 
    FName = vFName,
    LName = vLName,
    ANumber = vANumber,
    AStreet = vAStreet,
    ACity = vACity,
    Email = vEmail,
    NICNo = vNICNo,
    Title = vTitle,
    CMobile = vCMobile,
    CHome = vCHome,
    IsLocal = vIsLocal 
    Where 
    PID = vPID;
END //
DELIMITER ;

DELIMITER // 
create procedure DeletePatient(vPID int)
BEGIN 
	update Patient set isDeleted = true where PID = vPID;
END //
DELIMITER ;

DELIMITER // 
create procedure RecoverPatient(vPID int)
BEGIN 
	update Patient set isDeleted = false where PID = vPID;
END //
DELIMITER ;

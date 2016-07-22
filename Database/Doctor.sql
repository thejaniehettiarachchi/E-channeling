use AMC;

create table Doctor
(
	DID int Primary Key auto_increment,
	Title varchar(7),
	FName varchar(15) not null,
    LName varchar(30) not null,
    Contact int(10),
	Email varchar(50),
	Fee double(8,2),
    isDeleted bool default false
);

DELIMITER //
create procedure AddDoctor (
	vTitle varchar(4),
	vFName varchar(15),
    vLName varchar(30),
    vContact int(10),
	vEmail varchar(50),
	vFee double(8,2)
)

Begin
	
    insert into Doctor (Title, FName, LName, Contact, Email, Fee)
    values (vTitle, vFName, vLName, vContact, vEmail, vFee);

END //
DELIMITER ;

DELIMITER //
create procedure UpdateDoctor (
	vDID int,
    vTitle varchar(4),
	vFName varchar(15),
    vLName varchar(30),
    vContact int(10),
	vEmail varchar(50),
	vFee double(8,2)
    
)

Begin
	update Doctor set 
    Title = vTitle,
	Fname = vFName,
    LName = vLName,
    Contact = vContact,
	Email = vEmail,
	Fee = vFee
    where DID = vDID;
    
   
END //
DELIMITER ;

DELIMITER //
create procedure DeleteDoctor (vDID int)

Begin
	update Doctor set 
    isDeleted = true where DID = vDID;
   
END //
DELIMITER ;
DELIMITER //
create procedure RecoverDoctor (vDID int)

Begin
	update Doctor set 
    isDeleted = false where DID = vDID;
   
END //
DELIMITER ;

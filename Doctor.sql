create table Doctor
(
	DID int Primary Key auto_increment,
	Title varchar(4),
	FName varchar(15) not null,
    LName varchar(30) not null,
    Contact int(10),
     Email varchar(50),
     Fee double(8,2)
);

DELIMITER //
create procedure AddDoctor (
	Title varchar(4),
	FName varchar(15),
    LName varchar(30),
    Contact int(10),
	Email varchar(50),
	Fee double(8,2)
)

Begin
	
    insert into Doctor (Title, FName, LName, Contact, Email, Fee)
    values (vTitle, vFName, vLName, vContact, vEmail, vFee);

END //
DELIMITER ;
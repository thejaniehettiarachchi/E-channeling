use AMC;

create table Schedule
(
	SchID int primary key auto_increment,
    Date date not null,
    StartTime time not null,
    EndTime time not null,
    MaxPatients int not null,
    Status int(1), 
    DID int references Doctor(DID)
);

DELIMITER // 
<<<<<<< HEAD
create procedure UpdateSchedule(
	
	vSchID int,
    vDate date,
=======
create procedure AddSchedule(
	vDate date ,
>>>>>>> origin/Version1
    vStartTime time,
    vEndTime time,
    vMaxPatients int,
    vStatus int(1), 
<<<<<<< HEAD
    vDID int
)

BEGIN

	update Schedule set 
    Date = vDate,
    StartTime = vStartTime,
    EndTime = vEndTime,
    MaxPatients = vMaxPatients,
    Status = vStatus, 
    DID = vDID
    
    where SchID = vSchID;    

=======
    vDID int 
    )
BEGIN
	insert into Schedule (
		Date,
		StartTime,
		EndTime,
		MaxPatients,
		Status, 
		DID
    )
    values (
    vDate,
    vStartTime,
    vEndTime,
    vMaxPatients,
    vStatus, 
    vDID
    );
>>>>>>> origin/Version1
END //
DELIMITER ;
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
create procedure AddSchedule(
	vDate date ,
    vStartTime time,
    vEndTime time,
    vMaxPatients int,
    vStatus int(1), 
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
END //
DELIMITER ;
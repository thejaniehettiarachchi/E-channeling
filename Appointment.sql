use AMC;

create table Appointment
(
	RefID int primary key auto_increment,
    PID int references Patient(PID),
    DID int references Doctor(DID),
	SchID int references Schedule(SchID),
    Date date not null,
    Time time not null,
    QueNo int not null,
    Fee double(8,2),
    Status int(1)
    
);

DELIMITER // 
create procedure AddAppointment(
    vPID int,
    vDID int,
	vSchID int,
    vDate date,	
	vFee double(8,2),
    vStatus int(1)
    )

BEGIN

	vQueNo int;
    

	insert into Schedule (
	PID,
    DID,
	SchID,
    Date,   
    Fee,
    Status
    )
    values (
    vPID,
    vDID,
	vSchID,
    vDate,   
    vFee,
    2
    );
END //
DELIMITER ;

DELIMITER // 
create procedure UpdateAppointment(
	vRefID int,
    vPID int,
    vDID int,
	vSchID int,
    vDate date,
	vTime time,
	vQueNo int,
	vbFee double(8,2)
)

BEGIN

	update Appointment set 
	PID = vPID,
    DID = vDID,
	SchID = vSchID,
    Date = vDate,
    Time = vTime,
	QueNo = vQueNo,
    Fee = vFee
    
    where RefID = vRefID;    

END //
DELIMITER ;

DELIMITER //
create procedure CancelAppointment(vSchID int)
BEGIN
	update Appoinment set status = 1 where SchID = VSchID; 
END //
DELIMITER ;

DELIMITER //
create procedure CloseAppointment(vSchID int)
BEGIN
	update Appoinment set status = 3 where SchID = VSchID; 
END //
DELIMITER ;



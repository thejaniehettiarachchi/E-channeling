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

	Declare vQueNo int;
    Declare vtime time;

	set vQueNo = getQueueNo(vSchID);
    set vTime = getTime(SchID);
    
	insert into Appointment (
	PID,
    DID,
	SchID,
    Date,   
    Fee,
    Status,
    QueNo,
    Time
    )
    values (
    vPID,
    vDID,
	vSchID,
    vDate,   
    vFee,
    2,
    vQueNo,
    vTime
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

DELIMITER //
create function getQueueNo (vSchID int) returns int 
    
BEGIN
    
	Declare QueueNo int default 0;
    
    select count(*) into QueueNo
    from Appointment
    where SchID = vSchID;
    
    return (QueueNo +1);
    
END //
DELIMITER ;

DELIMITER //
create function getTime (vSchID int) returns time 
    
BEGIN
    
	Declare QueueNo int default 0;
   
    Declare avrTime time;
    #Declare appTime time;
    
    set QueueNo = getQueueNo(vSchID);
    
    select startTime, endTime, maxPatients into sTime, eTime, mPatients
    from Schedule
    where SchID = vSchID;
    
    set avrTime = (eTime -sTime) / mPatients;
    
    return avrTime;
    
END //
DELIMITER ;


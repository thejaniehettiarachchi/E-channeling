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

drop procedure AddAppointment;

DELIMITER // 
create procedure AddAppointment(
    vPID int,
    vDID int,
	vSchID int,
    vDate date	
    )

BEGIN

	Declare vQueNo int;
    Declare vtime time;
    Declare vFee double;

	set vQueNo = getQueueNo(vSchID);
    set vTime = getTime(vSchID);
    set vFee = getFee (vSchID);
    
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
	Declare sTime time;
	Declare eTime time;
	Declare mPatients int;
    Declare avrTime time;
    Declare appTime time;
    Declare extraTime int; #extra time to arrive early (seconds)
    
    set QueueNo = getQueueNo(vSchID);
    set extraTime = 600;
    
    select startTime, endTime, maxPatients into sTime, eTime, mPatients
    from Schedule
    where SchID = vSchID;
    
  # set avrTime = sec_to_time(Time_to_sec(eTime -sTime) / mPatients);
    set avrTime =(time_to_sec(eTime) -time_to_sec(sTime))/mPatients;
  #  select avrTime;
    set appTime = sec_to_time(time_to_sec(sTime) + avrTime * (QueueNo-1) - extraTime);
    
    return appTime;
    
END //
DELIMITER ;

DELIMITER //

create function getFee(vSchID int) returns double

BEGIN

	Declare Fee double(8,2);
    Declare hosFee double(8,2); #Hospital charges
    Declare docFee double(8,2); #Doctor's fee
    
    set hosFee = 100.00;
    
    set docFee = ( 
		select d.Fee 
        from Doctor as d, Schedule as s
        where d.DID = s.DID and s.SID = vSID
	);
    
    set Fee = hosFee + docFee;
    
    return Fee;

END //

DELIMITER ;


select getTime(1);

drop function getTime;
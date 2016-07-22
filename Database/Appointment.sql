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
	vSchID int
    )

BEGIN

	Declare vQueNo int;
    Declare vtime time;
    Declare vFee double;
    Declare vDate date;
    Declare vDID date;

	set vQueNo = getQueueNo(vSchID);
    set vTime = getTime(vSchID);
    set vFee = getFee (vSchID);
    set vDate = (select Date from Schedule where SchID = vSchID);
    set vDID = (select DID from Schedule where SchID = vSchID);
    
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

drop procedure UpdateAppointment;


DELIMITER // 
create procedure UpdateAppointment(
    vRefID int,
	vSchID int
)

BEGIN

	Declare vQueNo int;
    Declare vtime time;
    Declare vFee double;
    Declare vDate date;
    Declare vDID date;

	set vQueNo = getQueueNo(vSchID);
    set vTime = getTime(vSchID);
    set vFee = getFee (vSchID);
    set vDate = (select Date from Schedule where SchID = vSchID);
    set vDID = (select DID from Schedule where SchID = vSchID);
    
	update Appointment set 
    DID = vDID,
	SchID = vSchID,
    Date = vDate,
    Time = vTime,
	QueNo = vQueNo,
    Fee = vFee
    
    where RefID = vRefID;    

END //
DELIMITER ;

drop procedure CancelAppointment;
drop procedure CloseAppointment;


DELIMITER //
create procedure CancelAppointment(vRefID int)
BEGIN
	update Appoinment set status = 1 where RefID = VRefID; 
END //
DELIMITER ;

DELIMITER //
create procedure CloseAppointment(vRefID int)
BEGIN
	update Appoinment set status = 3 where RefID = VRefID; 
END //
DELIMITER ;

DELIMITER //
create function getQueueNo (vSchID int) returns int 
    
BEGIN
    
	Declare QueueNo int default 0;
    
    select QueNo into QueueNo
    from Appointment
    where SchID = vSchID
    order by QueNo desc 
    limit 1;
    
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
    set extraTime = 1200;
    
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
        where s.SchID = vSchID and d.DID = s.DID
	);
    
    
    set Fee = hosFee + docFee;
    
    return Fee;

END //

DELIMITER ;


select getTime(1);

drop function getFee;
drop function getTime;
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

DELIMITER // 
create procedure UpdateSchedule(
	
	vSchID int,
    vDate date,
    vStartTime time,
    vEndTime time,
    vMaxPatients int,
    vDID int
)

BEGIN

	update Schedule set 
    Date = vDate,
    StartTime = vStartTime,
    EndTime = vEndTime,
    MaxPatients = vMaxPatients,
    DID = vDID
    
    where SchID = vSchID;    

END //
DELIMITER ;

DELIMITER //
create procedure CancelSchedule(vSchID int)
BEGIN
 update Schedule set Status = 1 where SchID = VSchID;
 update Appoinment set status = 1 where SchID = VSchID; 
END //
DELIMITER ;

DELIMITER // 
create procedure SetScheduleStatus(vSchID int, vStatus int)
BEGIN 
	update Schedule set Status = vStatus where SchID = vSchID;
END // 
DELIMITER ;

DELIMITER //
create procedure GetCurrentScedules()
begin
	select * from Schedule where Status = 2;
end //
DELIMITER ;


DELIMITER //
create procedure GetSchedulesForDay(vDateToFind date)
BEGIN 

    
	select S.SchID into resultset from (
					select * from Schedule where Status = 2
				   ) AS S 
     where S.Date = vDateToFind;
END //
DELIMITER ;
drop procedure GetFreeSlotsForADay;
DELIMITER //
create procedure GetFreeSlotsForADay(vDateToFind date)
BEGIN
		DECLARE $StartIndex int;
		DECLARE $EndIndex int;
		DECLARE $CenterStartTime time ;
		DECLARE $CenterEndTime time ;
    
		set $CenterStartTime = '0800000';
        set $CenterEndTime = '2000000';
        
        
		 Select S.SchID into $StartIndex from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where S.Date = vDateToFind
		 LIMIT 1;		 
             
		 
		 Select S.SchID into $EndIndex from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where S.Date = vDateToFind 
		 ORDER BY S.SchID desc
		 LIMIT 1;
    
		create temporary table AvailableSlots
		(
			Date date,
			StartTime time,
			EndTime time
		);
        # Inserting the First row of the Current Schedules into availableSlots
		 insert into AvailableSlots (Date, StartTime, EndTime)
    
		 (select S.Date, $CenterStartTime, S.StartTime  from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where S.Date = vDateToFind
         LIMIT 1)
	UNION
		 (select S.Date, S.EndTime, 
						 (
							 select StartTime 
							 from Schedule 
							 where status = 2 AND SchID > S.SchID LIMIT 1
                         )
					   from 
					   (
							select * from Schedule where Status = 2
					   ) AS S
         where S.Date = vDateToFind
         LIMIT 1)
         ;
         
         # Inserting all rows between first and last rows of the Current Schedules into availableSlots
         
         insert into AvailableSlots (Date, StartTime, EndTime)
    
		 select S.Date, S.EndTime, 
						 (
							 select StartTime 
							 from Schedule 
							 where status = 2 AND SchID > S.SchID LIMIT 1
                         )
					   from 
					   (
							select * from Schedule where Status = 2
					   ) AS S
                       
		 where S.Date = vDateToFind AND S.SchID > $StartIndex AND S.SchID < $EndIndex;
         
         # Inserting the Last row of the Current Schedules into availableSlots
         
         insert into AvailableSlots (Date, StartTime, EndTime)
    
		 select S.Date, S.EndTime, $CenterEndTIme  from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where S.Date = vDateToFind
         Order by S.SchID Desc
         LIMIT 1;
         
         # Selecting all in AvailableSlots table
       
         
         Select * from AvailableSlots;     
         
         drop table AvailableSlots;
     
END // 
DELIMITER ;

drop procedure GetFreeSlotsForTheWeek;

DELIMITER //
create procedure GetFreeSlotsForTheWeek(vDateToFind date)
BEGIN
		DECLARE $StartIndex int;
		DECLARE $EndIndex int;
        DECLARE $CenterStartTime time ;
		DECLARE $CenterEndTime time ;
        
		set $CenterStartTime = '0800000';
        set $CenterEndTime = '2000000';
        
		 Select S.SchID into $StartIndex from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where weekofyear(S.Date) = weekofyear(vDateToFind)
		 LIMIT 1;		 
             
		 
		 Select S.SchID into $EndIndex from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where weekofyear(S.Date) = weekofyear(vDateToFind) 
		 ORDER BY S.SchID desc
		 LIMIT 1;
    
		create temporary table AvailableSlots
		(
			Date date,
			StartTime time,
			EndTime time
		);
        # Inserting the First row of the Current Schedules into availableSlots
		 insert into AvailableSlots (Date, StartTime, EndTime)    
		 (
			 select S.Date, $CenterStartTime, S.StartTime  from (
							select * from Schedule where Status = 2
						   ) AS S 
			 where weekofyear(S.Date) = weekofyear(vDateToFind)
			 LIMIT 1
         )
         UNION         
		 (
			 select S.Date, S.EndTime, 
							 (
								 select StartTime 
								 from Schedule 
								 where status = 2 AND SchID > S.SchID LIMIT 1
							 )
						   from 
						   (
								select * from Schedule where Status = 2
						   ) AS S
			 where weekofyear(S.Date) = weekofyear(vDateToFind)
			 LIMIT 1
		 )         
         ;
         
         # Inserting all rows between first and last rows of the Current Schedules into availableSlots
         
         insert into AvailableSlots (Date, StartTime, EndTime)
    
		 select S.Date, S.EndTime, 
						 (
							 select StartTime 
							 from Schedule 
							 where status = 2 AND SchID > S.SchID LIMIT 1
                         )
					   from 
					   (
							select * from Schedule where Status = 2
					   ) AS S
                       
		 where weekofyear(S.Date) = weekofyear(vDateToFind) AND S.SchID > $StartIndex AND S.SchID < $EndIndex;
         
         # Inserting the Last row of the Current Schedules into availableSlots
         
         insert into AvailableSlots (Date, StartTime, EndTime)
    
		 select S.Date, S.EndTime, $CenterEndTime  from (
						select * from Schedule where Status = 2
					   ) AS S 
		 where weekofyear(S.Date) = weekofyear(vDateToFind)
         Order by S.SchID Desc
         LIMIT 1;
         
         # Selecting all in AvailableSlots table
       
         
         Select * from AvailableSlots order by Date;     
         
         drop table AvailableSlots;
     
END // 
DELIMITER ;


call GetFreeSlotsForADay(NOW());
call GetFreeSlotsForTheWeek('2016-05-26');


truncate Schedule;
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','133000','143000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-27','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-28','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-29','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-30','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-31','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-06-01','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);




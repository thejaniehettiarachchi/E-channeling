use AMC;

insert into Doctor(Title, FName, LName, Contact, Email, Fee)
values ('Mr.','Ravindra', 'De Silva', 0712583221,'Ra@gmail.com', 20.00);

select * from Doctor;

insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','200830','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','183000','193000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','233000','243000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','083000','103000',5,2,1);

select * from Schedule;
call GetFreeSlotsForADay('2016-05-26');

call AddPatient ( 'Mr', 'Nicum', 'Wijesuriya', '123', 'idicjndc', 'Colombo', 'nicum@gmail.com', 
				'987654321v', 0717894561, 0117894561, true);
                
select * from Patient;
select * from Appointment;

call AddAppointment( 1, 1, 3, '2016-05-26', 200.00);

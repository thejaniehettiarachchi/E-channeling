use AMC;

insert into Doctor(Title, FName, LName, Contact, Email, Fee)
values ('Mr.','Ravindra', 'De Silva', 0712583221,'Ra@gmail.com', 20.00);

select * from Doctor;

insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','200830','1030',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','1830','1930',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','2330','2430',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','0830','1030',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','0830','1030',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','0830','1030',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','0830','1030',5,2,1);
insert into Schedule (Date, StartTime, EndTime, MaxPatients, Status, DID)
Values ('2016-05-26','0830','1030',5,2,1);

select * from Schedule;
call GetFreeSlotsForADay('2016-05-26');
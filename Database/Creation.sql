Create Database AMC;

use AMC;

create table Patient
(
	PID int primary key auto_increment,
    FName varchar(15) not null,
    LName varchar(30) not null,
    ANumber varchar(25),
    AStreet varchar(25),
    ACity varchar(25),
    Email varchar(50),
    NICNo varchar(10) not null,
    Title varchar(4),
    CMobile int(10),
    CHome int(10),
    IsLocal bool,
    isDeleted bool default false
);

create table Doctor
(
	DID int Primary Key auto_increment,
    Title varchar(7),
     FName varchar(15) not null,
    LName varchar(30) not null,
    Contact int(10),
     Email varchar(50),
     Fee double(8,2),
     isDeleted bool default false
);

create table Schedule
(
	SchID int primary key auto_increment,
    Date date not null,
    StartTime time not null,
    EndTime time not null,
    MaxPatients int not null,
    Status int(1), 
    DID int references Doctor(DID),
    RoomID int
);

create table Speciality
(
	SID int Primary Key auto_increment,
    Name varchar(60)
);

create table Doc_Spec
(
	DID int references Doctor(DID),
    SID int references Speciality(SID),
    Primary Key (DID,SID)
);

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

create table Room
(
	RoomID int primary key auto_increment,
    Name varchar(30) 
);

Alter table Doctor Add isDeleted bool default false after Fee;
Alter table Patient Add isDeleted bool default false after isLocal;
Alter table Schedule Add RoomID int after DID;
Alter table Doctor modify Title varchar(7);
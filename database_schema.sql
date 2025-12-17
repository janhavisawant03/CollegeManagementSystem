create database TechEventDB;
use TechEventDB;

create table students (
    StudentID int auto_increment primary key,
    StudentName varchar(100) not null,
    Department varchar(50),
    Email varchar(100) unique,
    Contact varchar(15)
);

create table Categories(
    CategoryID int auto_increment primary key,
    CategoryName varchar(50) not null
    );
    
    create table ClgEvent(
    EventID int auto_increment primary key,
    EventName varchar(50) not null,
    CategoryID int,
    EventDate date,
    Venue varchar(100),
    foreign key(CategoryID) references Categories(CategoryID)
    on update cascade on delete set null
    );
    
    create table Registrations(
     RegID int auto_increment primary key,
     StudentID int,
     EventID int,
     RegDate datetime default current_timestamp,
     foreign key(StudentID) references Students(StudentID)
     on update cascade on delete cascade,
     foreign key(EventID) references ClgEvent(EventID)
     on update cascade on delete cascade,
     unique(StudentID, EventID)
 );
 
 create table Result(
    ResultID int auto_increment primary key,
	StudentID int,
    EventID int,
    Score int,
    Position int,
    foreign key (StudentID) references Students(StudentID)
    on update cascade on delete cascade,
    foreign key (EventID) references ClgEvent(EventID)
    on update cascade on delete cascade
 );
 
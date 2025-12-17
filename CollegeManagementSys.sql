create database TechEventDB;
use TechEventDB;

create table students (
    StudentID int auto_increment primary key,
    StudentName varchar(100) not null,
    Department varchar(50),
    Email varchar(100) unique,
    Contact varchar(15)
);

insert into Students (StudentName, Department, Email, Contact)
values
('Archita Sharma', 'Computer Science', 'aaravsharma@gmail', '9876543210'),
('Aryan Patil', 'IT', 'ananya.patil@gmail', '9876543211'),
('Dhurvashree Desai', 'Electronics', 'rohan.desai@gmail', '9876543212'),
('Sana Khan', 'Computer Science', 'sana.khan@gmail', '9876543213'),
('Vikram Joshi', 'IT', 'vikram.joshi@gmail', '9876543214'),
('Priya Rao', 'Electronics', 'priya.rao@gmail', '9876543215'),
('Aditya Kulkarni', 'Mechanical', 'aditya.k@gmail', '9876543216'),
('Meera Singh', 'Computer Science', 'meera.singh@gmail', '9876543217'),
('Ishita Shah', 'IT', 'ishita.shah@gmail', '9876543218'),
('Karan Gupta', 'Mechanical', 'karan.g@gmail', '9876543219'),
('Nikhil Verma', 'Computer Science', 'nikhil.v@gmail', '9876543220'),
('Rutuja Naik', 'IT', 'rutuja.naik@gmail', '9876543221'),
('Jeet Pandya', 'Electronics', 'jeet.p@gmail', '9876543222'),
('Janhavi Sawant', 'Computer Science', 'neha.t@gmail', '9876543223'),
('jyoti Ghadge', 'Mechanical', 'omkar.g@gmail', '9876543224');

create table Categories(
    CategoryID int auto_increment primary key,
    CategoryName varchar(50) not null
    );
    
INSERT INTO Categories (CategoryName)
VALUES
('Coding'),
('Quiz'),
('Workshop'),
('AI & ML'),
('Cybersecurity');

    
create table ClgEvent(
    EventID int auto_increment primary key,
    EventName varchar(50) not null,
    CategoryID int,
    EventDate date,
    Venue varchar(100),
    foreign key(CategoryID) references Categories(CategoryID)
    on update cascade on delete set null
    );
    
INSERT INTO ClgEvent (EventName, CategoryID, EventDate, Venue)
VALUES
('Hackathon', 1, '2025-02-10', 'Auditorium'),
('Debugging Duel', 1, '2025-02-11', 'Lab 301'),
('Tech Quiz', 2, '2025-02-12', 'Hall A'),
('Cybersecurity Workshop', 5, '2025-02-13', 'Lab 201'),
('AI ML Seminar', 4, '2025-02-14', 'Conference Hall'),
('Web Design Contest', 1, '2025-02-15', 'Lab 204'),
('Python Programming', 3, '2025-02-16', 'Lab 101'),
('Robotics Workshop', 3, '2025-02-17', 'Lab 501'),
('App Dev Competition', 1, '2025-02-18', 'Lab 305'),
('Database War', 1, '2025-02-19', 'Lab 405');

 
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
 
drop table Registrations;
 
INSERT INTO Registrations (StudentID, EventID)
VALUES
(1, 1),(9,10),(3, 1),(11, 7),(5, 1),(6, 1),(7, 5),(9, 4),(10, 1),
(1, 2),(2, 1),(3, 2),(7, 2),(10, 5),(11, 2),(13, 2),(9, 6),(15, 2),
(2, 3),(4, 3),(9, 9),(7,10),(3, 7),(6, 3),(12, 9),(8, 3),(4, 1),(10, 3),(14, 8),(12, 3),(15, 6),(14, 3),
(3, 4),(6, 4),(15, 9),(7, 6),(12, 4),(8, 8),(15, 4),
(1, 5),(6, 7),(4, 5),(8, 1),(13, 5),(2, 5),(2,10),(5, 5),(1, 9),(9, 7),(8, 5),
(2, 6),(5, 2),(3, 6),(5, 6),(4,10),(9, 2),(11, 6),(13, 6),
(1, 7),(5, 8),(11,10),(14, 7),
(2, 8),(11, 8),(9, 1),
(3, 9),(15,10),(6, 9),(14,10),(10, 9);


 
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
 
 drop table Result;
 INSERT INTO Result (StudentID, EventID, Score, Position)
VALUES
-- Hackathon
(1,1,95,1),(3,1,90,2),(5,1,88,3),
-- Debugging Duel
(13,2,92,1),(7,2,89,2),(3,2,87,3),
-- Tech Quiz
(6,3,93,1),(10,3,88,2),(2,3,85,3),
-- Cybersecurity Workshop
(15,4,91,1),(9,4,87,2),(6,4,84,3),
-- AI ML Seminar
(4,5,96,1),(8,5,90,2),(1,5,85,3),
-- Web Design Contest
(11,6,94,1),(9,6,88,2),(5,6,84,3),
-- Python Programming
(6,7,97,1),(11,7,90,2),(1,7,83,3),
-- Robotics Workshop
(14,8,90,1),(5,8,86,2),(8,8,82,3),
-- App Dev Competition
(3,9,95,1),(15,9,91,2),(12,9,87,3),
-- Database War
(11,10,98,1),(14,10,92,2),(7,10,88,3);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from students;
 select * from Categories;
 select * from ClgEvent;
 select * from Registrations;
 select * from Result;

-- Which event is the most popular?
select c.EventName, count(r.StudentID) as total_students
from Registrations r
join ClgEvent c
on c.EventID= r.EventID
group by c.EventName
order by total_students desc
limit 1;

-- Which category has maximum events?
select c.CategoryName,count(e.EventName) as total_Events
from ClgEvent e
join Categories c
on c.CategoryID= e.CategoryID
group by e.CategoryID
order by total_Events desc
limit 1;

-- Which student is most active?
select s.StudentName, count(r.EventID) as total_Event_Participation
from Registrations r
join Students s
on s.StudentID= r.StudentID
group by r.StudentID
order by total_Event_Participation desc
limit 1;

-- Department-wise participation trend
select s.Department, count(r.StudentID) as total_participation
from Students s
join Registrations r
on r.StudentID= s.StudentID
group by s.Department
order by Total_participation desc;

-- Who are the consistent winners? 
select StudentName, count(r.Position) as win from Students s
join Result r
on s.StudentID= r.StudentID
where Position= 1
group by s.StudentName order by win desc;


-- Least Participated Event
select c.EventName, count(r.StudentID) as Participants
from Registrations r
join ClgEvent c on r.EventID = c.EventID
group by c.EventID
having COUNT(r.StudentID) = (
    select min(ParticipationCount)
    from(
        select count(StudentID) as ParticipationCount
        from Registrations
        group by EventID
    ) as EventCounts
);

-- Distinct events where score above 90 achieved
select distinct e.EventName , Score
from Result r
join ClgEvent e on r.EventID = e.EventID
where r.Score >= 90 order by Score desc;

-- Average score of each event
select e.EventName, avg(r.Score) as AVG_Score
from Result r
join Clgevent e
on e.EventID= r.EventID
group by r.EventID order by AVG_Score desc;

-- Category with highest engagement
select c.CategoryName, count(r.StudentID) as Total_Engagement
from Registrations r
join ClgEvent e on r.EventID = e.EventID
JOIN Categories c on c.CategoryID = e.CategoryID
group by c.CategoryID
order by Total_Engagement desc
limit 1;


-- Most Competitive Event (Highest Score Gap)
select e.EventName,
       max(r.Score) - min(r.Score) as ScoreDifference
from Result r
join ClgEvent e on e.EventID = r.EventID
group by r.EventID
order by ScoreDifference desc;

-- Students Who Consistently Score Above Average
select s.StudentName, avg(r.Score) as AvgStudentScore
from Result r
join Students s on s.StudentID = r.StudentID
group by s.StudentID
having AvgStudentScore > (
    select avg(Score) from Result
)
order by AvgStudentScore desc;

-- Students Who Registered but Never Won Any Prize
select s.StudentName
from Students s
where s.StudentID not in (
    select StudentID from Result where Position = 1
);






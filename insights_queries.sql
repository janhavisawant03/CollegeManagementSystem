use TechEventDB;

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

show search_path;
set search_path to ipl;

CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(50) UNIQUE NOT NULL,
    coach VARCHAR(50) NOT NULL,
    home_ground VARCHAR(100) NOT NULL,
    founded_year INTEGER NOT NULL,
    owner VARCHAR(50) NOT NULL
);


CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INTEGER NOT NULL REFERENCES Teams(team_id),
    role VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL,
    matches_played INTEGER NOT NULL
);


CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    match_date DATE NOT NULL,
    venue VARCHAR(100) NOT NULL,
    team1_id INTEGER NOT NULL REFERENCES Teams(team_id),
    team2_id INTEGER NOT NULL REFERENCES Teams(team_id),
    winner_team_id INTEGER REFERENCES Teams(team_id)
);

CREATE TABLE Fan_Engagement (
    engagement_id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES Matches(match_id),
    fan_id INTEGER NOT NULL,
    engagement_type VARCHAR(50) NOT NULL,
    engagement_time TIMESTAMP NOT NULL
);


select * from Fan_Engagement;

INSERT INTO Teams (team_name, coach, home_ground, founded_year, owner)
VALUES 
('Mumbai Indians', 'Mahela Jayawardene', 'Wankhede Stadium', 2008, 'Reliance Industries'),
('Chennai Super Kings', 'Stephen Fleming', 'M. A. Chidambaram Stadium', 2008, 'India Cements'),
('Royal Challengers Bangalore', 'Sanjay Bangar', 'M. Chinnaswamy Stadium', 2008, 'United Spirits'),
('Kolkata Knight Riders', 'Brendon McCullum', 'Eden Gardens', 2008, 'Red Chillies Entertainment'),
('Delhi Capitals', 'Ricky Ponting', 'Arun Jaitley Stadium', 2008, 'GMR Group & JSW Group');


select * from Teams;

INSERT INTO Players (player_name, team_id, role, age, matches_played)
VALUES 
('Rohit Sharma', 1, 'Batsman', 36, 227),
('Jasprit Bumrah', 1, 'Bowler', 30, 120),
('MS Dhoni', 2, 'Wicketkeeper-Batsman', 42, 234),
('Ravindra Jadeja', 2, 'All-Rounder', 35, 210),
('Virat Kohli', 3, 'Batsman', 35, 237),
('AB de Villiers', 3, 'Batsman', 40, 184),
('Andre Russell', 4, 'All-Rounder', 36, 140),
('Sunil Narine', 4, 'Bowler', 35, 144),
('Rishabh Pant', 5, 'Wicketkeeper-Batsman', 26, 98),
('Shikhar Dhawan', 5, 'Batsman', 38, 206);



INSERT INTO Matches (match_date, venue, team1_id, team2_id, winner_team_id)
VALUES 
('2024-04-01', 'Wankhede Stadium', 1, 2, 1),
('2024-04-05', 'M. A. Chidambaram Stadium', 2, 3, 3),
('2024-04-10', 'M. Chinnaswamy Stadium', 3, 4, 4),
('2024-04-15', 'Eden Gardens', 4, 5, 4),
('2024-04-20', 'Arun Jaitley Stadium', 5, 1, 1),
('2024-04-25', 'Wankhede Stadium', 1, 3, 3),
('2024-05-01', 'M. A. Chidambaram Stadium', 2, 5, 2),
('2024-05-05', 'M. Chinnaswamy Stadium', 3, 1, 1),
('2024-05-10', 'Eden Gardens', 4, 2, 2),
('2024-05-15', 'Arun Jaitley Stadium', 5, 4, 4);



select * from matches;


INSERT INTO Fan_Engagement (match_id, fan_id, engagement_type, engagement_time)
VALUES 
(1, 101, 'Tweet', '2024-04-01 18:30:00'),
(1, 102, 'Like', '2024-04-01 18:35:00'),
(2, 103, 'Comment', '2024-04-05 20:00:00'),
(2, 104, 'Share', '2024-04-05 20:05:00'),
(3, 105, 'Tweet', '2024-04-10 16:00:00'),
(3, 106, 'Like', '2024-04-10 16:05:00'),
(4, 107, 'Comment', '2024-04-15 21:00:00'),
(4, 108, 'Share', '2024-04-15 21:10:00'),
(5, 109, 'Tweet', '2024-04-20 19:00:00'),
(5, 110, 'Like', '2024-04-20 19:05:00'),
(6, 111, 'Comment', '2024-04-25 20:00:00'),
(6, 112, 'Share', '2024-04-25 20:10:00'),
(7, 113, 'Tweet', '2024-05-01 18:00:00'),
(7, 114, 'Like', '2024-05-01 18:05:00'),
(8, 115, 'Comment', '2024-05-05 19:30:00'),
(8, 116, 'Share', '2024-05-05 19:35:00'),
(9, 117, 'Tweet', '2024-05-10 20:30:00'),
(9, 118, 'Like', '2024-05-10 20:35:00'),
(10, 119, 'Comment', '2024-05-15 21:45:00'),
(10, 120, 'Share', '2024-05-15 21:50:00');

select * from Fan_Engagement;

-- 1. Retrieve the Details of All Matches Played at a Specific Venue &#39;Wankhede
-- Stadium&#39;
-- --Objective: Get details of all matches played at a specific venue (e.g., &#39;Wankhede Stadium&#39;).


SELECT * 
FROM Matches 
WHERE venue = 'Wankhede Stadium';

-- 2. List the Players Who Are Older Than 30 Years and Have Played More Than 200
-- Matches
-- Objective: List players older than 30 years who have played more than 200 matches.

-- select * from Players where player_id=@pid;

SELECT player_name, age, matches_played 
FROM Players 
WHERE age > 30 AND matches_played > 200;

-- 3. Display the Number of Matches Played with title &quot;Number of Matches&quot; at
-- Each Venue
-- Objective : Display the Number of Matches Played and along with Venue


SELECT *
FROM Players 
WHERE age > 30 AND matches_played > 200;




SELECT venue AS "Venue", COUNT(*) AS "Number of Matches"
FROM Matches
GROUP BY venue;







SELECT M.match_id, M.match_date, M.venue, T.team_name AS "Winner_Team", (SELECT team_name FROM Teams WHERE team_name  ILIKE 'Mumbai Indians') AS "Participating_Team" FROM matches AS M
    JOIN teams AS T 
    ON M.winner_team_id = T.team_id
    where M.winner_team_id != 1 AND (M.team1_id = 1 or M.team2_id = 1);


-- ==================================================================================================================
-- 1.     Find the player who participated in the highest number of winning matches. Display the Player Name along with the total number of winning matches .


select P.player_name, count(M.match_id) as total_winning_matches
from Players P
join Matches M on P.team_id = M.winner_team_id
group by P.player_name
order by total_winning_matches desc
limit 1;

-- 2.     Determine the venue with the highest number of matches played and the total fan engagements at that venue. Display the Venue , Total Matches , Total Fan Engagements.

select M.venue, 
       count(M.match_id) as total_matches, 
       count(F.engagement_id) as total_fan_engagements
from Matches M
left join Fan_Engagement F on M.match_id = F.match_id
group by M.venue
order by total_matches desc
limit 1;

-- 3.     Find the player who has the most fan engagements across all matches.Display the player name and the count of fan engagements .

select P.player_name, 
       count(F.engagement_id) as total_fan_engagements
from Players P
join Matches M on P.team_id = M.team1_id or P.team_id = M.team2_id
join Fan_Engagement F on M.match_id = F.match_id
group by P.player_name
order by total_fan_engagements desc
limit 1;

select P.player_name, 
       count(F.engagement_id) as total_fan_engagements
from Players P
join Matches M on P.team_id = M.team1_id or P.team_id = M.team2_id
join Fan_Engagement F on M.match_id = F.match_id
group by P.player_name
order by total_fan_engagements desc
;



-- 4.     Write an SQL query to find out which stadium and match had the highest fan engagement. The query should return the stadium name, match date, and the total number of fan engagements for that match, ordered by the latest match date .

select M.venue, 
       M.match_date, 
    count(F.engagement_id) as total_fan_engagements
from Matches M
join Fan_Engagement F on M.match_id = F.match_id
group by M.venue, M.match_date, M.match_id
order by total_fan_engagements desc, M.match_date desc
limit 1;



-- 5.     Generate a report for the "Mumbai Indians" that includes details for each match they played:

-- a.      Match date.

-- b.     Opposing team's name.

-- c.      Venue.

-- d.     Total number of fan engagements recorded during each match.

-- e.      Name of the player from "Mumbai Indians" who has played the most matches up to the date of each match.






select m.match_date,
    case  when m.team1_id = mi.team_id then t2.team_name else t1.team_name
    end as opposing_team,
    m.venue, count(f.engagement_id) as total_fan_engagements,
    p.player_name as top_player
from Matches m
join Teams mi on m.team1_id = mi.team_id or m.team2_id = mi.team_id
left join Teams t1 on m.team1_id = t1.team_id
left join Teams t2 on m.team2_id = t2.team_id
left join Fan_Engagement f on m.match_id = f.match_id
join Players p on p.team_id = mi.team_id
where mi.team_name = 'Mumbai Indians'
group by m.match_date, opposing_team, m.venue, p.player_name
order by m.match_date;

-- =============================================================================================================
-- 1.     Create a view named TopPerformers that shows the names of players, their teams, and the number of matches they have played, filtering only those who have played more than 100 matches.

create view TopPerformers as
select 
    P.player_name,
    T.team_name,
    P.matches_played
from 
    Players P
join 
    Teams T on P.team_id = T.team_id
where 
    P.matches_played > 100;



select * from TopPerformers;


-- 2.     Create a view named MatchHighlights that displays the match date, teams involved, venue, and the winner of each match.

create view MatchHighlights as
select 
    M.match_date,
    T1.team_name as team1_name,
    T2.team_name as team2_name,
    M.venue,
    case 
        when M.winner_team_id = T1.team_id then T1.team_name
        when M.winner_team_id = T2.team_id then T2.team_name
        else 'No Winner'
    end as winner
from Matches M
join Teams T1 on M.team1_id = T1.team_id
join Teams T2 on M.team2_id = T2.team_id;


select * from MatchHighlights;



-- 3.     Create a view named FanEngagementStats that summarizes the total engagements for each match, including match date and venue.




create view FanEngagementStats as
select 
    M.match_date,
    M.venue,
    count(F.engagement_id) as total_engagements
from Matches M
left join Fan_Engagement F on M.match_id = F.match_id
group by M.match_date, M.venue;

select * from FanEngagementStats;


-- 4.     Create a view named TeamPerformance that shows each team's name, the number of matches played, and the number of matches won.

create view TeamPerformance as
select 
    T.team_name,
    count(M.match_id) as matches_played,
    count(case 
              when M.winner_team_id = T.team_id then M.match_id 
              else null 
          end) as matches_won
from Teams T
left join Matches M on T.team_id = M.team1_id or T.team_id = M.team2_id
group by T.team_name;


select * from TeamPerformance;


-- 5.     Create a view named TeamEngagementSummary that summarizes fan engagements for each team per match, including:

-- Match date and venue.
-- Team names (both teams).
-- Total number of engagements for each team in each match.
-- The date of the team's most engaged match (highest engagement).
-- The fan ID who engaged the most during the team's most engaged match.


drop view if exists TeamEngagementSummary;
select * from TeamEngagementSummary;


create view TeamEngagementSummary as
    select 
        m.match_date,
        m.venue,
        t1.team_name as team1,
        t2.team_name as team2,
        sum(case when p1.team_id = m.team1_id or p2.team_id = m.team2_id then 1 else 0 end) as total_engagements,
        max(m.match_date) as most_engaged_date,
        max(f.fan_id) as most_engaged_fan_id
            from matches m
            join teams t1 on m.team1_id = t1.team_id
            join teams t2 on m.team2_id = t2.team_id
            left join fan_engagement f on m.match_id = f.match_id
            left join players p1 on p1.team_id = t1.team_id
            left join players p2 on p2.team_id = t2.team_id
            group by m.match_date, m.venue, t1.team_name, t2.team_name;





select * from ipl.Players;

select m.match_date,m.venue,t1.team_name AS Team1Name,t2.team_name AS Team2Name,
        COALESCE(COUNT(f.engagement_id), 0) AS TotalFanEngagement
        FROM ipl.matches m
        INNER JOIN ipl.teams t1 ON m.team1_id = t1.team_id
        INNER JOIN ipl.teams t2 ON m.team2_id = t2.team_id
        LEFT JOIN ipl.fan_engagement f ON m.match_id = f.match_id
        GROUP BY m.match_date, m.venue, t1.team_name, t2.team_name
        ORDER BY m.match_date;


                SELECT 
    p.player_id,
    p.player_name,
    p.matches_played,
    COALESCE(SUM(f.engagement_id), 0) AS TotalFanEngagement
FROM ipl.players p
INNER JOIN ipl.matches m ON p.team_id = m.team1_id OR p.team_id = m.team2_id
LEFT JOIN ipl.fan_engagement f ON m.match_id = f.match_id
GROUP BY p.player_id, p.player_name, p.matches_played
ORDER BY TotalFanEngagement DESC
LIMIT 5;

select * from ipl.matches;
select * from ipl.teams;

               SELECT 
    m.match_id,
    m.match_date,
    m.venue,
    t1.team_name AS Team1Name,
    t2.team_name AS Team2Name,
    wt.team_name AS WinnerTeamName
FROM ipl.matches m
INNER JOIN ipl.teams t1 ON m.team1_id = t1.team_id
INNER JOIN ipl.teams t2 ON m.team2_id = t2.team_id
LEFT JOIN ipl.teams wt ON m.winner_team_id = wt.team_id
WHERE m.match_date BETWEEN @StartDate AND @EndDate
ORDER BY m.match_date;






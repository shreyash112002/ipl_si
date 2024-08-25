using IPL2.Models;
using Npgsql;
using System.Collections.Generic;
using System.Data;
using System.Text.RegularExpressions;

namespace IPL2.DAO
{
    public class DaoImplementation : IDAO
    {

        NpgsqlConnection conn;

        public DaoImplementation(NpgsqlConnection conn)
        {
            this.conn = conn;
        }

        public async Task<Player> GetPlayerById(int id)
        {
            Player? player = new Player();
            string errorMsg = string.Empty;
            string query = @"select * from ipl.players where player_id=@pid";

            try
            {
                using (conn)
                {
                    await conn.OpenAsync();
                    NpgsqlCommand selectCommand = new NpgsqlCommand(query, conn);
                    selectCommand.CommandType = CommandType.Text;
                    selectCommand.Parameters.AddWithValue("@pid", id);
                    NpgsqlDataReader reader = await selectCommand.ExecuteReaderAsync();
                    if ((reader.HasRows))
                    {
                        while (reader.Read())
                        {
                            player.PlayerId = reader.GetInt32(0);
                            player.PlayerName = reader.GetString(1);
                            player.TeamId = reader.GetInt32(2);
                            player.Role = reader.GetString(3);
                            player.Age = reader.GetInt32(4);
                            player.MatchesPlayed = reader.GetInt32(5);
                        }
                    }
                    reader?.Close();
                }
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine("Exception: " + ex.Message);
            }
            return player;
        }

        //Problem 1: Action method to add players
        public async Task<int> InsertPlayer(Player p)
        {
            int rowInserted = 0;
            string insertQuery = $@"insert into ipl.players(player_id, player_name, team_id, role, age, matches_played) values({p.PlayerId},'{p.PlayerName}',{p.TeamId},'{p.Role}',{p.Age},{p.MatchesPlayed})";
            try
            {
                using (conn)
                {
                    await conn.OpenAsync();
                    NpgsqlCommand insertCommand = new NpgsqlCommand(insertQuery, conn);
                    insertCommand.CommandType = CommandType.Text;

                    rowInserted = await insertCommand.ExecuteNonQueryAsync();
                }
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine("Exception" + ex.Message);
            }


            return rowInserted;
        }
        public async Task<List<MatchStatistics>> GetMatchStatistics()
        {
            var matchStatistics = new List<MatchStatistics>();

            const string query = @"select m.match_date,m.venue,t1.team_name AS Team1Name,t2.team_name AS Team2Name,
        COALESCE(COUNT(f.engagement_id), 0) AS TotalFanEngagement
        FROM ipl.matches m
        INNER JOIN ipl.teams t1 ON m.team1_id = t1.team_id
        INNER JOIN ipl.teams t2 ON m.team2_id = t2.team_id
        LEFT JOIN ipl.fan_engagement f ON m.match_id = f.match_id
        GROUP BY m.match_date, m.venue, t1.team_name, t2.team_name
        ORDER BY m.match_date;";


            try
            {
                using (conn)
                {
                    await conn.OpenAsync();
                    NpgsqlCommand command = new NpgsqlCommand(query, conn);
                    command.CommandType = CommandType.Text;
                    NpgsqlDataReader reader = await command.ExecuteReaderAsync();

                    while (await reader.ReadAsync())
                    {
                        matchStatistics.Add(new MatchStatistics
                        {
                            MatchDate = reader.GetDateTime(0),
                            Venue = reader.GetString(1),
                            Team1Name = reader.GetString(2),
                            Team2Name = reader.GetString(3),
                            TotalFanEngagement = reader.GetInt32(4)
                        });
                    }
                }
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine("Exception" + ex.Message);
            }
            return matchStatistics;
        }


        public async Task<List<PlayerStatistic>> GetTopPlayersByFanEngagement()
        {
            var playerStatisticList = new List<PlayerStatistic>();
            PlayerStatistic playerStatistic = null;

            const string query = @"
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
LIMIT 5;";

            try
            {
                await conn.OpenAsync();
                NpgsqlCommand command = new NpgsqlCommand(query, conn);
                command.CommandType = CommandType.Text;
                NpgsqlDataReader reader = await command.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    playerStatistic = new PlayerStatistic();
                    playerStatistic.PlayerId = reader.GetInt32(0);
                    playerStatistic.PlayerName = reader.GetString(1);
                    playerStatistic.MatchesPlayed = reader.GetInt32(2);
                    playerStatistic.TotalFanEngagement = reader.GetInt32(3);
                    playerStatisticList.Add(playerStatistic);
                }
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine("Exception: " + ex.Message);
            }
            return playerStatisticList;
        }

        public async Task<List<Match1>> GetMatchesByDateRange(DateTime startDate, DateTime endDate)
        {
            var matchList = new List<Match1>();
            Match1 match = null;

            const string query = @"
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
ORDER BY m.match_date;";


            try
            {
                await conn.OpenAsync();
                NpgsqlCommand command = new NpgsqlCommand(query, conn);
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@StartDate", startDate);
                command.Parameters.AddWithValue("@EndDate", endDate);
                NpgsqlDataReader reader = await command.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    match = new Match1();
                    match.MatchId = reader.GetInt32(0);
                    match.MatchDate = reader.GetDateTime(1);
                    match.Venue = reader.GetString(2);
                    match.Team1Name = reader.GetString(3);
                    match.Team2Name = reader.GetString(4);
                    match.WinnerTeamName = reader.GetString(5);
                    matchList.Add(match);
                }
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine("Exception: " + ex.Message);
            }


            return matchList;
        }

    }
}

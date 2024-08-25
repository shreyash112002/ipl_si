using IPL2.Models;
using System.Text.RegularExpressions;

namespace IPL2.DAO
{
    public interface IDAO
    {
        Task<int> InsertPlayer(Player p);

        Task<Player> GetPlayerById(int id);
        Task<List<MatchStatistics>> GetMatchStatistics();

        Task<List<PlayerStatistic>> GetTopPlayersByFanEngagement();

        Task<List<Match1>> GetMatchesByDateRange(DateTime startDate, DateTime endDate);



        //IEnumerable<MatchStatistics> GetMatchStatistics(); 
        //Task<IEnumerable<MatchStatistics>> GetMatchStatisticsAsync();

        //void InsertPlayer(Player player);
        //IEnumerable<MatchStatistics> GetMatchStatistics();
        //IEnumerable<Player> GetTopPlayersWithHighestFanEngagements();
        //IEnumerable<Match> GetMatchesByDateRange(DateTime startDate, DateTime endDate);
    }
}

using Microsoft.AspNetCore.Mvc;
using IPL2.DAO; 
using IPL2.Models;
namespace IPL2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IPLController : ControllerBase
    {

        private readonly IDAO _iplDao;

        public IPLController(IDAO iplDao)
        {
            _iplDao = iplDao;
        }

        [HttpGet("{id:int}", Name = "GetPlayerById")]
        public async Task<ActionResult<Player?>> GetPlayerById(int id)
        {
            Player? player = await _iplDao.GetPlayerById(id);
            if (player == null)
            {
                return NotFound();
            }
            return Ok(player);
        }

        [HttpPost]
        public async Task<ActionResult<int>> InsertPlayer(Player p)
        {
            if (p != null)
            {
                if (ModelState.IsValid)
                {
                    int res = await _iplDao.InsertPlayer(p);
                    if (res > 0)
                    {
                        return CreatedAtRoute(nameof(GetPlayerById), new { id = p.PlayerId }, p);

                    }
                }
                return BadRequest("Failed to add p");

            }
            else
            {
                return BadRequest();
            }
        }
        [HttpGet("MatchStatistic")]
        public async Task<ActionResult<List<MatchStatistics>>> GetMatchStatistics()
        {
            List<MatchStatistics> matchStatistic = await _iplDao.GetMatchStatistics();
            if (matchStatistic == null)
            {
                return NotFound();
            }
            return Ok(matchStatistic);
        }

        [HttpGet("TopPlayer")]
        public async Task<ActionResult<List<PlayerStatistic>>> GetTopPlayerByFanEngagement()
        {
            List<PlayerStatistic> playerStatistic = await _iplDao.GetTopPlayersByFanEngagement();
            if (playerStatistic == null)
            {
                return NotFound();
            }
            return Ok(playerStatistic);
        }

        [HttpGet("MatchByRange")]
        public async Task<IActionResult> GetMatchesByDateRange([FromQuery] DateTime startDate, [FromQuery] DateTime endDate)
        {
            var matches = await _iplDao.GetMatchesByDateRange(startDate, endDate);
            if (matches == null)
            {
                return NotFound();
            }
            return Ok(matches);
        }


    }


   
}

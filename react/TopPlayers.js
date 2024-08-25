import { useState,useEffect } from "react"
import GetTopPlayer from "../services/GetTopPlayer"
const TopPlayer=()=>{

  const [data,setData]=useState([])
  const [loading,setLoading]=useState(true)
  const [error,setError]=useState(null)

  useEffect(()=>{
      const fetchData=async ()=>{
          const response= await GetTopPlayer()
      setData(response.data)
      setLoading(response.loading)
      setError(response.error)
      }

      fetchData();
  },[])

  if(loading) return <p>Loading</p>
  if(error) return <p>Error: {error.message}</p>

  return <>
  
  {data.length > 0 ? (
  <div>
              {data.map((player, key) => (
                  <div key={key}>
                  <ul>
                      <li>Player Id: {player.playerId}</li>
                      <li>Player Name: {player.playerName}</li>
                      <li>Matches Played: {player.matchesPlayed}</li>
                      <li>Total Fan Engagement: {player.totalFanEngagement}</li>
                  </ul>
                  </div>
              ))}      
  </div>
) : (
  <p>No stats available</p>
)}
  </>
}
export default TopPlayer;
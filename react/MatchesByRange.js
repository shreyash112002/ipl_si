// src/components/MatchesByRange.js
import React, { useEffect, useState } from 'react';
import apiClient from '../services/api';

const MatchesByRange = () => {
  const [matches, setMatches] = useState([]);

  useEffect(() => {
    const fetchMatches = async () => {
      try {
        const response = await apiClient.get('http://localhost:5081/api/IPL/MatchByRange?startDate=2024-04-15&endDate=2024-05-05');
        setMatches(response.data);
      } catch (error) {
        console.error('Failed to fetch matches by range', error);
      }
    };

    fetchMatches();
  }, []);

  return (
    <div className="matches-by-range">
      <h2>Matches By Range</h2>
      <ul>
        {matches.map(match => (
          <li key={match.matchId}>{match.matchDetail}</li>
        ))}
      </ul>
    </div>
  );
};

export default MatchesByRange;

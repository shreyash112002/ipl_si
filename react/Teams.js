// src/components/Teams.js
import React, { useEffect, useState } from 'react';
import apiClient from '../services/api';

const Teams = () => {
  const [teams, setTeams] = useState([]);

  useEffect(() => {
    const fetchTeams = async () => {
      try {
        const response = await apiClient.get('http://localhost:5081/api/IPL');
        setTeams(response.data);
      } catch (error) {
        console.error('Failed to fetch teams', error);
      }
    };

    fetchTeams();
  }, []);

  return (
    <div className="teams">
      <h2>Teams</h2>
      <ul>
        {teams.map(team => (
          <li key={team.teamId}>{team.teamName}</li>
        ))}
      </ul>
    </div>
  );
};

export default Teams;

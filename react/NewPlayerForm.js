// src/components/NewPlayerForm.js
import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { addNewPlayer } from '../store/iplSlice';

const NewPlayerForm = () => {
  const dispatch = useDispatch();

  const [playerName, setPlayerName] = useState('');
  const [teamId, setTeamId] = useState('');
  const [role, setRole] = useState('');
  const [age, setAge] = useState('');
  const [matchesPlayed, setMatchesPlayed] = useState('');
  const [errors, setErrors] = useState({});

  const validate = () => {
    let errors = {};

    if (!playerName) errors.playerName = 'Player name is required';
    if (!teamId || isNaN(teamId)) errors.teamId = 'Valid team ID is required';
    if (!role) errors.role = 'Role is required';
    if (!age || isNaN(age)) errors.age = 'Valid age is required';
    if (!matchesPlayed || isNaN(matchesPlayed)) errors.matchesPlayed = 'Valid matches played is required';

    return errors;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const validationErrors = validate();
    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    const playerData = {
      playerName,
      teamId: parseInt(teamId),
      role,
      age: parseInt(age),
      matchesPlayed: parseInt(matchesPlayed),
    };

    dispatch(addNewPlayer(playerData));

    setPlayerName('');
    setTeamId('');
    setRole('');
    setAge('');
    setMatchesPlayed('');
    setErrors({});
  };

  return (
    <div className="form-container">
      <h2>Add New Player</h2>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="playerName">Player Name:</label>
          <input
            type="text"
            id="playerName"
            value={playerName}
            onChange={(e) => setPlayerName(e.target.value)}
          />
          {errors.playerName && <p className="error">{errors.playerName}</p>}
        </div>

        <div className="form-group">
          <label htmlFor="teamId">Team ID:</label>
          <input
            type="text"
            id="teamId"
            value={teamId}
            onChange={(e) => setTeamId(e.target.value)}
          />
          {errors.teamId && <p className="error">{errors.teamId}</p>}
        </div>

        <div className="form-group">
          <label htmlFor="role">Role:</label>
          <input
            type="text"
            id="role"
            value={role}
            onChange={(e) => setRole(e.target.value)}
          />
          {errors.role && <p className="error">{errors.role}</p>}
        </div>

        <div className="form-group">
          <label htmlFor="age">Age:</label>
          <input
            type="text"
            id="age"
            value={age}
            onChange={(e) => setAge(e.target.value)}
          />
          {errors.age && <p className="error">{errors.age}</p>}
        </div>

        <div className="form-group">
          <label htmlFor="matchesPlayed">Matches Played:</label>
          <input
            type="text"
            id="matchesPlayed"
            value={matchesPlayed}
            onChange={(e) => setMatchesPlayed(e.target.value)}
          />
          {errors.matchesPlayed && <p className="error">{errors.matchesPlayed}</p>}
        </div>

        <button type="submit">Add Player</button>
      </form>
    </div>
  );
};

export default NewPlayerForm;

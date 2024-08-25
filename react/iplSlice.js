// src/store/iplSlice.js
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import apiClient from '../services/api';

export const addNewPlayer = createAsyncThunk(
  'ipl/addNewPlayer',
  async (playerData) => {
    const response = await apiClient.post('http://localhost:5081/api/IPL', playerData);
    return response.data;
  }
);

const iplSlice = createSlice({
  name: 'ipl',
  initialState: {
    playerAdded: false,
    // ... other states
  },
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(addNewPlayer.fulfilled, (state) => {
        state.playerAdded = true;
      });
  },
});

export default iplSlice.reducer;

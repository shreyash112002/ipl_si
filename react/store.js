// src/store/store.js
import { configureStore } from '@reduxjs/toolkit';
import iplReducer from './iplSlice';

export const store = configureStore({
  reducer: {
    ipl: iplReducer,
  },
});

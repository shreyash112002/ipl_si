// src/services/api.js
import axios from 'axios';

const apiClient = axios.create({
  baseURL: 'http://localhost:5081/api/IPL',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default apiClient;

import axios from 'axios';

const URL = 'http://localhost:5081/api/IPL/TopPlayer';

// Function to fetch Top Player data
const GetTopPlayer=async ()=>{
    
    try {
        const response = await axios.get(URL);
        return { data: response.data, loading: false, error: null };
    } catch (error) {
        return { data: null, loading: false, error: error };
    }
}
export default GetTopPlayer
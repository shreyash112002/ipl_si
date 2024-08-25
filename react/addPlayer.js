import axios from "axios";

const URL='http://localhost:5081/api/IPL'

const addPlayer = async (player) => {
    try {
        const response = await axios.post(URL, player);
        return { data: response.data, loading: false, error: null };
    } catch (error) {
        return { data: null, loading: false, error: error };
    }
}
export default addPlayer;
import axios from "axios";
const URL = 'http://localhost:5081/api/IPL';

const GetMatchStatistic=async ()=>{
    let url=`${URL}/MatchStatistic`
    try {
        const response = await axios.get(url);
        return { data: response.data, loading: false, error: null };
    } catch (error) {
        return { data: null, loading: false, error: error };
    }
}
export default GetMatchStatistic
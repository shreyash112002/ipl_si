import {Route,Routes,Router} from 'react-router-dom'
import PostPlayer from './PostPlayer'
import Home from './Home'
import MatchStatistic from './MatchStatistics'
import TopPlayer from './TopPlayers'

const Routing=()=>{
    return <>
    <Routes>

        <Route path='/'element={<Home/>}/>
        <Route path='/postplayer'element={<PostPlayer/>}/>
        <Route path='/matchstatics'element={<MatchStatistic/>}/>
        <Route path='/topplayers' element={<TopPlayer/>}/>

    </Routes>
    </>
}
export default Routing;
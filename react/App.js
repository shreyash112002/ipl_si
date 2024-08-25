import logo from './logo.svg';
import './App.css';
import Home from './components/Home';
import { Routes, Route,Router } from 'react-router-dom';
import Teams from './components/Teams';

// import TopPlayers from './components/TopPlayers';
import MatchesByRange from './components/MatchesByRange';
import NewPlayerForm from './components/NewPlayerForm';
import PostPlayer from './components/PostPlayer';
import MatchStatistics from './components/MatchStatistics';
import GetTopPlayer from './services/GetTopPlayer';
import TopPlayer from './components/TopPlayers';
import Routing from './components/Routing';
function App() {
  return (
    <>
    
      <div>
        <h1>IPL Stats Application</h1>
{/*         
        <Home/>
        <PostPlayer/>
        <MatchStatistics/>
        <TopPlayer/> */}
        <Routing/>
      </div>
  
       </>
  )
}

export default App;

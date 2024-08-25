import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
  return (
    <div
      className="home"
      style={{
        fontFamily: 'Arial, sans-serif',
        textAlign: 'center',
        padding: '20px',
        backgroundColor: '#f4f4f4',
      }}
    >
      <header
        className="banner"
        style={{
          backgroundColor: '#004d99',
          color: '#ffffff',
          padding: '20px',
          borderRadius: '8px',
          marginBottom: '20px',
        }}
      >
        <h1
          style={{
            fontSize: '2.5rem',
            margin: '0',
          }}
        >
          Welcome to the IPL Dashboard
        </h1>
        {/* <img
          src='ipl/src/components/ipl-share-img.png'
          alt="IPL Banner"
          className="banner-image"
          style={{
            width: '100%',
            maxWidth: '800px',
            height: 'auto',
            borderRadius: '8px',
            marginTop: '10px',
          }} */}
        {/* /> */}
      </header>
      <nav
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <h1
          style={{
            fontSize: '2rem',
            color: '#333',
            marginBottom: '20px',
          }}
        >
          IPL Marathon
        </h1>
        <ul
          style={{
            listStyleType: 'none',
            padding: '0',
          }}
        >
          <li
            style={{
              marginBottom: '10px',
            }}
          >
            <Link
              to='/postplayer'
              style={{
                textDecoration: 'none',
                color: '#004d99',
                fontSize: '1.2rem',
                fontWeight: 'bold',
              }}
            >
              Add Player
            </Link>
          </li>
          <li
            style={{
              marginBottom: '10px',
            }}
          >
            <Link
              to='/matchstatics'
              style={{
                textDecoration: 'none',
                color: '#004d99',
                fontSize: '1.2rem',
                fontWeight: 'bold',
              }}
            >
              Match Statistic
            </Link>
          </li>
          <li>
            <Link
              to='/topplayers'
              style={{
                textDecoration: 'none',
                color: '#004d99',
                fontSize: '1.2rem',
                fontWeight: 'bold',
              }}
            >
              Top Players
            </Link>
          </li>
        </ul>
      </nav>
    </div>
  );
};

export default Home;

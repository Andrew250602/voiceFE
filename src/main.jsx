// import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import { HashRouter } from 'react-router-dom' // SỬ DỤNG HashRouter
import React from 'react'
createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <HashRouter> {/* SỬ DỤNG HashRouter */}
      <App />
    </HashRouter>
  </React.StrictMode>,
)

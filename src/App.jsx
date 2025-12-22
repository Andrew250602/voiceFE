import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import './App.css'
import axios from 'axios'
function App() {
  const [count, setCount] = useState(0)
  const [message, setMessage] = useState('')
  const callBackend = async () => {
    try {
      const response = await axios.get('http://localhost:8080/api/health');
      setMessage(response.data);
    } catch (error) {
      console.error("Lỗi rồi:", error);
      setMessage("Không thể kết nối tới Backend!");
    }
  };

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>

        {/* 3. Thêm nút Call API ở đây */}
        <div style={{ marginTop: '10px' }}>
          <button onClick={callBackend} style={{ backgroundColor: '#646cff' }}>
            Call Backend Health
          </button>
        </div>

        {/* Hiển thị kết quả trả về */}
        {message && <p style={{ color: '#4caf50', fontWeight: 'bold' }}>{message}</p>}

        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  )
}

export default App
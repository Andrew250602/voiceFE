import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [
    react()
  ],
  base: '/voiceFE/', // tên Repository trên GitHub
  build: {
    outDir: 'dist', // Thư mục đầu ra
  }
})

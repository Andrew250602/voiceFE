import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: [['babel-plugin-react-compiler']],
      },
    }),
  ],
  base: '/voiceFE/',
  // KHAI BÁO RÕ RÀNG THƯ MỤC OUTPUT
  build: {
    outDir: 'dist', // Đảm bảo output folder là 'dist'
  }
})

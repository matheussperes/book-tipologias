// config.js — Credenciais do Supabase
// ⚠️  NUNCA commite este arquivo com credenciais reais no GitHub público
//     Adicione "config.js" no .gitignore se o repositório for público

const SUPABASE_URL  = 'https://dyjxmqdfzlqugdqzvuhq.supabase.co';   // substitua
const SUPABASE_ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR5anhtcWRmemxxdWdkcXp2dWhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODAwNzg2NTMsImV4cCI6MjA5NTY1NDY1M30.hGbSUqXyAGunSMevJHWSqLCmAH0Y7NOE75xhokz3IzE';                  // substitua

// Storage — URLs base para acessar imagens e documentos públicos
const STORAGE_URL = `${SUPABASE_URL}/storage/v1/object/public`;

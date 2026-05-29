// supabase.js — Módulo de integração com Supabase
// Funções CRUD para tipologias, imagens e documentos

const headers = () => ({
  'apikey': SUPABASE_ANON,
  'Authorization': `Bearer ${SUPABASE_ANON}`,
  'Content-Type': 'application/json',
  'Prefer': 'return=representation'
});

// ─── TIPOLOGIAS ────────────────────────────────────────────

async function listarTipologias(filtroTipo = null) {
  let url = `${SUPABASE_URL}/rest/v1/tipologias?select=*&order=tipo_torre,nome`;
  if (filtroTipo) url += `&tipo_torre=eq.${filtroTipo}`;

  const res = await fetch(url, { headers: headers() });
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

async function buscarTipologia(id) {
  const url = `${SUPABASE_URL}/rest/v1/tipologias?id=eq.${id}&select=*`;
  const res = await fetch(url, { headers: headers() });
  if (!res.ok) throw new Error(await res.text());
  const arr = await res.json();
  return arr[0] || null;
}

async function criarTipologia(dados) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/tipologias`, {
    method: 'POST',
    headers: headers(),
    body: JSON.stringify(dados)
  });
  if (!res.ok) throw new Error(await res.text());
  const arr = await res.json();
  return arr[0];
}

async function atualizarTipologia(id, dados) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/tipologias?id=eq.${id}`, {
    method: 'PATCH',
    headers: headers(),
    body: JSON.stringify(dados)
  });
  if (!res.ok) throw new Error(await res.text());
  const arr = await res.json();
  return arr[0];
}

async function excluirTipologia(id) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/tipologias?id=eq.${id}`, {
    method: 'DELETE',
    headers: { ...headers(), 'Prefer': 'return=minimal' }
  });
  if (!res.ok) throw new Error(await res.text());
  return true;
}

// ─── IMAGENS ───────────────────────────────────────────────

async function listarImagens(tipologiaId) {
  const url = `${SUPABASE_URL}/rest/v1/imagens?tipologia_id=eq.${tipologiaId}&order=ordem`;
  const res = await fetch(url, { headers: headers() });
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

async function uploadImagem(tipologiaId, arquivo, descricao = '', ordem = 0) {
  const ext  = arquivo.name.split('.').pop();
  const path = `${tipologiaId}/${Date.now()}.${ext}`;

  // 1) Upload do arquivo para o Storage
  const uploadRes = await fetch(`${SUPABASE_URL}/storage/v1/object/imagens/${path}`, {
    method: 'POST',
    headers: {
      'apikey': SUPABASE_ANON,
      'Authorization': `Bearer ${SUPABASE_ANON}`,
      'Content-Type': arquivo.type
    },
    body: arquivo
  });
  if (!uploadRes.ok) throw new Error(await uploadRes.text());

  // 2) Registrar URL na tabela imagens
  const url = `${STORAGE_URL}/imagens/${path}`;
  const reg = await fetch(`${SUPABASE_URL}/rest/v1/imagens`, {
    method: 'POST',
    headers: headers(),
    body: JSON.stringify({ tipologia_id: tipologiaId, url, descricao, ordem })
  });
  if (!reg.ok) throw new Error(await reg.text());
  const arr = await reg.json();
  return arr[0];
}

async function excluirImagem(id) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/imagens?id=eq.${id}`, {
    method: 'DELETE',
    headers: { ...headers(), 'Prefer': 'return=minimal' }
  });
  if (!res.ok) throw new Error(await res.text());
  return true;
}

// ─── DOCUMENTOS ────────────────────────────────────────────

async function listarDocumentos(tipologiaId) {
  const url = `${SUPABASE_URL}/rest/v1/documentos?tipologia_id=eq.${tipologiaId}&order=nome`;
  const res = await fetch(url, { headers: headers() });
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

async function uploadDocumento(tipologiaId, arquivo, nome = '') {
  const ext  = arquivo.name.split('.').pop();
  const path = `${tipologiaId}/${Date.now()}.${ext}`;

  // 1) Upload do arquivo para o Storage
  const uploadRes = await fetch(`${SUPABASE_URL}/storage/v1/object/documentos/${path}`, {
    method: 'POST',
    headers: {
      'apikey': SUPABASE_ANON,
      'Authorization': `Bearer ${SUPABASE_ANON}`,
      'Content-Type': arquivo.type
    },
    body: arquivo
  });
  if (!uploadRes.ok) throw new Error(await uploadRes.text());

  // 2) Registrar na tabela documentos
  const url       = `${STORAGE_URL}/documentos/${path}`;
  const nomeLabel = nome || arquivo.name.replace(/\.[^.]+$/, '');
  const reg = await fetch(`${SUPABASE_URL}/rest/v1/documentos`, {
    method: 'POST',
    headers: headers(),
    body: JSON.stringify({ tipologia_id: tipologiaId, url, nome: nomeLabel, tipo: ext })
  });
  if (!reg.ok) throw new Error(await reg.text());
  const arr = await reg.json();
  return arr[0];
}

async function excluirDocumento(id) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/documentos?id=eq.${id}`, {
    method: 'DELETE',
    headers: { ...headers(), 'Prefer': 'return=minimal' }
  });
  if (!res.ok) throw new Error(await res.text());
  return true;
}

// ─── HELPERS ───────────────────────────────────────────────

function tipoCorClass(tipo) {
  const map = { Slim: 'badge-slim', Compact: 'badge-compact', Plus: 'badge-plus' };
  return map[tipo] || 'badge-slim';
}

function parseArray(str) {
  // Converte string "São Paulo, Campinas" em array limpo
  if (Array.isArray(str)) return str.filter(Boolean);
  if (!str) return [];
  return str.split(',').map(s => s.trim()).filter(Boolean);
}

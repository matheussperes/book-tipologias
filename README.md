# Book de Tipologias

Painel digital de tipologias de apartamento para uso interno da equipe de incorporação.

## Setup — passo a passo (T01 a T05)

### 1. Supabase (T01 + T02 + T03)

1. Acesse [supabase.com](https://supabase.com) e crie um novo projeto
2. No **SQL Editor**, execute o conteúdo de `schema.sql`
3. Vá em **Storage > New Bucket**:
   - Crie o bucket `imagens` com **Public** ativado
   - Crie o bucket `documentos` com **Public** ativado
4. Anote a **Project URL** e a **anon public key** (em Settings > API)

### 2. Credenciais (antes de qualquer outro passo)

Abra `config.js` e substitua:

```js
const SUPABASE_URL  = 'https://SEU_PROJETO.supabase.co';
const SUPABASE_ANON = 'SUA_ANON_KEY_AQUI';
```

> ⚠️ O `config.js` está no `.gitignore` — nunca commite suas credenciais no GitHub.

### 3. Seed de dados (T09)

No Supabase SQL Editor, execute o conteúdo de `seed.sql`.
Isso popula o banco com 3 tipologias de exemplo.
**Substitua pelos dados reais antes da validação com Gabrielle.**

### 4. GitHub + Vercel (T04 + T05)

```bash
git init
git add .
git commit -m "feat: book de tipologias v1"
git remote add origin https://github.com/SEU_USUARIO/book-tipologias.git
git push -u origin main
```

No Vercel:
- Importe o repositório
- Framework: **Other** (não é React)
- Build Command: *(deixe vazio)*
- Output Directory: `.` (raiz)
- Deploy

> O `config.js` está no `.gitignore`. Para que o Vercel acesse as credenciais,
> adicione as variáveis como **Environment Variables** no Vercel OU inclua o `config.js`
> apenas no deploy (sem commitar). A opção mais simples para V1: remova o `config.js`
> do `.gitignore` temporariamente, commite uma vez, e adicione de volta.

---

## Estrutura de arquivos

```
book-tipologias/
├── index.html          ← Painel principal (lista de tipologias + filtros)
├── style.css           ← Estilos globais
├── config.js           ← Credenciais Supabase (NÃO commitar)
├── supabase.js         ← Módulo de integração com a API
├── schema.sql          ← SQL de criação das tabelas
├── seed.sql            ← Dados de exemplo (3 tipologias)
├── .gitignore
├── tipologia/
│   └── index.html      ← Ficha técnica individual
├── nova/
│   └── index.html      ← Formulário de criação E edição
└── editar/
    └── index.html      ← Redireciona para nova/?id= (rota de edição)
```

## Rotas

| URL | Função |
|-----|--------|
| `/` | Painel com todas as tipologias |
| `/tipologia/?id=UUID` | Ficha técnica de uma tipologia |
| `/nova/` | Formulário de nova tipologia |
| `/nova/?id=UUID` | Formulário de edição (mesmo componente) |

## Uso diário (Gabrielle, sem precisar de Matheus)

**Adicionar tipologia:** botão "+ Nova tipologia" no canto superior direito

**Editar:** abrir a ficha → botão "Editar"

**Excluir:** abrir a ficha → botão "Excluir" → confirmar no modal

**Filtrar por tipo de torre:** botões Slim / Compact / Plus no painel principal

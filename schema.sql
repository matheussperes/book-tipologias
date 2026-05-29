-- ============================================================
-- SCHEMA — Book de Tipologias
-- Execute este SQL no Supabase SQL Editor (T02)
-- Decisão: cidades_elegiveis e projetos_aplicados como TEXT[]
-- ============================================================

-- Tabela principal de tipologias
CREATE TABLE IF NOT EXISTS tipologias (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome         TEXT NOT NULL,
  tipo_torre   TEXT NOT NULL CHECK (tipo_torre IN ('Slim', 'Compact', 'Plus')),
  area_privada NUMERIC(8,2),
  area_total   NUMERIC(8,2),
  dormitorios  INTEGER,
  suites       INTEGER,
  vagas        INTEGER,
  diferenciais TEXT,
  cidades_elegiveis   TEXT[],
  projetos_aplicados  TEXT[],
  observacoes  TEXT,
  criado_em    TIMESTAMPTZ DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de imagens vinculadas a cada tipologia
CREATE TABLE IF NOT EXISTS imagens (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipologia_id UUID NOT NULL REFERENCES tipologias(id) ON DELETE CASCADE,
  url          TEXT NOT NULL,
  descricao    TEXT,
  ordem        INTEGER DEFAULT 0,
  criado_em    TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de documentos vinculados a cada tipologia
CREATE TABLE IF NOT EXISTS documentos (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipologia_id UUID NOT NULL REFERENCES tipologias(id) ON DELETE CASCADE,
  nome         TEXT NOT NULL,
  url          TEXT NOT NULL,
  tipo         TEXT DEFAULT 'pdf',
  criado_em    TIMESTAMPTZ DEFAULT NOW()
);

-- Índices úteis para consulta
CREATE INDEX IF NOT EXISTS idx_tipologias_tipo_torre ON tipologias(tipo_torre);
CREATE INDEX IF NOT EXISTS idx_imagens_tipologia ON imagens(tipologia_id);
CREATE INDEX IF NOT EXISTS idx_documentos_tipologia ON documentos(tipologia_id);

-- Trigger para atualizar atualizado_em automaticamente
CREATE OR REPLACE FUNCTION update_atualizado_em()
RETURNS TRIGGER AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tipologias_atualizado_em
  BEFORE UPDATE ON tipologias
  FOR EACH ROW EXECUTE FUNCTION update_atualizado_em();

-- ============================================================
-- BUCKETS DE STORAGE — execute separado no Supabase Storage
-- OU via SQL abaixo se tiver extensão storage habilitada
-- ============================================================
-- Criar manualmente no painel: Storage > New Bucket
-- Nome: "imagens"    | Público: SIM
-- Nome: "documentos" | Público: SIM
-- ============================================================

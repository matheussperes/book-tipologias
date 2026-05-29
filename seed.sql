-- ============================================================
-- SEED — 3 tipologias fictícias para desenvolvimento
-- Execute APÓS o schema.sql (T09)
-- Substitua pelos dados reais de Gabrielle antes da validação
-- ============================================================

DO $$
DECLARE
  id_slim_35   UUID := gen_random_uuid();
  id_compact_55 UUID := gen_random_uuid();
  id_plus_80   UUID := gen_random_uuid();
BEGIN

  -- TIPOLOGIA 1 — Slim Studio 35m²
  INSERT INTO tipologias (id, nome, tipo_torre, area_privada, area_total, dormitorios, suites, vagas, diferenciais, cidades_elegiveis, projetos_aplicados, observacoes)
  VALUES (
    id_slim_35,
    'Slim Studio 35',
    'Slim',
    35.00,
    42.50,
    1,
    0,
    1,
    'Pé-direito duplo na sala, varanda integrada, cozinha americana com ilha',
    ARRAY['São Paulo', 'Campinas', 'Guarulhos', 'Santo André'],
    ARRAY['Vila Mariana I', 'Pinheiros Tower', 'ABC Prime'],
    'Tipologia âncora da linha Slim. Alta absorção em regiões com público jovem e universitário.'
  );

  INSERT INTO imagens (tipologia_id, url, descricao, ordem)
  VALUES
    (id_slim_35, 'https://placehold.co/800x600/e8f0fe/3c4db5?text=Planta+Slim+35', 'Planta baixa — Slim Studio 35', 0),
    (id_slim_35, 'https://placehold.co/800x600/f3e8fe/7c3aed?text=Perspectiva+Sala', 'Perspectiva sala integrada', 1);

  INSERT INTO documentos (tipologia_id, nome, url, tipo)
  VALUES
    (id_slim_35, 'Memorial Descritivo — Slim 35', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'pdf'),
    (id_slim_35, 'Caderno de Especificações', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'pdf');

  -- TIPOLOGIA 2 — Compact 2 Dorm 55m²
  INSERT INTO tipologias (id, nome, tipo_torre, area_privada, area_total, dormitorios, suites, vagas, diferenciais, cidades_elegiveis, projetos_aplicados, observacoes)
  VALUES (
    id_compact_55,
    'Compact 2 Dorm 55',
    'Compact',
    55.00,
    65.00,
    2,
    1,
    1,
    'Suíte com closet, varanda gourmet, dormitório reversível, depósito privativo',
    ARRAY['Campinas', 'Ribeirão Preto', 'Sorocaba', 'Jundiaí', 'São José dos Campos'],
    ARRAY['Hortolândia Compact', 'Sorocaba Garden', 'Ribeirão Central'],
    'Melhor custo-benefício da linha Compact. Indicada para cidades médias com demanda familiar.'
  );

  INSERT INTO imagens (tipologia_id, url, descricao, ordem)
  VALUES
    (id_compact_55, 'https://placehold.co/800x600/e8fef0/166534?text=Planta+Compact+55', 'Planta baixa — Compact 2 Dorm 55', 0),
    (id_compact_55, 'https://placehold.co/800x600/fef3e8/c2410c?text=Varanda+Gourmet', 'Perspectiva varanda gourmet', 1),
    (id_compact_55, 'https://placehold.co/800x600/e8f8fe/0369a1?text=Suite+Closet', 'Suíte com closet', 2);

  INSERT INTO documentos (tipologia_id, nome, url, tipo)
  VALUES
    (id_compact_55, 'Memorial Descritivo — Compact 55', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'pdf');

  -- TIPOLOGIA 3 — Plus 3 Suítes 80m²
  INSERT INTO tipologias (id, nome, tipo_torre, area_privada, area_total, dormitorios, suites, vagas, diferenciais, cidades_elegiveis, projetos_aplicados, observacoes)
  VALUES (
    id_plus_80,
    'Plus 3 Suítes 80',
    'Plus',
    80.00,
    95.00,
    3,
    3,
    2,
    '3 suítes plenas, varanda dupla, lavabo, sala de jantar separada, 2 vagas cobertas',
    ARRAY['São Paulo', 'Campinas', 'Santos', 'Barueri', 'Alphaville'],
    ARRAY['Alphaville Plus', 'Santos Premium', 'Higienópolis Tower'],
    'Tipologia premium da linha Plus. Público: famílias com renda elevada, segunda moradia.'
  );

  INSERT INTO imagens (tipologia_id, url, descricao, ordem)
  VALUES
    (id_plus_80, 'https://placehold.co/800x600/fef2f2/991b1b?text=Planta+Plus+80', 'Planta baixa — Plus 3 Suítes 80', 0),
    (id_plus_80, 'https://placehold.co/800x600/fffbeb/92400e?text=Varanda+Dupla', 'Varanda dupla — vista do living', 1);

  INSERT INTO documentos (tipologia_id, nome, url, tipo)
  VALUES
    (id_plus_80, 'Memorial Descritivo — Plus 80', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'pdf'),
    (id_plus_80, 'Estudo de Viabilidade — Plus', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'pdf');

END $$;

-- Verifique se inseriu corretamente:
-- SELECT t.nome, t.tipo_torre, array_length(t.cidades_elegiveis, 1) as cidades,
--        COUNT(i.id) as imagens, COUNT(d.id) as docs
-- FROM tipologias t
-- LEFT JOIN imagens i ON i.tipologia_id = t.id
-- LEFT JOIN documentos d ON d.tipologia_id = t.id
-- GROUP BY t.id, t.nome, t.tipo_torre;

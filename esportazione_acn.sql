-- ==========================================================
-- QUERY E VIEW PER OUTPUT STRUTTURATO (CSV)
-- ==========================================================

CREATE OR REPLACE VIEW Vista_Profilo_ACN AS
SELECT 
    a.nome_asset AS "Asset_Critico",
    a.livello_criticita AS "Livello_Rischio",
    s.nome_servizio AS "Servizio_Erogato",
    f.ragione_sociale AS "Fornitore_Terza_Parte",
    r.nome_completo AS "Punto_Contatto",
    r.email AS "Email_Responsabile"
FROM Asset a
JOIN Servizio s ON a.id_servizio = s.id_servizio
JOIN Responsabile r ON a.id_responsabile = r.id_responsabile
LEFT JOIN Fornitore_Terzo f ON a.id_fornitore = f.id_fornitore;

-- Per visualizzare i dati pronti per l'esportazione:
SELECT * FROM Vista_Profilo_ACN;
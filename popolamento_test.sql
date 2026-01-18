-- ==========================================================
-- DATASET SIMULATO E SCRIPT DI TEST
-- ==========================================================

INSERT INTO Responsabile (nome_completo, ruolo, email) VALUES 
('Mario Rossi', 'CISO', 'm.rossi@azienda.it'),
('Anna Bianchi', 'IT Admin', 'a.bianchi@azienda.it');

INSERT INTO Servizio (nome_servizio, is_critico) VALUES 
('Gestione Pagamenti', TRUE),
('E-mail Aziendale', FALSE);

INSERT INTO Fornitore_Terzo (ragione_sociale, servizio_fornito) VALUES 
('CloudProvider SPA', 'Hosting Infrastruttura');

INSERT INTO Asset (nome_asset, tipo_asset, livello_criticita, id_servizio, id_responsabile, id_fornitore) VALUES 
('Database ERP', 'Software', 'Critica', 1, 1, 1),
('Router Gateway', 'Hardware', 'Alta', 1, 2, NULL);
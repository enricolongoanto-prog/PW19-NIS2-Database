-- ==========================================================
-- SCRIPT SQL: CREAZIONE SCHEMA E VERSIONING (DDL)
-- ==========================================================

-- Tabella Responsabili (Contatti per profilo ACN)
CREATE TABLE Responsabile (
    id_responsabile SERIAL PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    ruolo VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Tabella Servizi (Erogati dall'organizzazione)
CREATE TABLE Servizio (
    id_servizio SERIAL PRIMARY KEY,
    nome_servizio VARCHAR(100) NOT NULL,
    descrizione TEXT,
    is_critico BOOLEAN DEFAULT FALSE
);

-- Tabella Fornitori (Dipendenze da terzi NIS2)
CREATE TABLE Fornitore_Terzo (
    id_fornitore SERIAL PRIMARY KEY,
    ragione_sociale VARCHAR(100) NOT NULL,
    servizio_fornito VARCHAR(100),
    email_supporto VARCHAR(100)
);

-- Tabella Asset (Registro Centralizzato)
CREATE TABLE Asset (
    id_asset SERIAL PRIMARY KEY,
    nome_asset VARCHAR(100) NOT NULL,
    tipo_asset VARCHAR(50), 
    livello_criticita VARCHAR(20) CHECK (livello_criticita IN ('Bassa', 'Media', 'Alta', 'Critica')),
    id_servizio INT REFERENCES Servizio(id_servizio) ON DELETE SET NULL,
    id_responsabile INT REFERENCES Responsabile(id_responsabile) ON DELETE RESTRICT,
    id_fornitore INT REFERENCES Fornitore_Terzo(id_fornitore),
    ultima_modifica TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indici per performance richiesti dalla traccia
CREATE INDEX idx_asset_criticita ON Asset(livello_criticita);
CREATE INDEX idx_asset_servizio ON Asset(id_servizio);

-- SISTEMA DI VERSIONING/STORICO
CREATE TABLE Asset_History (
    id_history SERIAL PRIMARY KEY,
    id_asset INT,
    vecchio_stato JSONB,
    data_modifica TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    utente_modifica VARCHAR(50) DEFAULT CURRENT_USER
);

CREATE OR REPLACE FUNCTION func_log_modifiche()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Asset_History (id_asset, vecchio_stato)
    VALUES (OLD.id_asset, to_jsonb(OLD));
    NEW.ultima_modifica = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_asset_history
BEFORE UPDATE ON Asset
FOR EACH ROW EXECUTE FUNCTION func_log_modifiche();
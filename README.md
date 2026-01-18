# Project Work n. 19: Privacy e Sicurezza Aziendale

## Descrizione del Progetto
Questo database centralizzato è stato progettato per rispondere ai requisiti della direttiva **NIS2** e facilitare la compilazione dei profili **ACN**. Permette di catalogare asset critici, servizi, dipendenze da fornitori terzi e responsabilità organizzative.

## Struttura del Repository
- `schema_db.sql`: Definizione delle tabelle (3NF), indici e vincoli di integrità.
- `popolamento_test.sql`: Dataset simulato per test funzionali.
- `esportazione_acn.sql`: View SQL per l'estrazione dati in formato strutturato (CSV).
- `README.md`: Documentazione tecnica e istruzioni.

## Caratteristiche Tecniche
- **RDBMS**: PostgreSQL
- **Normalizzazione**: Terza Forma Normale (3NF) per eliminare ridondanze.
- **Versioning**: Implementato tramite Trigger e tabella di storico (`Asset_History`) in formato JSONB.
- **Integrità**: Utilizzo di chiavi esterne (FK) con policy `RESTRICT` e `SET NULL`.

## Istruzioni per il Deploy
1. Creare un database su PostgreSQL.
2. Eseguire in sequenza: `schema_db.sql` e `popolamento_test.sql`.
3. Utilizzare la View `Vista_Profilo_ACN` per generare i report.
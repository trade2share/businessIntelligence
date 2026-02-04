CREATE TABLE lieferanten (
    lieferant_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    land VARCHAR(50) NOT NULL,
    stadt VARCHAR(100) NOT NULL,
    strasse VARCHAR(150),
    plz VARCHAR(10),
    qualitaetsstufe INTEGER CHECK (qualitaetsstufe BETWEEN 1 AND 5),
    zahlungsziel_tage INTEGER,
    rabatt_prozent NUMERIC(5,2) DEFAULT 0.00,
    aktiv BOOLEAN DEFAULT TRUE,
    ansprechpartner VARCHAR(100),
    telefon VARCHAR(30),
    email VARCHAR(100),
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE materialien (
    material_id SERIAL PRIMARY KEY,
    lieferant_id INTEGER REFERENCES lieferanten(lieferant_id),
    materialname VARCHAR(100) NOT NULL,
    materialkategorie VARCHAR(50) NOT NULL,
    einheit VARCHAR(20) NOT NULL,
    einkaufspreis NUMERIC(10,2) NOT NULL,
    mindestbestand INTEGER DEFAULT 0,
    lagerbestand INTEGER DEFAULT 0,
    nachhaltigkeit_zertifikat BOOLEAN DEFAULT FALSE,
    herkunftsland VARCHAR(50),
    lieferzeit_tage INTEGER,
    aktiv BOOLEAN DEFAULT TRUE,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produkte (
    produkt_id SERIAL PRIMARY KEY,
    produktname VARCHAR(150) NOT NULL,
    produktkategorie VARCHAR(50) NOT NULL,
    produktlinie VARCHAR(50),
    verkaufspreis NUMERIC(10,2) NOT NULL,
    herstellkosten NUMERIC(10,2) NOT NULL,
    gewicht_kg NUMERIC(8,2),
    masse_lxbxh VARCHAR(50),
    farbe VARCHAR(50),
    material_haupttyp VARCHAR(50),
    lagerbestand INTEGER DEFAULT 0,
    mindestbestand INTEGER DEFAULT 5,
    aktiv BOOLEAN DEFAULT TRUE,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stueckliste (
    stueckliste_id SERIAL PRIMARY KEY,
    produkt_id INTEGER NOT NULL REFERENCES produkte(produkt_id) ON DELETE CASCADE,
    material_id INTEGER NOT NULL REFERENCES materialien(material_id),
    menge NUMERIC(10,3) NOT NULL CHECK (menge > 0),
    einheit VARCHAR(20) NOT NULL,
    bemerkung TEXT,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(produkt_id, material_id)
);

CREATE TABLE bestellungen (
    bestell_id SERIAL PRIMARY KEY,
    kundennummer VARCHAR(20) NOT NULL,
    kundenname VARCHAR(100) NOT NULL,
    kundenkategorie VARCHAR(30),
    bestelldatum DATE NOT NULL DEFAULT CURRENT_DATE,
    lieferdatum DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'Offen',
    gesamtwert NUMERIC(12,2) DEFAULT 0.00,
    zahlungsbedingung VARCHAR(30),
    versandkosten NUMERIC(8,2) DEFAULT 0.00,
    rabatt_prozent NUMERIC(5,2) DEFAULT 0.00,
    land VARCHAR(50) NOT NULL,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bestellpositionen (
    position_id SERIAL PRIMARY KEY,
    bestell_id INTEGER NOT NULL REFERENCES bestellungen(bestell_id) ON DELETE CASCADE,
    produkt_id INTEGER NOT NULL REFERENCES produkte(produkt_id),
    menge INTEGER NOT NULL CHECK (menge > 0),
    einzelpreis NUMERIC(10,2) NOT NULL,
    positionswert NUMERIC(12,2) NOT NULL,
    rabatt_prozent NUMERIC(5,2) DEFAULT 0.00,
    lieferstatus VARCHAR(30) DEFAULT 'Offen',
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geaendert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(bestell_id, produkt_id)
);
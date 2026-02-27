CREATE TABLE dw_materialien (
    dw_id SERIAL PRIMARY KEY,
    material_id INT,
    materialname VARCHAR(255),
    einkaufspreis NUMERIC,
    gueltig_von TIMESTAMP,
    gueltig_bis TIMESTAMP
);

CREATE TABLE dw_produkte (
    dw_id SERIAL PRIMARY KEY,
    produkt_id INT,
    produktname VARCHAR(255),
    verkaufspreis NUMERIC,
    herstellkosten NUMERIC,
    gueltig_von TIMESTAMP,
    gueltig_bis TIMESTAMP
);

CREATE TABLE dw_bestellungen (
    dw_id SERIAL PRIMARY KEY,
    bestell_id INT,
    kundennummer VARCHAR(255),
    bestelldatum DATE,
    status VARCHAR(50),
    gueltig_von TIMESTAMP,
    gueltig_bis TIMESTAMP
);

CREATE TABLE dw_stueckliste (
    dw_id SERIAL PRIMARY KEY,
    stueckliste_id INT,
    produkt_id INT,
    material_id INT,
    menge NUMERIC,
    einheit VARCHAR(50),
    gueltig_von TIMESTAMP,
    gueltig_bis TIMESTAMP
);

CREATE TABLE dw_bestellpositionen (
    dw_id SERIAL PRIMARY KEY,
    position_id INT,
    bestell_id INT,
    produkt_id INT,
    menge INT,
    einzelpreis NUMERIC,
    gueltig_von TIMESTAMP,
    gueltig_bis TIMESTAMP
);
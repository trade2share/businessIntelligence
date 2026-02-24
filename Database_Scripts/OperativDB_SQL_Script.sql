DROP TABLE IF EXISTS BESTELLPOSITIONEN;
DROP TABLE IF EXISTS STUECKLISTE;
DROP TABLE IF EXISTS BESTELLUNGEN;
DROP TABLE IF EXISTS PRODUKTE;
DROP TABLE IF EXISTS MATERIALIEN;

CREATE TABLE MATERIALIEN (
    material_id INT PRIMARY KEY,
    materialname VARCHAR(255),
    einkaufspreis NUMERIC
);

CREATE TABLE PRODUKTE (
    produkt_id INT PRIMARY KEY,
    produktname VARCHAR(255),
    verkaufspreis NUMERIC,
    herstellkosten NUMERIC
);

CREATE TABLE BESTELLUNGEN (
    bestell_id INT PRIMARY KEY,
    kundennummer VARCHAR(255),
    bestelldatum DATE,
    status VARCHAR(50)
);

CREATE TABLE STUECKLISTE (
    stueckliste_id INT PRIMARY KEY,
    produkt_id INT,
    material_id INT,
    menge NUMERIC,
    einheit VARCHAR(50),
    FOREIGN KEY (produkt_id) REFERENCES PRODUKTE(produkt_id),
    FOREIGN KEY (material_id) REFERENCES MATERIALIEN(material_id)
);

CREATE TABLE BESTELLPOSITIONEN (
    position_id INT PRIMARY KEY,
    bestell_id INT,
    produkt_id INT,
    menge INT,
    einzelpreis NUMERIC,
    FOREIGN KEY (bestell_id) REFERENCES BESTELLUNGEN(bestell_id),
    FOREIGN KEY (produkt_id) REFERENCES PRODUKTE(produkt_id)
);
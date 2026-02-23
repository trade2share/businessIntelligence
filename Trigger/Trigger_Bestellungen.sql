CREATE OR REPLACE FUNCTION trg_bestellungen_hist()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO dw_bestellungen (bestell_id, kundennummer, bestelldatum, status, gueltig_von, gueltig_bis)
        VALUES (NEW.bestell_id, NEW.kundennummer, NEW.bestelldatum, NEW.status, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE dw_bestellungen
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE bestell_id = OLD.bestell_id AND gueltig_bis = '9999-12-31 23:59:59';
        
        INSERT INTO dw_bestellungen (bestell_id, kundennummer, bestelldatum, status, gueltig_von, gueltig_bis)
        VALUES (NEW.bestell_id, NEW.kundennummer, NEW.bestelldatum, NEW.status, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE dw_bestellungen
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE bestell_id = OLD.bestell_id AND gueltig_bis = '9999-12-31 23:59:59';
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_bestellungen ON BESTELLUNGEN;
CREATE TRIGGER trg_bestellungen
AFTER INSERT OR UPDATE OR DELETE ON BESTELLUNGEN
FOR EACH ROW EXECUTE FUNCTION trg_bestellungen_hist();
CREATE OR REPLACE FUNCTION trg_stueckliste_hist()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO dw_stueckliste (stueckliste_id, produkt_id, material_id, menge, einheit, gueltig_von, gueltig_bis)
        VALUES (NEW.stueckliste_id, NEW.produkt_id, NEW.material_id, NEW.menge, NEW.einheit, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE dw_stueckliste
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE stueckliste_id = OLD.stueckliste_id AND gueltig_bis = '9999-12-31 23:59:59';
        
        INSERT INTO dw_stueckliste (stueckliste_id, produkt_id, material_id, menge, einheit, gueltig_von, gueltig_bis)
        VALUES (NEW.stueckliste_id, NEW.produkt_id, NEW.material_id, NEW.menge, NEW.einheit, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE dw_stueckliste
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE stueckliste_id = OLD.stueckliste_id AND gueltig_bis = '9999-12-31 23:59:59';
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_stueckliste ON STUECKLISTE;
CREATE TRIGGER trg_stueckliste
AFTER INSERT OR UPDATE OR DELETE ON STUECKLISTE
FOR EACH ROW EXECUTE FUNCTION trg_stueckliste_hist();
CREATE OR REPLACE FUNCTION trg_produkte_hist()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO dw_produkte (produkt_id, produktname, verkaufspreis, herstellkosten, gueltig_von, gueltig_bis)
        VALUES (NEW.produkt_id, NEW.produktname, NEW.verkaufspreis, NEW.herstellkosten, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE dw_produkte
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE produkt_id = OLD.produkt_id AND gueltig_bis = '9999-12-31 23:59:59';
        
        INSERT INTO dw_produkte (produkt_id, produktname, verkaufspreis, herstellkosten, gueltig_von, gueltig_bis)
        VALUES (NEW.produkt_id, NEW.produktname, NEW.verkaufspreis, NEW.herstellkosten, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE dw_produkte
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE produkt_id = OLD.produkt_id AND gueltig_bis = '9999-12-31 23:59:59';
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_produkte ON PRODUKTE;
CREATE TRIGGER trg_produkte
AFTER INSERT OR UPDATE OR DELETE ON PRODUKTE
FOR EACH ROW EXECUTE FUNCTION trg_produkte_hist();
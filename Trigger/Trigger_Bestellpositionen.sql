CREATE OR REPLACE FUNCTION trg_bestellpositionen_hist()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO dw_bestellpositionen (position_id, bestell_id, produkt_id, menge, einzelpreis, gueltig_von, gueltig_bis)
        VALUES (NEW.position_id, NEW.bestell_id, NEW.produkt_id, NEW.menge, NEW.einzelpreis, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
        
    ELSIF (TG_OP = 'UPDATE') THEN
       
        IF (OLD.* IS DISTINCT FROM NEW.*) THEN
        
            UPDATE dw_bestellpositionen
            SET gueltig_bis = CURRENT_TIMESTAMP
            WHERE position_id = OLD.position_id AND gueltig_bis = '9999-12-31 23:59:59';
            
            INSERT INTO dw_bestellpositionen (position_id, bestell_id, produkt_id, menge, einzelpreis, gueltig_von, gueltig_bis)
            VALUES (NEW.position_id, NEW.bestell_id, NEW.produkt_id, NEW.menge, NEW.einzelpreis, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
            
        END IF;
        RETURN NEW;
        
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE dw_bestellpositionen
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE position_id = OLD.position_id AND gueltig_bis = '9999-12-31 23:59:59';
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_bestellpositionen ON BESTELLPOSITIONEN;
CREATE TRIGGER trg_bestellpositionen
AFTER INSERT OR UPDATE OR DELETE ON BESTELLPOSITIONEN
FOR EACH ROW EXECUTE FUNCTION trg_bestellpositionen_hist();
CREATE OR REPLACE FUNCTION trg_materialien_hist()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO dw_materialien (material_id, materialname, einkaufspreis, gueltig_von, gueltig_bis)
        VALUES (NEW.material_id, NEW.materialname, NEW.einkaufspreis, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE dw_materialien
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE material_id = OLD.material_id AND gueltig_bis = '9999-12-31 23:59:59';
        
        INSERT INTO dw_materialien (material_id, materialname, einkaufspreis, gueltig_von, gueltig_bis)
        VALUES (NEW.material_id, NEW.materialname, NEW.einkaufspreis, CURRENT_TIMESTAMP, '9999-12-31 23:59:59');
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE dw_materialien
        SET gueltig_bis = CURRENT_TIMESTAMP
        WHERE material_id = OLD.material_id AND gueltig_bis = '9999-12-31 23:59:59';
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_materialien ON MATERIALIEN;
CREATE TRIGGER trg_materialien
AFTER INSERT OR UPDATE OR DELETE ON MATERIALIEN
FOR EACH ROW EXECUTE FUNCTION trg_materialien_hist();
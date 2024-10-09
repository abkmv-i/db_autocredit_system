CREATE OR REPLACE FUNCTION update_interest_rate_on_dealer_update()
RETURNS TRIGGER AS $$
DECLARE
    base_rate NUMERIC := 15;
BEGIN
    RAISE NOTICE 'Триггер update_interest_rate_on_dealer_update сработал для id: %', NEW.id;

    UPDATE LoanConditions
    SET interest_rate = base_rate
        - CASE WHEN EXISTS (SELECT 1 FROM Dealers WHERE id = NEW.id AND sale) THEN 1 ELSE 0 END
        - CASE WHEN EXISTS (SELECT 1 FROM Cars WHERE dealer_id = NEW.id AND EXISTS (SELECT 1 FROM ModelCars WHERE id = model_id AND sale)) THEN 1 ELSE 0 END
        - CASE WHEN EXISTS (SELECT 1 FROM Treaty WHERE car_id IN (SELECT id FROM Cars WHERE dealer_id = NEW.id) AND EXISTS (SELECT 1 FROM Insurances WHERE id = insurance_id AND sale)) THEN 1 ELSE 0 END
        - CASE WHEN EXISTS (SELECT 1 FROM Treaty WHERE car_id IN (SELECT id FROM Cars WHERE dealer_id = NEW.id) AND (SELECT loan_term FROM LoanConditions WHERE id = loan_conditional_id) >= 60) THEN 1 ELSE 0 END
    WHERE id IN (
        SELECT loan_conditional_id
        FROM Treaty
        WHERE car_id IN (SELECT id FROM Cars WHERE dealer_id = NEW.id)
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER dealer_sale_update
AFTER UPDATE OF sale ON Dealers
FOR EACH ROW
EXECUTE FUNCTION update_interest_rate_on_dealer_update();

CREATE OR REPLACE FUNCTION update_interest_rate_on_insurance_update()
RETURNS TRIGGER AS $$
DECLARE
    base_rate NUMERIC := 15;
BEGIN
    RAISE NOTICE 'Триггер update_interest_rate_on_insurance_update сработал для id: %', NEW.id;

    UPDATE LoanConditions
    SET interest_rate = base_rate
        - CASE WHEN EXISTS (SELECT 1 FROM ModelCars WHERE id = (SELECT model_id FROM Cars WHERE id IN (SELECT car_id FROM Treaty WHERE insurance_id = NEW.id) LIMIT 1) AND sale) THEN 1 ELSE 0 END
        - CASE WHEN EXISTS (SELECT 1 FROM Dealers WHERE id = (SELECT dealer_id FROM Cars WHERE id IN (SELECT car_id FROM Treaty WHERE insurance_id = NEW.id) LIMIT 1) AND sale) THEN 1 ELSE 0 END
        - CASE WHEN NEW.sale THEN 1 ELSE 0 END
        - CASE WHEN EXISTS (SELECT 1 FROM Treaty WHERE insurance_id = NEW.id AND (SELECT loan_term FROM LoanConditions WHERE id = loan_conditional_id) >= 60) THEN 1 ELSE 0 END
    WHERE id IN (
        SELECT loan_conditional_id
        FROM Treaty
        WHERE insurance_id = NEW.id
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insurance_sale_update
AFTER UPDATE OF sale ON Insurances
FOR EACH ROW
EXECUTE FUNCTION update_interest_rate_on_insurance_update();

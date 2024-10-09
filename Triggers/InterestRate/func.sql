CREATE OR REPLACE FUNCTION calculate_interest_rate()
RETURNS TRIGGER AS $$
DECLARE
    base_rate NUMERIC := 15;
    total_discount NUMERIC := 0;
    dealer_sale BOOLEAN;
    model_sale BOOLEAN;
    insurance_sale BOOLEAN;
    loan_term INT;
BEGIN
    RAISE NOTICE 'Триггер calculate_interest_rate сработал для id: %', NEW.id;

    SELECT lc.loan_term INTO loan_term
    FROM LoanConditions lc
    WHERE lc.id = NEW.loan_conditional_id;

    SELECT d.sale INTO dealer_sale
    FROM Dealers d
    WHERE d.id = (SELECT c.dealer_id FROM Cars c WHERE c.id = NEW.car_id);

    IF dealer_sale IS NOT NULL AND dealer_sale THEN
        total_discount := total_discount + 1;
    END IF;

    SELECT mc.sale INTO model_sale
    FROM ModelCars mc
    WHERE mc.id = (SELECT c.model_id FROM Cars c WHERE c.id = NEW.car_id);

    IF model_sale IS NOT NULL AND model_sale THEN
        total_discount := total_discount + 1;
    END IF;

    SELECT i.sale INTO insurance_sale
    FROM Insurances i
    WHERE i.id = NEW.insurance_id;

    IF insurance_sale IS NOT NULL AND insurance_sale THEN
        total_discount := total_discount + 1;
    END IF;

    IF loan_term >= 60 THEN
        total_discount := total_discount + 1;
    END IF;

    UPDATE LoanConditions
    SET interest_rate = base_rate - total_discount
    WHERE id = NEW.loan_conditional_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

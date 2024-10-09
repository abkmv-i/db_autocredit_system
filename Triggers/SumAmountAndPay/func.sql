CREATE OR REPLACE FUNCTION update_loan_data()
RETURNS TRIGGER AS $$
DECLARE
    car_price NUMERIC;
BEGIN
    RAISE NOTICE 'Триггер update_loan_data сработал для id: %', NEW.id;
    SELECT cost INTO car_price
    FROM Cars
    WHERE id = (SELECT car_id FROM Treaty WHERE loan_conditional_id = NEW.id);

    IF NEW.interest_rate > 0 THEN
        NEW.total_loan_amount := (car_price + (car_price / NEW.interest_rate)) - NEW.down_payment;
    ELSE
        NEW.total_loan_amount := car_price - NEW.down_payment;
    END IF;

    IF NEW.loan_term > 0 THEN
        NEW.monthly_payment := (NEW.total_loan_amount) / NEW.loan_term;
    ELSE
        NEW.monthly_payment := NEW.total_loan_amount;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

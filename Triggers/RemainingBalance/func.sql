CREATE OR REPLACE FUNCTION update_remaining_balance()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Триггер update_remaining_balance сработал для id: %', NEW.id;

    UPDATE RepaymentSchedules
    SET remaining_balance = COALESCE(remaining_balance, 0) - NEW.amount
    WHERE id = NEW.repayment_shedules_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

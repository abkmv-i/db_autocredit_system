CREATE OR REPLACE FUNCTION set_initial_remaining_balance()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Триггер set_initial_remaining_balance сработал для id: %', NEW.id;
    UPDATE RepaymentSchedules
    SET remaining_balance = (
        SELECT lc.total_loan_amount
        FROM LoanConditions lc
        WHERE lc.id = NEW.loan_conditional_id
    )
    WHERE id = NEW.repayment_shedules_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

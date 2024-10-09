CREATE OR REPLACE FUNCTION check_delayed_payments()
RETURNS VOID AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT p.borrower_id, p.id AS repayment_schedule_id
        FROM RepaymentSchedules p
        LEFT JOIN Payments pay ON p.id = pay.repayment_shedules_id
        WHERE p.date < CURRENT_DATE
        AND pay.id IS NULL
    LOOP
        INSERT INTO BlackLists (reason)
        VALUES ('Платеж просрочен');

        UPDATE People
        SET black_list_id = (SELECT MAX(id) FROM BlackLists)
        WHERE id = (SELECT borrower_id FROM Treaty WHERE id = r.repayment_schedule_id);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

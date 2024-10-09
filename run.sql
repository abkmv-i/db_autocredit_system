\i drop.sql
\i create.sql
\i triggers.sql
\i insert.sql


SELECT
    rs.id AS repayment_schedule_id,
    rs.date AS repayment_date,
    rs.remaining_balance,
    COALESCE(p.amount, 0) AS payment_amount,
    CASE
        WHEN p.amount IS NOT NULL THEN 'Paid'
        ELSE 'Not Paid'
    END AS payment_status,
    lc.total_loan_amount,
    lc.interest_rate,
    lc.down_payment,
    lc.monthly_payment,
    b.id AS borrower_id,
    CONCAT(bp.surname, ' ', bp.name) AS borrower_name
FROM
    RepaymentSchedules rs
JOIN
    Treaty t ON rs.id = t.repayment_shedules_id
JOIN
    LoanConditions lc ON t.loan_conditional_id = lc.id
JOIN
    Borrowers b ON t.borrower_id = b.id
JOIN
    People bp ON b.people_id = bp.id
LEFT JOIN
    Payments p ON p.repayment_shedules_id = rs.id
WHERE
    lc.id = 1;

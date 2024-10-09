CREATE TRIGGER update_loan_data_on_change
BEFORE UPDATE OF interest_rate, loan_term ON LoanConditions
FOR EACH ROW
EXECUTE FUNCTION update_loan_data();

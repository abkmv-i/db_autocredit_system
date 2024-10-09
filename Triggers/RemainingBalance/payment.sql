CREATE TRIGGER update_remaining_balance_on_payment
BEFORE INSERT ON Payments
FOR EACH ROW
EXECUTE FUNCTION update_remaining_balance();

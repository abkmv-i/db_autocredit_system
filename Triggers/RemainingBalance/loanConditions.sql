CREATE TRIGGER set_remaining_balance_on_creation
AFTER INSERT ON Treaty
FOR EACH ROW
EXECUTE FUNCTION set_initial_remaining_balance();

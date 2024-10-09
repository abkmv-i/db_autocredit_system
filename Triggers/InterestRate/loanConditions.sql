CREATE TRIGGER calculate_interest_trigger
AFTER INSERT OR UPDATE ON Treaty
FOR EACH ROW EXECUTE FUNCTION calculate_interest_rate();

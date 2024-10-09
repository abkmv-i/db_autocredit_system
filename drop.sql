-- Удаление таблиц, зависимых от других
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Treaty;
DROP TABLE IF EXISTS RepaymentSchedules;
DROP TABLE IF EXISTS Borrowers;
DROP TABLE IF EXISTS Documents;
DROP TABLE IF EXISTS Cars;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS LoanConditions;
DROP TABLE IF EXISTS Insurances;
DROP TABLE IF EXISTS ModelCars;
DROP TABLE IF EXISTS Dealers;
DROP TABLE IF EXISTS BlackLists;
DROP TABLE IF EXISTS Company;

-- Удаление типов ENUM
DROP TYPE IF EXISTS loan_type;
DROP TYPE IF EXISTS loan_status;
DROP TYPE IF EXISTS insurance_type;
DROP TYPE IF EXISTS document_status;
DROP TYPE IF EXISTS type_document;


DELETE FROM Payments;
DELETE FROM RepaymentSchedules;
DELETE FROM Documents;
DELETE FROM Borrowers;
DELETE FROM People;
DELETE FROM Cars;
DELETE FROM Insurances;
DELETE FROM ModelCars;
DELETE FROM Dealers;
DELETE FROM BlackLists;
DELETE FROM Company;
DELETE FROM LoanConditions;


INSERT INTO BlackLists (reason) VALUES ('Previous default on loan');

INSERT INTO Company (name) VALUES
('Toyota'),
('Ford'),
('Honda'),
('Nissan'),
('BMW'),
('Mercedes'),
('Volkswagen'),
('Chevrolet'),
('Kia'),
('Hyundai');

INSERT INTO Dealers (name, special_conditions, sale) VALUES
('Dealer A', 'Special financing options available', true),
('Dealer B', 'None', false),
('Dealer C', 'Low down payment', true);

INSERT INTO ModelCars (company_id, name, sale) VALUES
(1, 'Camry', true),
(1, 'Corolla', true),
(1, 'RAV4', false),
(2, 'Focus', true),
(2, 'Mustang', true),
(3, 'Civic', true),
(3, 'Accord', false),
(4, 'Altima', true),
(4, 'Maxima', false),
(5, 'X5', true);

INSERT INTO Cars (model_id, year, cost, dealer_id) VALUES
(1, 2020, 30000, 1),
(2, 2021, 25000, 1),
(3, 2022, 20000, 2),
(4, 2020, 22000, 3),
(5, 2021, 35000, 3),
(2, 2023, 28000, 1),
(2, 2021, 30000, 2),
(5, 2022, 40000, 3),
(1, 2023, 45000, 1),
(3, 2020, 32000, 2);

INSERT INTO Insurances (insurance_type, cost, expiration_date, sale) VALUES
('car', 1000, '2025-01-01', true),
('life', 2000, '2025-01-01', false),
('car', 1500, '2026-01-01', true),
('life', 2500, '2027-01-01', false),
('car', 1200, '2025-06-01', true),
('life', 1800, '2026-06-01', false),
('car', 1100, '2024-12-01', true),
('life', 2200, '2025-12-01', false),
('car', 1300, '2025-09-01', true),
('life', 2100, '2025-08-01', false);


INSERT INTO LoanConditions (currency, down_payment, loan_term) VALUES
('RUB', 5000, 60),
('USD', 3000, 36),
('RUB', 4000, 48),
('RUB', 2000, 24),
('RUB', 3000, 60),
('USD', 1500, 36),
('RUB', 6000, 72),
('USD', 8000, 84),
('RUB', 9000, 96),
('RUB', 3500, 60);

INSERT INTO People (name, surname, patronymic, contact_info, income, black_list_id) VALUES
('John', 'Doe', 'Smith', 'john.doe@example.com', 50000, NULL),
('Jane', 'Doe', 'Johnson', 'jane.doe@example.com', 60000, 1),
('Michael', 'Smith', 'Brown', 'michael.smith@example.com', 70000, NULL),
('Emily', 'Jones', 'Davis', 'emily.jones@example.com', 55000, NULL),
('Chris', 'Taylor', 'Wilson', 'chris.taylor@example.com', 60000, NULL),
('Jessica', 'Anderson', 'Moore', 'jessica.anderson@example.com', 80000, NULL),
('Daniel', 'Thomas', 'Jackson', 'daniel.thomas@example.com', 45000, NULL),
('Laura', 'White', 'Harris', 'laura.white@example.com', 75000, NULL),
('David', 'Martin', 'Thompson', 'david.martin@example.com', 70000, NULL),
('Sarah', 'Lee', 'Martinez', 'sarah.lee@example.com', 65000, NULL);

INSERT INTO Borrowers (people_id, spouse_id) VALUES
(1, NULL),
(2, NULL),
(3, 1),
(4, 3),
(5, NULL),
(6, 1),
(7, 5),
(8, 6),
(9, NULL),
(10, 2);

INSERT INTO RepaymentSchedules (date) VALUES
('2024-10-10'),
('2024-11-10'),
('2024-12-10'),
('2025-01-10'),
('2025-02-10'),
('2025-03-10'),
('2025-04-10'),
('2025-05-10'),
('2025-06-10'),
('2025-07-10');

INSERT INTO Payments (date, amount, repayment_shedules_id) VALUES
('2024-10-10', 500, 1),
('2024-11-10', 500, 2),
('2024-12-10', 500, 3),
('2025-01-10', 500, 4),
('2025-02-10', 500, 5),
('2025-03-10', 500, 6),
('2025-04-10', 500, 7),
('2025-05-10', 500, 8),
('2025-06-10', 500, 9),
('2025-07-10', 500, 10);

INSERT INTO Treaty (borrower_id, guarantor_id, loan_conditional_id, car_id, insurance_id, status, repayment_shedules_id) VALUES
(1, 2, 1, 1, 1, TRUE, 1),
(2, 3, 2, 2, 2, TRUE, 2),
(3, 1, 3, 3, 3, FALSE, 3),
(4, 5, 4, 4, 4, TRUE, 1),
(5, 6, 5, 5, 5, FALSE, 2),
(6, 1, 6, 6, 6, TRUE, 3),
(7, 4, 7, 7, 7, TRUE, 1),
(2, 5, 8, 8, 8, FALSE, 2),
(3, 1, 9, 9, 9, TRUE, 3),
(1, 4, 10, 10, 10, FALSE, 1);

INSERT INTO Documents (people_id, file_path, file_name, document_type, document_status) VALUES
(1, '/files/john_doe_passport.pdf', 'passport.pdf', 'passport', 'accepted'),
(2, '/files/jane_doe_statement.pdf', 'statement.pdf', 'statement', 'received'),
(3, '/files/michael_smith_driver_license.pdf', 'work_certificate.pdf', 'work_certificate', 'in_processing'),
(4, '/files/emily_jones_work_certificate.pdf', 'work_certificate.pdf', 'work_certificate', 'accepted'),
(5, '/files/chris_taylor_2_NDFL.pdf', '2_NDFL.pdf', '2_NDFL', 'rejected'),
(1, '/files/jessica_anderson_car_passport.pdf', 'car_passport.pdf', 'car_passport', 'received'),
(3, '/files/daniel_thomas_car_registration.pdf', 'car_registration.pdf', 'car_registration', 'accepted'),
(4, '/files/laura_white_income_certificate.pdf', 'copy_work_books.pdf', 'copy_work_books', 'accepted'),
(1, '/files/david_martin_income_certificate.pdf', 'copy_work_books.pdf', 'copy_work_books', 'received');
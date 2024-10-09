CREATE TYPE loan_type AS ENUM ('standard', 'special_conditions');
CREATE TYPE loan_status AS ENUM ('active', 'closed', 'defaulted');
CREATE TYPE insurance_type AS ENUM ('car', 'life', 'car_life');
CREATE TYPE document_status AS ENUM ('received', 'in_processing', 'accepted', 'rejected');
CREATE TYPE type_document AS ENUM ('statement', 'passport', 'driver_icense', '2_NDFL', 'work_certificate', 'copy_work_books', 'car_passport', 'car_registration', 'other');

CREATE TABLE Company (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE ModelCars (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES Company(id),
    name VARCHAR NOT NULL,
    sale BOOLEAN NOT NULL
);

CREATE TABLE Dealers (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    special_conditions TEXT,
    sale BOOLEAN NOT NULL
);

CREATE TABLE Cars (
    id SERIAL PRIMARY KEY,
    model_id INT NOT NULL REFERENCES ModelCars(id),
    year INT NOT NULL,
    cost NUMERIC NOT NULL,
    dealer_id INT NOT NULL REFERENCES Dealers(id)
);

CREATE TABLE BlackLists (
    id SERIAL PRIMARY KEY,
    reason TEXT NOT NULL
);

CREATE TABLE People (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    surname VARCHAR NOT NULL,
    patronymic VARCHAR,
    contact_info VARCHAR,
    income NUMERIC NOT NULL,
    black_list_id INT REFERENCES BlackLists(id)
);

CREATE TABLE Borrowers (
    id SERIAL PRIMARY KEY,
    people_id INT NOT NULL REFERENCES People(id),
    spouse_id INT REFERENCES People(id)
);

CREATE TABLE Documents (
    id SERIAL PRIMARY KEY,
    people_id INT NOT NULL REFERENCES People(id),
    file_path VARCHAR NOT NULL,
    file_name VARCHAR NOT NULL,
    document_type type_document NOT NULL,
    document_status document_status NOT NULL
);

CREATE TABLE Insurances (
    id SERIAL PRIMARY KEY,
    insurance_type insurance_type NOT NULL,
    cost NUMERIC NOT NULL,
    expiration_date DATE NOT NULL,
    sale BOOLEAN NOT NULL
);

CREATE TABLE LoanConditions (
    id SERIAL PRIMARY KEY,
    total_loan_amount NUMERIC,
    interest_rate NUMERIC,
    currency VARCHAR NOT NULL,
    down_payment NUMERIC NOT NULL,
    monthly_payment NUMERIC,
    loan_term INT NOT NULL);

CREATE TABLE RepaymentSchedules (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    remaining_balance NUMERIC
);

CREATE TABLE Payments (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    amount NUMERIC NOT NULL,
    repayment_shedules_id INT NOT NULL REFERENCES RepaymentSchedules(id)
);

CREATE TABLE Treaty (
    id SERIAL PRIMARY KEY,
    borrower_id INT NOT NULL REFERENCES Borrowers(id),
    guarantor_id INT NOT NULL REFERENCES People(id),
    loan_conditional_id INT NOT NULL REFERENCES LoanConditions(id),
    car_id INT NOT NULL REFERENCES Cars(id),
    insurance_id INT NOT NULL REFERENCES Insurances(id),
    status BOOLEAN NOT NULL,
    repayment_shedules_id INT NOT NULL REFERENCES RepaymentSchedules(id)
);

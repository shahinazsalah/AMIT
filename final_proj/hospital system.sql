CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL REFERENCES roles(role_id),
    active BOOLEAN DEFAULT TRUE
);
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES users(user_id),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    department VARCHAR(100),
    job_title VARCHAR(100)
);
CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    staff_id INT UNIQUE REFERENCES staff(staff_id),
    specialization VARCHAR(100)
);
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    national_id VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10),
    phone VARCHAR(30),
    address VARCHAR(255),
    emergency_contact VARCHAR(255)
);
CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    ward VARCHAR(50),
    room_number VARCHAR(20) NOT NULL UNIQUE,
    bed_count INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'available'
);
CREATE TABLE admissions (
    admission_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    room_id INT REFERENCES rooms(room_id),
    admitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    discharged_at TIMESTAMP,
    notes TEXT
);
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id),
    scheduled_at TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    reason TEXT,
    CONSTRAINT uq_doctor_slot UNIQUE (doctor_id, scheduled_at)
);
CREATE TABLE medical_records (
    record_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id),
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    diagnosis TEXT,
    notes TEXT
);
CREATE TABLE vitals (
    vital_id SERIAL PRIMARY KEY,
    record_id INT REFERENCES medical_records(record_id),
    temp FLOAT,
    bp_sys INT,
    bp_dia INT,
    pulse INT,
    spo2 INT
);
CREATE TABLE lab_tests (
    test_id SERIAL PRIMARY KEY,
    record_id INT REFERENCES medical_records(record_id),
    test_type VARCHAR(100),
    requested_by VARCHAR(100),
    result TEXT,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resulted_at TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending'
);
CREATE TABLE drugs (
    drug_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    form VARCHAR(50),
    strength VARCHAR(50),
    stock_qty INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    unit_price NUMERIC(10,2) DEFAULT 0.0
);
CREATE TABLE prescriptions (
    rx_id SERIAL PRIMARY KEY,
    record_id INT REFERENCES medical_records(record_id),
    prescribed_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);
CREATE TABLE rx_items (
    item_id SERIAL PRIMARY KEY,
    rx_id INT REFERENCES prescriptions(rx_id),
    drug_id INT REFERENCES drugs(drug_id),
    dose VARCHAR(50),
    frequency VARCHAR(50),
    duration_days INT DEFAULT 1
);
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    admission_id INT REFERENCES admissions(admission_id),
    total NUMERIC(10,2) DEFAULT 0.0,
    paid NUMERIC(10,2) DEFAULT 0.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Unpaid'
);
CREATE TABLE invoice_items (
    item_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoices(invoice_id),
    description VARCHAR(255),
    qty INT DEFAULT 1,
    unit_price NUMERIC(10,2) DEFAULT 0.0
);
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    action VARCHAR(50),
    entity VARCHAR(50),
    entity_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);
INSERT INTO roles (name) VALUES
('Admin'), ('Doctor'), ('Nurse'), ('Reception'), ('Lab'), ('Pharmacy');
INSERT INTO users (username, password_hash, role_id, active) VALUES
('admin', '123', 1, TRUE),
('dr_ahmed', '345', 2, TRUE),
('reception', '567', 4, TRUE),
('nurse', '789', 3, TRUE),
('labtech', '91011', 5, TRUE),
('pharmacist', '111213', 6, TRUE);
INSERT INTO staff (user_id, first_name, last_name, phone, department, job_title)
VALUES (2, 'Ahmed', 'Youssef', '0100000000', 'Cardiology', 'Consultant');

INSERT INTO doctors (staff_id, specialization) VALUES (1, 'Cardiology');
INSERT INTO patients (national_id, first_name, last_name, phone, address)
VALUES
('EG12345678901234', 'Mona', 'Ali', '0111111111', 'Giza'),
('EG22345678901234', 'Hassan', 'Mahmoud', '0122222222', 'Cairo');
INSERT INTO drugs (name, form, strength, stock_qty, reorder_level, unit_price)
VALUES
('Paracetamol', 'Tablet', '500mg', 50, 10, 5.00),
('Amoxicillin', 'Capsule', '500mg', 5, 10, 12.00);
INSERT INTO rooms (ward, room_number, bed_count, status) VALUES
('A', 'A101', 2, 'available'),
('B', 'B202', 1, 'available');
SELECT * FROM users;
SELECT * FROM patients;
--next appointments
SELECT a.appointment_id, p.first_name, p.last_name,
       d.doctor_id, a.scheduled_at, a.status, a.reason
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.scheduled_at >= NOW()
ORDER BY a.scheduled_at;
SELECT ad.admission_id, p.first_name, p.last_name,
       r.room_number, ad.admitted_at
FROM admissions ad
JOIN patients p ON ad.patient_id = p.patient_id
JOIN rooms r ON ad.room_id = r.room_id
WHERE ad.discharged_at IS NULL;
ALTER TABLE users ADD COLUMN last_login TIMESTAMP;
ALTER TABLE users ADD COLUMN phone_number VARCHAR(20);
ALTER TABLE users ADD COLUMN email VARCHAR(100);
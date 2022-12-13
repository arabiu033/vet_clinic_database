/* Design from a giving schema entity relation diagram */

-- patients table
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY (id)
);

-- medical_histories table
CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(100),
  PRIMARY KEY (id)
);

-- invoices table
CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id),
  PRIMARY KEY (id)
);

-- treatment table
CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100),
  name VARCHAR(100),
  PRIMARY KEY (id)
);

-- invoices_items table
CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id),
  PRIMARY KEY (id)
);

-- Join Table For medical_histories and treatments tables
CREATE TABLE treatments_history (
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id)
)

CREATE INDEX mh1 ON medical_histories(patient_id ASC);
CREATE INDEX inv1 ON invoices(medical_histories ASC);
CREATE INDEX inv2 ON invoice_items(invoice_id ASC);
CREATE INDEX inv3 ON invoice_items(treatment_id ASC);
CREATE INDEX th1 ON treatments_history(medical_history_id ASC);
CREATE INDEX th2 ON treatments_history(treatment_id ASC);

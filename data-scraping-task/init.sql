CREATE TABLE IF NOT EXISTS aluminium_companies (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT,
    phones TEXT,
    emails TEXT[]
);

INSERT INTO aluminium_companies (name, address, phones, emails) VALUES
('AluTech Industries', '123 Aluminum St, Cityville', '123-456-7890', ARRAY['info@alutech.com']);
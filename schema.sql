DROP TABLE IF EXISTS correction_requests CASCADE;
DROP TABLE IF EXISTS certificates CASCADE;
DROP TABLE IF EXISTS registrations CASCADE;
DROP TABLE IF EXISTS informants CASCADE;
DROP TABLE IF EXISTS issuing_offices CASCADE;


CREATE TABLE issuing_offices (
    office_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    office_name VARCHAR(100) NOT NULL,
    district VARCHAR(100) NOT NULL
);


CREATE TABLE informants (
    informant_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    informant_name VARCHAR(120),
    relationship_to_subject VARCHAR(50),
    contact_phone VARCHAR(20)
);


CREATE TABLE registrations (
    registration_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    registration_type VARCHAR(10) NOT NULL
        CHECK (registration_type IN ('BIRTH', 'DEATH')),

    recorded_person_name VARCHAR(120) NOT NULL,

    event_date DATE NOT NULL,

    registration_date DATE NOT NULL,

    event_location VARCHAR(150),

    informant_id INTEGER
        REFERENCES informants(informant_id),

    office_id INTEGER NOT NULL
        REFERENCES issuing_offices(office_id),

    CHECK (registration_date >= event_date)
);


CREATE TABLE certificates (
    certificate_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    registration_id INTEGER NOT NULL
        REFERENCES registrations(registration_id),

    issuing_office_id INTEGER NOT NULL
        REFERENCES issuing_offices(office_id),

    issued_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE correction_requests (
    correction_request_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    registration_id INTEGER NOT NULL
        REFERENCES registrations(registration_id),

    requested_at TIMESTAMP NOT NULL,

    field_name VARCHAR(50) NOT NULL,

    original_value TEXT NOT NULL,

    proposed_value TEXT NOT NULL,

    reason TEXT,

    status VARCHAR(20) NOT NULL
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),

    resolved_at TIMESTAMP
);
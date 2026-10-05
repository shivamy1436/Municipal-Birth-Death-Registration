-- =====================================================
-- MUNICIPAL BIRTH AND DEATH REGISTRATION
-- SAMPLE / FICTIONAL DATA
-- =====================================================

-- =====================================================
-- 1. ISSUING OFFICES
-- =====================================================

INSERT INTO issuing_offices (office_name, district)
VALUES
('Municipal Registration Office A', 'Mumbai'),
('Central Registrar Office B', 'Thane'),
('Municipal Records Office C', 'Navi Mumbai'),
('District Registration Office D', 'Pune'),
('City Civil Registration Office E', 'Nashik');


-- =====================================================
-- 2. INFORMANTS
-- =====================================================

INSERT INTO informants
(informant_name, relationship_to_subject, contact_phone)
VALUES
('Informant Alpha', 'Parent', '9000000001'),
('Informant Beta', 'Parent', '9000000002'),
('Informant Gamma', 'Guardian', '9000000003'),
('Informant Delta', 'Spouse', '9000000004'),
('Informant Epsilon', 'Parent', '9000000005'),
('Informant Zeta', 'Sibling', '9000000006'),
('Informant Eta', 'Parent', '9000000007'),
('Informant Theta', 'Guardian', '9000000008'),
('Informant Iota', 'Spouse', '9000000009'),
('Informant Kappa', 'Parent', '9000000010'),
('Informant Lambda', 'Sibling', '9000000011'),
('Informant Mu', 'Guardian', '9000000012');


-- =====================================================
-- 3. REGISTRATIONS
-- =====================================================

INSERT INTO registrations
(
    registration_type,
    recorded_person_name,
    event_date,
    registration_date,
    event_location,
    informant_id,
    office_id
)
VALUES

-- March births
('BIRTH', 'Person Alpha',   '2026-03-01', '2026-03-03', 'Location A', 1, 1),
('BIRTH', 'Person Beta',    '2026-03-05', '2026-03-08', 'Location B', 2, 1),
('BIRTH', 'Person Gamma',   '2026-03-10', '2026-03-12', 'Location C', 3, 2),
('BIRTH', 'Person Delta',   '2026-03-15', '2026-03-18', 'Location D', 4, 2),
('BIRTH', 'Person Epsilon', '2026-03-20', '2026-03-22', 'Location E', 5, 3),
('BIRTH', 'Person Zeta',    '2026-03-25', '2026-03-28', 'Location F', NULL, 3),
('BIRTH', 'Person Eta',     '2026-03-30', '2026-04-02', 'Location G', 6, 4),

-- Other births
('BIRTH', 'Person Theta',   '2026-01-12', '2026-01-15', 'Location H', 7, 4),
('BIRTH', 'Person Iota',    '2026-02-08', '2026-02-11', 'Location I', 8, 5),
('BIRTH', 'Person Kappa',   '2026-04-05', '2026-04-08', 'Location J', 9, 5),
('BIRTH', 'Person Lambda',  '2026-05-10', '2026-05-13', 'Location K', 10, 1),
('BIRTH', 'Person Mu',      '2026-06-15', '2026-06-18', 'Location L', NULL, 2),

-- Deaths
('DEATH', 'Person Nu',      '2026-01-05', '2026-01-10', 'Location M', 11, 1),
('DEATH', 'Person Xi',      '2026-01-10', '2026-02-05', 'Location N', 12, 2),
('DEATH', 'Person Omicron', '2026-01-20', '2026-02-15', 'Location O', 1, 3),
('DEATH', 'Person Pi',      '2026-02-01', '2026-02-05', 'Location P', 2, 4),
('DEATH', 'Person Rho',     '2026-02-10', '2026-03-10', 'Location Q', 3, 5),
('DEATH', 'Person Sigma',   '2026-02-15', '2026-02-20', 'Location R', NULL, 1),
('DEATH', 'Person Tau',     '2026-03-01', '2026-03-25', 'Location S', 4, 2),
('DEATH', 'Person Upsilon', '2026-03-10', '2026-03-15', 'Location T', 5, 3),
('DEATH', 'Person Phi',     '2026-03-20', '2026-04-20', 'Location U', 6, 4),
('DEATH', 'Person Chi',     '2026-04-01', '2026-04-10', 'Location V', 7, 5),
('DEATH', 'Person Psi',     '2026-04-10', '2026-04-15', 'Location W', 8, 1),
('DEATH', 'Person Omega',   '2026-05-01', '2026-06-01', 'Location X', 9, 2),

-- Additional records
('BIRTH', 'Person A1', '2026-07-01', '2026-07-05', 'Location Y', 10, 3),
('BIRTH', 'Person A2', '2026-07-10', '2026-07-12', 'Location Z', NULL, 4),
('BIRTH', 'Person A3', '2026-08-01', '2026-08-05', 'Location AA', 11, 5),
('BIRTH', 'Person A4', '2026-08-15', '2026-08-20', 'Location AB', 12, 1),
('DEATH', 'Person A5', '2026-06-10', '2026-06-15', 'Location AC', 1, 2),
('DEATH', 'Person A6', '2026-06-20', '2026-07-25', 'Location AD', NULL, 3),
('DEATH', 'Person A7', '2026-07-05', '2026-07-10', 'Location AE', 2, 4),
('DEATH', 'Person A8', '2026-07-15', '2026-08-20', 'Location AF', 3, 5),
('BIRTH', 'Person A9', '2026-09-01', '2026-09-05', 'Location AG', 4, 1),
('BIRTH', 'Person A10', '2026-09-10', '2026-09-15', 'Location AH', 5, 2),
('DEATH', 'Person A11', '2026-08-10', '2026-08-15', 'Location AI', NULL, 3),
('DEATH', 'Person A12', '2026-08-20', '2026-09-25', 'Location AJ', 6, 4);


-- =====================================================
-- 4. CERTIFICATES
-- =====================================================

INSERT INTO certificates (registration_id, issuing_office_id)
SELECT registration_id, office_id
FROM registrations
WHERE registration_id <= 30;


-- =====================================================
-- 5. CORRECTION REQUESTS
-- =====================================================

INSERT INTO correction_requests
(
    registration_id,
    requested_at,
    field_name,
    original_value,
    proposed_value,
    reason,
    status,
    resolved_at
)
VALUES
(1, CURRENT_TIMESTAMP, 'Person Name', 'Person Alpha', 'Person Alpha Updated',
 'Correction requested for registered name', 'PENDING', NULL),

(2, CURRENT_TIMESTAMP - INTERVAL '1 day', 'Event Location', 'Location B', 'Location B Updated',
 'Location correction', 'PENDING', NULL),

(3, CURRENT_TIMESTAMP - INTERVAL '2 days', 'Person Name', 'Person Gamma', 'Person Gamma Updated',
 'Name correction', 'APPROVED', CURRENT_TIMESTAMP),

(4, CURRENT_TIMESTAMP - INTERVAL '3 days', 'Event Date', '2026-03-15', '2026-03-16',
 'Date correction', 'REJECTED', CURRENT_TIMESTAMP),

(5, CURRENT_TIMESTAMP - INTERVAL '4 days', 'Person Name', 'Person Epsilon', 'Person Epsilon Updated',
 'Spelling correction', 'PENDING', NULL),

(6, CURRENT_TIMESTAMP - INTERVAL '5 days', 'Event Location', 'Location F', 'Location F Updated',
 'Location correction', 'PENDING', NULL),

(13, CURRENT_TIMESTAMP - INTERVAL '6 days', 'Person Name', 'Person Nu', 'Person Nu Updated',
 'Name correction', 'APPROVED', CURRENT_TIMESTAMP),

(14, CURRENT_TIMESTAMP - INTERVAL '7 days', 'Event Date', '2026-01-10', '2026-01-11',
 'Date correction', 'PENDING', NULL),

(15, CURRENT_TIMESTAMP - INTERVAL '8 days', 'Person Name', 'Person Omicron', 'Person Omicron Updated',
 'Name correction', 'REJECTED', CURRENT_TIMESTAMP),

(20, CURRENT_TIMESTAMP - INTERVAL '9 days', 'Event Location', 'Location T', 'Location T Updated',
 'Location correction', 'PENDING', NULL),

(25, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Person Name', 'Person A1', 'Person A1 Updated',
 'Name correction', 'PENDING', NULL),

(30, CURRENT_TIMESTAMP - INTERVAL '11 days', 'Event Date', '2026-07-10', '2026-07-11',
 'Date correction', 'APPROVED', CURRENT_TIMESTAMP);
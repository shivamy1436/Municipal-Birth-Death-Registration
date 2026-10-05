-- =====================================================
-- MUNICIPAL BIRTH AND DEATH REGISTRATION
-- RETRIEVAL QUERIES
-- =====================================================


-- =====================================================
-- Q1: Births registered in March 2026
-- Requirement: WHERE + BETWEEN + ORDER BY
-- =====================================================

SELECT
    registration_id,
    recorded_person_name,
    event_date,
    registration_date,
    event_location,
    informant_id,
    office_id
FROM registrations
WHERE registration_type = 'BIRTH'
  AND registration_date BETWEEN '2026-03-01' AND '2026-03-31'
ORDER BY registration_date ASC;


-- =====================================================
-- Q2: Registrations with no informant name recorded
-- Requirement: IS NULL + ORDER BY
-- =====================================================

SELECT
    registration_id,
    registration_type,
    recorded_person_name,
    informant_id,
    registration_date
FROM registrations
WHERE informant_id IS NULL
ORDER BY registration_id ASC;


-- =====================================================
-- Q3: Deaths registered more than 21 days after event
-- Requirement: Date calculation + WHERE + ORDER BY
-- =====================================================

SELECT
    registration_id,
    recorded_person_name,
    event_date,
    registration_date,
    registration_date - event_date AS days_delayed
FROM registrations
WHERE registration_type = 'DEATH'
  AND registration_date > event_date + INTERVAL '21 days'
ORDER BY days_delayed DESC;


-- =====================================================
-- Q4: Pending correction requests, oldest first
-- Requirement: WHERE + ORDER BY
-- =====================================================

SELECT
    correction_request_id,
    registration_id,
    requested_at,
    field_name,
    original_value,
    proposed_value,
    reason,
    status
FROM correction_requests
WHERE status = 'PENDING'
ORDER BY requested_at ASC;


-- =====================================================
-- Q5: Certificates issued by a given office
-- Page 1 - 20 records
-- Requirement: JOIN + WHERE + ORDER BY + LIMIT
-- =====================================================

SELECT
    c.certificate_id,
    c.registration_id,
    r.registration_type,
    r.recorded_person_name,
    o.office_name,
    c.issued_at
FROM certificates c
JOIN registrations r
    ON c.registration_id = r.registration_id
JOIN issuing_offices o
    ON c.issuing_office_id = o.office_id
WHERE c.issuing_office_id = 1
ORDER BY c.certificate_id
LIMIT 20
OFFSET 0;


-- =====================================================
-- Q6: Certificates issued by a given office
-- Page 2 - 20 records
-- Requirement: LIMIT + OFFSET
-- =====================================================

SELECT
    c.certificate_id,
    c.registration_id,
    r.registration_type,
    r.recorded_person_name,
    o.office_name,
    c.issued_at
FROM certificates c
JOIN registrations r
    ON c.registration_id = r.registration_id
JOIN issuing_offices o
    ON c.issuing_office_id = o.office_id
WHERE c.issuing_office_id = 1
ORDER BY c.certificate_id
LIMIT 20
OFFSET 20;


-- =====================================================
-- Q7: Registrations between two event dates
-- Requirement: BETWEEN + ORDER BY
-- =====================================================

SELECT
    registration_id,
    registration_type,
    recorded_person_name,
    event_date,
    registration_date
FROM registrations
WHERE event_date BETWEEN '2026-03-01' AND '2026-03-31'
ORDER BY event_date ASC;


-- =====================================================
-- Q8: Registrations handled by selected offices
-- Requirement: IN + ORDER BY
-- =====================================================

SELECT
    registration_id,
    registration_type,
    recorded_person_name,
    office_id,
    registration_date
FROM registrations
WHERE office_id IN (1, 3, 5)
ORDER BY office_id, registration_date;


-- =====================================================
-- Q9: Search registrations using person name pattern
-- Requirement: LIKE
-- =====================================================

SELECT
    registration_id,
    registration_type,
    recorded_person_name,
    event_date,
    registration_date
FROM registrations
WHERE recorded_person_name LIKE 'Person A%'
ORDER BY recorded_person_name;


-- =====================================================
-- Q10: Display distinct districts
-- Requirement: DISTINCT + ORDER BY
-- =====================================================

SELECT DISTINCT
    district
FROM issuing_offices
ORDER BY district;


-- =====================================================
-- Q11: Count registrations by registration type
-- Requirement: Aggregate + GROUP BY
-- =====================================================

SELECT
    registration_type,
    COUNT(*) AS total_registrations
FROM registrations
GROUP BY registration_type
ORDER BY total_registrations DESC;


-- =====================================================
-- Q12: Offices having at least 5 registrations
-- Requirement: GROUP BY + HAVING
-- =====================================================

SELECT
    office_id,
    COUNT(*) AS total_registrations
FROM registrations
GROUP BY office_id
HAVING COUNT(*) >= 5
ORDER BY total_registrations DESC;


-- =====================================================
-- Q13: Registration report with informant details
-- Requirement: INNER JOIN
-- =====================================================

SELECT
    r.registration_id,
    r.registration_type,
    r.recorded_person_name,
    r.registration_date,
    i.informant_name,
    i.relationship_to_subject
FROM registrations r
JOIN informants i
    ON r.informant_id = i.informant_id
ORDER BY r.registration_id;


-- =====================================================
-- Q14: Registrations where informant details are missing
-- Requirement: LEFT JOIN + IS NULL
-- =====================================================

SELECT
    r.registration_id,
    r.registration_type,
    r.recorded_person_name,
    r.registration_date,
    i.informant_id,
    i.informant_name
FROM registrations r
LEFT JOIN informants i
    ON r.informant_id = i.informant_id
WHERE i.informant_id IS NULL
ORDER BY r.registration_id;


-- =====================================================
-- Q15: Registrations handled by offices having
-- more registrations than the average office
-- Requirement: Subquery
-- =====================================================

SELECT
    office_id,
    COUNT(*) AS total_registrations
FROM registrations
GROUP BY office_id
HAVING COUNT(*) > (
    SELECT AVG(office_count)
    FROM (
        SELECT
            COUNT(*) AS office_count
        FROM registrations
        GROUP BY office_id
    ) AS office_totals
)
ORDER BY total_registrations DESC;


-- =====================================================
-- Q16: Demonstrating incorrect NULL comparison
-- Requirement: NULL behavior
-- IMPORTANT: This returns ZERO rows
-- because NULL cannot be compared using =
-- =====================================================

SELECT
    registration_id,
    recorded_person_name,
    informant_id
FROM registrations
WHERE informant_id = NULL;


-- =====================================================
-- Q17: Correct way to find NULL values
-- Requirement: IS NULL
-- =====================================================

SELECT
    registration_id,
    recorded_person_name,
    informant_id
FROM registrations
WHERE informant_id IS NULL
ORDER BY registration_id;


-- =====================================================
-- Q18: Registrations with certificate information
-- Requirement: JOIN + ORDER BY
-- =====================================================

SELECT
    r.registration_id,
    r.recorded_person_name,
    r.registration_type,
    c.certificate_id,
    c.issued_at
FROM registrations r
JOIN certificates c
    ON r.registration_id = c.registration_id
ORDER BY r.registration_id;


-- =====================================================
-- Q19: Registrations without certificates
-- Requirement: LEFT JOIN + IS NULL
-- =====================================================

SELECT
    r.registration_id,
    r.recorded_person_name,
    r.registration_type,
    r.registration_date
FROM registrations r
LEFT JOIN certificates c
    ON r.registration_id = c.registration_id
WHERE c.certificate_id IS NULL
ORDER BY r.registration_id;


-- =====================================================
-- Q20: Count births and deaths by office
-- Requirement: JOIN + GROUP BY + aggregate
-- =====================================================

SELECT
    o.office_name,
    r.registration_type,
    COUNT(*) AS total_records
FROM registrations r
JOIN issuing_offices o
    ON r.office_id = o.office_id
GROUP BY
    o.office_name,
    r.registration_type
ORDER BY
    o.office_name,
    r.registration_type;


-- =====================================================
-- Q21: Pending correction requests with registration details
-- Requirement: JOIN + WHERE + ORDER BY
-- =====================================================

SELECT
    cr.correction_request_id,
    cr.registration_id,
    r.recorded_person_name,
    cr.field_name,
    cr.original_value,
    cr.proposed_value,
    cr.requested_at,
    cr.status
FROM correction_requests cr
JOIN registrations r
    ON cr.registration_id = r.registration_id
WHERE cr.status = 'PENDING'
ORDER BY cr.requested_at ASC;


-- =====================================================
-- Q22: Registrations where original and proposed
-- correction values are different
-- Requirement: Comparison + WHERE
-- =====================================================

SELECT
    correction_request_id,
    registration_id,
    field_name,
    original_value,
    proposed_value,
    status
FROM correction_requests
WHERE original_value <> proposed_value
ORDER BY correction_request_id;


-- =====================================================
-- END OF RETRIEVAL QUERIES
-- =====================================================
-- DRAKE STRATEGY & ANALYTICS
-- Healthcare Appointment Revenue Recovery | SQL Analysis
-- PostgreSQL | Historical physiotherapy appointments
--
-- Purpose: Explore attendance patterns and estimate illustrative gross
-- appointment value exposed to no-shows.
-- This is an independent analytical case study, not a client engagement.
-- Financial assumption: $100 per missed appointment is illustrative,
-- not verified collections or recoverable revenue.
--
-- Source table: appointments_raw
-- Filter: specialty = 'physiotherapy'
-- Note: These queries require the source table and its original columns.

-- ============================================================
-- 01 | UNDERSTAND THE DATA AND BASELINE ATTENDANCE
-- ============================================================

-- 1. Preview appointment dates, times, and no show status
SELECT 
	 specialty
	,appointment_date
	,appointment_time
	,no_show
FROM appointments_raw
LIMIT 10;

-- 2. Count total physiotherapy appointments

SELECT count(*) AS total_appointments
FROM appointments_raw
WHERE specialty = 'physiotherapy'; 

--3. Count missed physiotherapy appointments

SELECT COUNT(*) AS missed_appointments
FROM appointments_raw
WHERE specialty = 'physiotherapy'
 AND no_show = 'yes';

 --Calculate physiotherapy no-show rate
 
SELECT
 	 COUNT (*) AS total_appointments
	,COUNT(*) FILTER(WHERE no_show = 'yes') AS missed_appointments
	,ROUND(
		COUNT(*) FILTER(WHERE no_show = 'yes') * 100.0
		/ NULLIF(COUNT(*), 0),2
	) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy';

-- ============================================================
-- 02 | WHEN ARE APPOINTMENTS MISSED?
-- ============================================================

-- Count physiotherapy appointments by hour

SELECT 
	 LEFT (appointment_time, 2) AS appointment_hour
	,COUNT (*) AS total_appointments
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_hour
ORDER BY appointment_hour;

-- Count scheduled and missed appointments by hour
SELECT 
	 LEFT(appointment_time,2) AS appointment_hour
	,COUNT (*) AS total_appointments
	,COUNT (*) FILTER(WHERE no_show = 'yes') AS missed_appointments 
	,ROUND(
		COUNT(*) FILTER(WHERE no_show = 'yes') * 100.0
		/ NULLIF(COUNT(*),0),2
	) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_hour
ORDER BY missed_appointments DESC;

-- Count physiotherapy appointments by weekday

SELECT
	TO_CHAR(
		TO_DATE(appointment_date, 'DD/MM/YYYY'),'FMDay'
		) AS appointment_day
		, COUNT (*) AS total_appointments
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_day
ORDER BY total_appointments DESC;

-- Calculate physiotherapy no-show rates by weekday

SELECT
	TO_CHAR(
		TO_DATE(appointment_date, 'DD/MM/YYYY'),'FMDay'
		) AS appointment_day
		, COUNT (*) AS total_appointments
		,COUNT (*) FILTER(
			WHERE no_show = 'yes'
		) AS missed_appointments
		,ROUND(
			COUNT(*) FILTER (WHERE no_show = 'yes') * 100.0
			/ NULLIF(COUNT(*),0)
		) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_day
ORDER BY no_show_rate DESC;

-- Which weekday has the most 5 PM missed appointments?
SELECT
	TO_CHAR(
		TO_DATE(appointment_date, 'DD/MM/YYYY'),'FMDay'
		) AS appointment_day
		, COUNT (*) AS total_appointments
		,COUNT (*) FILTER(
			WHERE no_show = 'yes'
		) AS missed_appointments
		,ROUND(
			COUNT(*) FILTER (WHERE no_show = 'yes') * 100.0
			/ NULLIF(COUNT(*),0)
		) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
	AND LEFT(appointment_time,2 ) = '17'
GROUP BY appointment_day
ORDER BY missed_appointments DESC;

-- ============================================================
-- 03 | INVESTIGATE THE 5 PM WINDOW AND TIME TRENDS
-- ============================================================

-- Group 5pm appointments by year and month
SELECT
	 appointment_year
	,appointment_month
	,COUNT(*) AS total_appointments
	,COUNT(*) FILTER(
		WHERE no_show = 'yes'
	) AS missed_appointments
	,ROUND(
		COUNT(*) FILTER (WHERE no_show ='yes') *100.0
		/ NULLIF(COUNT(*),0)
		) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
	AND LEFT(appointment_time,2) ='17'
GROUP BY appointment_year, appointment_month
ORDER BY appointment_year, appointment_month;

--Investigate physiotherapy appointments by year

SELECT
	 appointment_year
	,COUNT(*) AS total_appointments
	,COUNT(*) FILTER(
		WHERE no_show = 'yes'
	) AS missed_appointments
	,ROUND(
		COUNT(*) FILTER (WHERE no_show ='yes') *100.0
		/ NULLIF(COUNT(*),0)
		) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_year
ORDER BY appointment_year;

-- Compare hourly appointment patterns in 2018 and 2021

SELECT
	 appointment_year
	,LEFT(appointment_time,2) AS appointment_hour
	,COUNT(*) AS total_appointments
	,COUNT(*) FILTER(
		WHERE no_show = 'yes'
	) AS missed_appointments
	,ROUND(
		COUNT(*) FILTER (WHERE no_show ='yes') *100.0
		/ NULLIF(COUNT(*),0)
		) AS no_show_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy'
	AND appointment_year IN  ('2018', '2021') 
GROUP BY appointment_year,appointment_hour
ORDER BY appointment_hour,appointment_year;

-- ============================================================
-- 04 | CHECK DATA COMPLETENESS
-- ============================================================

-- Inspect appointment and service dates

SELECT	
	 appointment_date
	,entry_service_date
	,no_show
FROM appointments_raw
WHERE specialty = 'physiotherapy'
LIMIT 20;

--Count missing entry service
SELECT
	 COUNT(*) AS total_appointments
	,COUNT(*) FILTER (
		WHERE entry_service_date IS NULL
	) AS missing_dates
	,ROUND(
		COUNT(*) FILTER (WHERE entry_service_date IS NULL ) *100.0
		/ NULLIF(COUNT(*),0),2
		) AS missing_date_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy';

-- Preview patient age

SELECT
	 age
	,no_show
FROM appointments_raw
WHERE specialty = 'physiotherapy'
LIMIT 20;

--Investigate missing patient ages

SELECT
	 COUNT(*) AS total_appointments
	,COUNT(*) FILTER (
		WHERE age is NULL
		) AS missing_ages
	,ROUND(
		COUNT(*) FILTER (WHERE age IS NULL ) *100.0
		/ NULLIF(COUNT(*),0),2
		) AS missing_age_rate
FROM appointments_raw
WHERE specialty = 'physiotherapy';

-- ============================================================
-- 05 | ILLUSTRATIVE FINANCIAL EXPOSURE
-- ============================================================

-- Count missed appointments by year

SELECT
	 appointment_year
	,COUNT(*) AS total_appointments
	,COUNT(*) FILTER(
		WHERE no_show ='yes'
	) AS missed_appointments
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_year
ORDER BY appointment_year;

-- Estimate potential gross appointment value exposed by year.
-- Assumes $100 per missed appointment; not actual lost revenue.

SELECT
	 appointment_year
	,COUNT(*) AS total_appointments
	,COUNT(*) FILTER(
		WHERE no_show ='yes'
	) AS missed_appointments
	,COUNT(*) FILTER(
		WHERE no_show = 'yes'
	) * 100 AS potential_revenue_exposure
FROM appointments_raw
WHERE specialty = 'physiotherapy'
GROUP BY appointment_year
ORDER BY appointment_year;

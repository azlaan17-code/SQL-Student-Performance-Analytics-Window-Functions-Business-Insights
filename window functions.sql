-- ============================================================
-- 📊 SQL Student Performance Analytics
-- PostgreSQL Script: Dataset + Business Problems + Solutions
-- ============================================================


-- ============================================================
-- 🗂️ 1. TABLE CREATION
-- ============================================================

DROP TABLE IF EXISTS student_marks;

CREATE TABLE student_marks (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    class VARCHAR(10),
    subject VARCHAR(20),
    marks INT
);


-- ============================================================
-- 📥 2. INSERT DATA
-- ============================================================

INSERT INTO student_marks (student_id, name, class, subject, marks) VALUES
(1, 'Ayaan', '10A', 'Math', 95),
(2, 'Riya', '10A', 'Math', 88),
(3, 'Kabir', '10A', 'Math', 95),
(4, 'Zara', '10A', 'Math', 72),
(5, 'Arjun', '10A', 'Science', 91),
(6, 'Meera', '10A', 'Science', 85),
(7, 'Dev', '10A', 'Science', 91),
(8, 'Isha', '10A', 'Science', 78),
(9, 'Omar', '10B', 'Math', 89),
(10, 'Neha', '10B', 'Math', 92),
(11, 'Aarav', '10B', 'Math', 92),
(12, 'Sara', '10B', 'Math', 70),
(13, 'Rahul', '10B', 'Science', 88),
(14, 'Ananya', '10B', 'Science', 93),
(15, 'Vikram', '10B', 'Science', 88),
(16, 'Pooja', '10B', 'Science', 60);


-- ============================================================
-- 📊 3. BUSINESS PROBLEM QUERIES
-- ============================================================


-- ------------------------------------------------------------
-- 1. Track cumulative performance within each subject
-- ------------------------------------------------------------

SELECT *,
SUM(marks) OVER (PARTITION BY subject ORDER BY marks) AS running_total
FROM student_marks;


-- ------------------------------------------------------------
-- 2. Identify students scoring above subject average
-- ------------------------------------------------------------

SELECT *
FROM (
    SELECT *,
    AVG(marks) OVER (PARTITION BY subject) AS avg_marks
    FROM student_marks
) sub
WHERE marks > avg_marks;


-- ------------------------------------------------------------
-- 3. Retrieve top 2 students per subject and class
-- ------------------------------------------------------------

SELECT *
FROM (
    SELECT *,
    RANK() OVER (PARTITION BY subject, class ORDER BY marks DESC) AS rnk
    FROM student_marks
) sub
WHERE rnk <= 2;


-- ------------------------------------------------------------
-- 4. Assign unique ranking within each subject
-- ------------------------------------------------------------

SELECT *,
ROW_NUMBER() OVER (PARTITION BY subject ORDER BY marks DESC) AS row_num
FROM student_marks;


-- ------------------------------------------------------------
-- 5. Identify 3rd highest performers per subject
-- ------------------------------------------------------------

SELECT *
FROM (
    SELECT *,
    DENSE_RANK() OVER (PARTITION BY subject ORDER BY marks DESC) AS rnk
    FROM student_marks
) sub
WHERE rnk = 3;


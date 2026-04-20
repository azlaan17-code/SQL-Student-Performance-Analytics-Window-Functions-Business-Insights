
# 📊 SQL Student Performance Analytics – Window Functions & Business Insights

### Overview
This project focuses on analyzing student performance data using SQL to derive actionable insights about academic performance, ranking, and score distribution.  

The dataset simulates a simplified academic environment containing student marks across subjects and classes. The goal is to demonstrate how SQL window functions can be used to solve real-world analytical problems such as identifying top performers, ranking students, and understanding score trends.

---

## The project includes:

1. Data schema design and table creation  
2. Analytical queries using SQL window functions  
3. Business problem solving using ranking and aggregation  
4. Performance insights for decision-making  

---

## Database Schema

### **student_marks**
Contains student performance data.

- `student_id`: Unique identifier for each student  
- `name`: Student name  
- `class`: Class section  
- `subject`: Subject name  
- `marks`: Marks obtained  
```

## Dataset

```sql
CREATE TABLE student_marks (
    student_id INT,
    name VARCHAR(50),
    class VARCHAR(10),
    subject VARCHAR(20),
    marks INT
);

INSERT INTO student_marks VALUES
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
```

## Business Problem Queries

1. **Track cumulative performance within each subject.**
```

SELECT *,
SUM(marks) OVER (PARTITION BY subject ORDER BY marks) AS running_total
FROM student_marks;

```
2. **. Identify students scoring above subject average.**
```
SELECT *
FROM (
    SELECT *,
    AVG(marks) OVER (PARTITION BY subject) AS avg_marks
    FROM student_marks
) x
WHERE marks > avg_marks;
```
3. **Retrieve top 2 students per subject and class.**
```
SELECT *
FROM (
    SELECT *,
    RANK() OVER (PARTITION BY subject, class ORDER BY marks DESC) AS rnk
    FROM student_marks
) x
WHERE rnk <= 2;
```
4. **Assign unique ranking within each subject.**
```
SELECT *,
ROW_NUMBER() OVER (PARTITION BY subject ORDER BY marks DESC) AS row_num
FROM student_marks;
```
5. **Identify 3rd highest performers per subject.**
```
SELECT *
FROM (
    SELECT *,
    DENSE_RANK() OVER (PARTITION BY subject ORDER BY marks DESC) AS rnk
    FROM student_marks
) x
WHERE rnk = 3;
```


## Technologies Used
- **Database:** PostgreSQL
- **SQL Concepts:**
**Window Functions:** `SUM()`, `AVG()`, `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`
     - **Subqueries:** Nested queries for filtering and analysis
     - **Aggregate Functions:** `SUM()`, `AVG()` with partitioning
     - **Analytical Queries:** Partitioning and ordering for insight


 ## Key Learnings

- **Business Problem Solving with SQL:**
-   Applied SQL to solve real-world academic performance problems
- **Window Function Mastery:**
-   Used ranking and aggregation functions for advanced analysis

- **Ranking Logic Understanding:**
-   Learned differences between `RANK`, `DENSE_RANK`, and `ROW_NUMBER`

- **Data-Driven Thinking:**
-   Built analytical thinking for performance-based decision making

## Business Impact
- **Performance Analysis:**
-   Identified high and mid-performing students

- **Data-Driven Decisions:**
-   Enabled targeted academic improvement strategies
- **Fair Ranking System:**
-   Ensured accurate and consistent ranking logic

- **Trend Analysis:**
-   Provided insights into score distribution across subjects



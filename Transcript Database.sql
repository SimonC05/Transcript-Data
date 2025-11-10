CREATE DATABASE transcript;
USE transcript;

CREATE TABLE Courses (
CourseCode VARCHAR(5) PRIMARY KEY,
CourseName VARCHAR(50),
Semester VARCHAR(6),
Year INT,
Grade VARCHAR(2)
);

-- allows me to add more values while ignoring duplicates
INSERT IGNORE INTO Courses (CourseCode, CourseName, Semester, Year, Grade)
VALUES
('CP104', 'Intro to Programming', 'Fall', 2023, 'A'),
('DD101', 'Critical Play', 'Fall', 2023, 'B+'),
('MA103', 'Calculus I', 'Fall', 2023, 'B'),
('MA122', 'Intro-Linear Algebra', 'Fall', 2023, 'B'),
('PS101', 'Introduction to Psychology I', 'Fall', 2023, 'C'),
('CP164', 'Data Structures I', 'Winter', 2024, 'B+'),
('DD102', 'Critical Game Design I', 'Winter', 2024, 'A'),
('PP110', 'Values & Society', 'Winter', 2024, 'C+'),
('RE104', 'Evil and Its Symbols', 'Winter', 2024, 'A-'),
('EM202', 'The Educational Divide', 'Spring', 2024, 'A'),
('RE103', 'Love and Its Myths', 'Spring', 2024, 'B'),
('RE313', 'Grief, Death & Dying', 'Spring', 2024, 'A-'),
('CP213', 'Object-Oriented Programming', 'Fall', 2024, 'B-'),
('CP214', 'Discrete Struct for Comp Sci', 'Fall', 2024, 'B'),
('CP220', 'Digital Electronics', 'Fall', 2024, 'A'),
('EM203', 'Learn 280 Characters or Less', 'Fall', 2024, 'A'),
('OL200', 'Comm Skills for Leadership', 'Fall', 2024, 'B'),
('CP216', 'Intro to Microprocessors', 'Winter', 2025, 'B'),
('CP264', 'Data Structures II', 'Winter', 2025, 'B+'),
('ES274', 'One Earth, One Health', 'Winter', 2025, 'B'),
('OL224', 'Organizational Leadership', 'Winter', 2025, 'B'),
('EM300', 'Teaching in Non-School Context', 'Spring', 2025, 'A-'),
('CP363', 'Database I', 'Fall', 2025, NULL),
('ST230', 'Probability', 'Fall', 2025, NULL),
('CP386', 'Operating Systems', 'Fall', 2025, NULL),
('CP372', 'Computer Networks', 'Fall', 2025, NULL);

-- add another column Program to the Courses table
ALTER TABLE Courses
ADD COLUMN Program VARCHAR(50);

-- updates the Program attribute using Case logic
UPDATE Courses
SET Program = CASE
WHEN CourseCode LIKE 'CP%' THEN 'Computer Science'
WHEN CourseCode Like 'ST%' OR CourseCode LIKE 'MA%' THEN 'Mathematics'
WHEN CourseCode LIKE 'RE%' THEN 'Religion and Culture'
WHEN CourseCode LIKE 'PS%' THEN 'Psychology'
WHEN CourseCode LIKE 'DD%' THEN 'Game Design and Development'
WHEN CourseCode LIKE 'EM%' THEN 'Education Minor'
WHEN CourseCode LIKE 'ES%' THEN 'Environmental Studies'
WHEN CourseCode LIKE 'OL%' THEN 'Leadership'
WHEN CourseCode LIKE 'PP%' THEN 'Philosophy'
END;

-- adds another column for the grade percentage
ALTER TABLE Courses
ADD COLUMN PercentGrade INT;

UPDATE Courses
SET PercentGrade = CASE
WHEN Grade = 'A+' THEN 97
WHEN Grade = 'A' THEN 90
WHEN Grade = 'A-' THEN 83
WHEN Grade = 'B+' THEN 78
WHEN Grade = 'B' THEN 75
WHEN Grade = 'B-' THEN 72
WHEN Grade = 'C+' THEN 68
WHEN Grade = 'C' THEN 65
WHEN Grade = 'C-' THEN 62
WHEN Grade = 'D+' THEN 58
WHEN Grade = 'D' THEN 55
WHEN Grade = 'D-' THEN 52
WHEN Grade IS NULL THEN NULL
ELSE 0
END;

SELECT *
FROM Courses;

-- checks frequency of each grade
SELECT Grade, COUNT(*) AS GradeCount
FROM Courses
WHERE Grade IS NOT NULL
GROUP BY Grade
ORDER BY GradeCount DESC;

-- checks how many courses I took in each program
SELECT Program, COUNT(*) AS ProgramCount
FROM Courses
GROUP BY Program
ORDER BY Program;

-- selects the courses where there is a suffix following the grade
SELECT CourseCode, CourseName, Grade
FROM Courses
WHERE Grade LIKE '_+' OR Grade LIKE '_-'
ORDER BY CourseCode;

-- finds my average grade for each semester
SELECT Semester, Year, ROUND(AVG(PercentGrade), 2) AS GradeAverage
FROM Courses
WHERE PercentGrade IS NOT NULL
GROUP BY Semester, Year
ORDER BY Semester, Year;

-- finds my average grade througout the year 2024
SELECT Year, ROUND(AVG(PercentGrade), 2) AS GradeAverage
FROM Courses
WHERE Year IN (
SELECT Year
FROM Courses
WHERE Year = 2024
)
GROUP BY Year;
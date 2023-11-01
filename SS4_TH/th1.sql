CREATE DATABASE IF NOT EXISTS QuanLySinhVien;

USE QuanLySinhVien;

CREATE TABLE IF NOT EXISTS Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);

CREATE TABLE IF NOT EXISTS Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

CREATE TABLE IF NOT EXISTS Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE IF NOT EXISTS Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);
-- Thêm dữ liệu vào bảng Class
INSERT INTO Class (ClassName, StartDate, Status)
VALUES 
    ('Class A', '2023-12-01', 1),
    ('Class B', '2023-10-01', 1),
    ('Class C', '2023-12-01', 0);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES
    ('hùng', 'hà nội', '123456789', 1, 1),
    ('hao', 'Thái nguyên', '987654321', 1, 2),
    ('thắng', 'hà nội', '555555555', 1, 3);

-- Thêm dữ liệu vào bảng Subject
INSERT INTO Subject (SubName, Credit, Status)
VALUES
    ('Math', 4, 1),
    ('English', 3, 1),
    ('Science', 5, 1);

-- Thêm dữ liệu vào bảng Mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES
    (1, 1, 85, 1),
    (2, 1, 75, 1),
    (3, 1, 90, 1),
    (1, 2, 70, 1),
    (2, 2, 80, 1),
    (3, 2, 95, 1),
    (1, 3, 60, 1),
    (2, 3, 65, 1),
    (3, 3, 75, 1);
    
    
   -- 
   SELECT Address, COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;
  
  --
  SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName

SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 15;
--
SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
--
SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);
    
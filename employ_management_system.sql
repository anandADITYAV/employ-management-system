-- Create table for Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Create table for Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    HireDate DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create table for Salaries
CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    SalaryAmount DECIMAL(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create table for Department Managers
CREATE TABLE Department_Managers (
    ManagerID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    DepartmentID INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create table for Employee Projects
CREATE TABLE Employee_Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100) NOT NULL,
    EmployeeID INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert sample data into Departments
INSERT INTO Departments (DepartmentName) 
VALUES ('Human Resources'), ('Finance'), ('Engineering'), ('Marketing');

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, DateOfBirth, HireDate, Email, PhoneNumber, DepartmentID) 
VALUES ('John', 'Doe', '1990-01-01', '2020-02-15', 'john.doe@example.com', '123-456-7890', 1),
       ('Jane', 'Smith', '1985-03-12', '2018-07-22', 'jane.smith@example.com', '098-765-4321', 2);

-- Insert sample data into Salaries
INSERT INTO Salaries (EmployeeID, SalaryAmount, StartDate, EndDate) 
VALUES (1, 60000, '2020-02-15', NULL), 
       (2, 70000, '2018-07-22', NULL);

-- Insert sample data into Department Managers
INSERT INTO Department_Managers (EmployeeID, DepartmentID, StartDate, EndDate) 
VALUES (1, 1, '2020-03-01', NULL);

-- Insert sample data into Employee Projects
INSERT INTO Employee_Projects (ProjectName, EmployeeID, StartDate, EndDate) 
VALUES ('Project Alpha', 1, '2021-01-01', NULL),
       ('Project Beta', 2, '2021-05-15', NULL);

-- Query to fetch all employees with their department
SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    e.Email, 
    d.DepartmentName 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Query to fetch employee salaries
SELECT 
    e.FirstName, 
    e.LastName, 
    s.SalaryAmount, 
    s.StartDate, 
    s.EndDate 
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- Query to fetch department managers
SELECT 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName 
FROM Department_Managers dm
JOIN Employees e ON dm.EmployeeID = e.EmployeeID
JOIN Departments d ON dm.DepartmentID = d.DepartmentID
WHERE dm.EndDate IS NULL;

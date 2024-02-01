IF OBJECT_ID('dbo.DIM_Stores', 'U') IS NOT NULL
	DROP TABLE dbo.DIM_Stores;

CREATE TABLE DIM_Stores (
    StoreID INT PRIMARY KEY,
    [Name] NVARCHAR(60),
    [Location] NVARCHAR(55),
	isActive NCHAR(1),
	DateUpdate Date
);


IF OBJECT_ID('dbo.DIM_Customers', 'U') IS NOT NULL
	DROP TABLE dbo.DIM_Customers;

CREATE TABLE DIM_Customers (
    CustomerID INT PRIMARY KEY,
    StoreID INT REFERENCES DIM_Stores(StoreID),
    Name NVARCHAR(35),
    Address NVARCHAR(45),
    City NVARCHAR(30),
    Region NVARCHAR(30),
    Country NVARCHAR(50),
	isActive NCHAR(1),
	DateUpdate DATE
);


IF OBJECT_ID('dbo.DIM_Employees', 'U') IS NOT NULL
	DROP TABLE dbo.DIM_Employees;

CREATE TABLE DIM_Employees (
    EmpID INT PRIMARY KEY,
    FirstName NVARCHAR(15),
    LastName NVARCHAR(20),
    JobTitle NVARCHAR(45),
    HireDate DATE,
    PhoneNumber NVARCHAR(25),
    EmailAddress NVARCHAR(35),
    TerritoryName NVARCHAR(20),
    IsActive NCHAR(1),
	DateUpdate DATE
);


IF OBJECT_ID('dbo.DIM_Products', 'U') IS NOT NULL
	DROP TABLE dbo.DIM_Products;

CREATE TABLE DIM_Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(40),
    SubCategoryName NVARCHAR(25),
    CategoryName NVARCHAR(20),
	isActive NCHAR(1),
	DateUpdate DATE
);


IF OBJECT_ID('dbo.FACT_Sales', 'U') IS NOT NULL
	DROP TABLE dbo.FACT_Sales;

CREATE TABLE FACT_Sales (
    OrderID INT,
    OrderDate DATETIME,
    AgentID INT REFERENCES DIM_Employees(EmpID),
    CustomerID INT REFERENCES DIM_Customers(CustomerID),
    TerritoryID INT,
    ProductID INT REFERENCES DIM_Products(ProductID),
    Qty SMALLINT,
    Price NUMERIC(10, 2),
    Discount NUMERIC(4, 2),
    Total NUMERIC(10, 2)
);



IF OBJECT_ID('dbo.Transfer_Table', 'U') IS NOT NULL
	DROP TABLE dbo.Transfer_Table;

CREATE TABLE Transfer_Table
(
	ID INT IDENTITY(1,1), 
	PackageName NVARCHAR(30),
	TableName NVARCHAR(30),
	StartDate DATETIME,
	EndDate DATETIME,
	NewRowCount INT
);

IF OBJECT_ID('dbo.DIM_Products_History', 'U') IS NOT NULL
	DROP TABLE dbo.DIM_Products_History;

CREATE TABLE DIM_Products_History
(
	ProductID INT REFERENCES DIM_Products(ProductID),
	ProductName NVARCHAR(40),
	SubCategoryName NVARCHAR(25),
	CategoryName NVARCHAR(20),
	InsertDate DATETIME,
	EndDate DATETIME 
);

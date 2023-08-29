-- Tạo cơ sở dữ liệu
CREATE DATABASE ASM01;

-- Sử dụng cơ sở dữ liệu
USE ASM01;

-- Tạo bảng Khách hàng
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(255),
    Address NVARCHAR(255),
    Phone NVARCHAR(15)
);

-- Tạo bảng Đơn hàng
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status NVARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng Sản phẩm
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    Description NVARCHAR(255),
    Unit NVARCHAR(20),
    Price DECIMAL(10, 2)
);

-- Tạo bảng Chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Thêm dữ liệu vào bảng Khách hàng
INSERT INTO Customers (CustomerID, CustomerName, Address, Phone)
VALUES
    (1, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321'),
    (2, N'Trần Thị Bình', N'222 Lê Lợi, Hoàn Kiếm, Hà Nội', '123456789'),
    (3, N'Lê Minh Tuấn', N'333 Nguyễn Du, Hai Bà Trưng, Hà Nội', '555555555'),
    (4, N'Phạm Thị Ngọc', N'444 Trần Phú, Ba Đình, Hà Nội', '999999999'),
    (5, N'Hoàng Văn Hưng', N'555 Trường Chinh, Đống Đa, Hà Nội', '111111111');

-- Thêm dữ liệu vào bảng Đơn hàng
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status)
VALUES
    (123, 1, '2009-11-18', 'Pending'),
    (124, 2, '2023-08-25', 'Completed'),
    (125, 3, '2023-08-25', 'Pending'),
    (126, 1, '2023-08-26', 'Cancelled'),
    (127, 4, '2023-08-26', 'Pending');

-- Thêm dữ liệu vào bảng Sản phẩm
INSERT INTO Products (ProductID, ProductName, Description, Unit, Price)
VALUES
    (1, N'Máy Tính T450', N'Máy nhập mới Chiếc', N'Chiếc', 1000),
    (2, N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Chiếc', 200),
    (3, N'Máy In Samsung 450', N'Máy in đang ế', N'Chiếc', 100),
    (4, N'Laptop X550', N'Laptop siêu mỏng', N'Cái', 1200),
    (5, N'Tai Nghe Beats', N'Tai nghe cao cấp', N'Cái', 150);

-- Thêm dữ liệu vào bảng Chi tiết đơn hàng
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, TotalAmount)
VALUES
    (123, 1, 1, 1000),
    (123, 2, 2, 400),
    (124, 3, 1, 100),
    (125, 2, 3, 600),
    (125, 4, 1, 1200);

-- Hiển thị danh sách sản phẩm trong cửa hàng
SELECT ProductName, Description, Unit, Price FROM Products

-- Hiển thị danh sách khách hàng
SELECT CustomerName, Address, Phone FROM Customers

--Hiển thị danh sách đơn đặt hàng 
SELECT OrderID, CustomerName, OrderDate, Status FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID

--Hiển thị danh sách khách hàng theo thứ tự Aphabet
SELECT CustomerName, Address, Phone
FROM Customers
ORDER BY CustomerName ASC;

--Liệt kê danh sách sản phẩm của cửa hàng theo thứ tự giá giảm dần
SELECT ProductName, Description, Unit, Price
FROM Products
ORDER BY Price DESC;

SELECT P.ProductName, P.Unit, P.Price
FROM Products P
JOIN OrderDetails OD ON P.ProductID=OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.CustomerName=N'Nguyễn Văn An';

--đếm số khách hàng đã mua ở cửa hàng
SELECT COUNT(DISTINCT CustomerID) AS NumberOfCustomers
FROM Orders;

--đếm số mặt hàng mà cửa hàng bán
SELECT COUNT(DISTINCT ProductID) AS NumberOfProducts
FROM Products;

--tính tổng tiền của từng đơn hàng
SELECT OrderID, SUM(TotalAmount) AS TotalAmount
FROM OrderDetails
GROUP BY OrderID;

--Thay đổi giá tiền của từng mặt hàng là dương (>0):
UPDATE Products
SET Price = ABS(Price)
WHERE Price < 0;

UPDATE Orders
SET OrderDate = DATEADD(day, +2, GETDATE())
WHERE OrderDate >= GETDATE();


ALTER TABLE Products
ADD ReleaseDate DATE;
UPDATE Products
SET ReleaseDate = '2023-08-25' 
WHERE ProductID = 1; 

SELECT *FROM Orders
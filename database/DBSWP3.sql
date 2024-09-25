create database Big
use Big

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY,      -- Mã định danh duy nhất cho khách hàng
    FirstName NVARCHAR(50) NOT NULL,          -- Tên khách hàng
    LastName NVARCHAR(50) NOT NULL,           -- Họ khách hàng
    DateOfBirth DATE NULL,                    -- Ngày sinh
    Gender CHAR(1) NULL,                      -- Giới tính
    CreatedAt DATETIME DEFAULT GETDATE(),     -- Ngày tạo tài khoản
    UpdatedAt DATETIME DEFAULT GETDATE(),     -- Ngày cập nhật tài khoản lần cuối
    IsActive BIT DEFAULT 1                    -- Trạng thái tài khoản: 1 là hoạt động, 0 là không hoạt động
);

-- Tạo bảng thông tin liên lạc
CREATE TABLE CustomerContacts (
    ContactID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    Phone NVARCHAR(15) NULL,
    Email NVARCHAR(100) UNIQUE NULL,
    IsPrimary BIT DEFAULT 0,
    ContactType NVARCHAR(50) NULL
);

-- Tạo bảng địa chỉ
CREATE TABLE CustomerAddresses (
    AddressID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    Address NVARCHAR(255) NULL,
    City NVARCHAR(100) NULL,
    State NVARCHAR(100) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NULL,
    AddressType NVARCHAR(50) NULL,
    IsPrimary BIT DEFAULT 0
);



CREATE TABLE ProductCategories (
    CategoryID INT PRIMARY KEY IDENTITY,      -- Mã định danh duy nhất cho danh mục
    CategoryName NVARCHAR(100) NOT NULL,       -- Tên danh mục
	Status int not null
);

CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY,         -- Mã định danh duy nhất cho thương hiệu
    BrandName NVARCHAR(100) NOT NULL,         -- Tên thương hiệu
    BrandDescription NVARCHAR(500) NULL       -- Mô tả về thương hiệu (có thể để trống)
);



CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,       -- Mã định danh duy nhất cho sản phẩm
    ProductName NVARCHAR(100) NOT NULL,       -- Tên sản phẩm
    BrandID INT FOREIGN KEY REFERENCES Brands(BrandID), -- Liên kết đến bảng Brands
    CategoryID INT FOREIGN KEY REFERENCES ProductCategories(CategoryID), -- Liên kết đến bảng danh mục sản phẩm
    Ingredients NVARCHAR(MAX),               -- Thành phần
    Formulation NVARCHAR(100),               -- Công thức sản phẩm
    Specification NVARCHAR(100),             -- Thông số kỹ thuật
    TargetAudience NVARCHAR(100),            -- Đối tượng mục tiêu
    PrescriptionMedication BIT,               -- Thuốc kê đơn hay không
    ShortDescription NVARCHAR(500),           -- Mô tả ngắn gọn về sản phẩm
    RegistrationNumber NVARCHAR(100)          -- Số đăng ký
);

CREATE TABLE ProductPackaging (
    PackagingID INT PRIMARY KEY IDENTITY,      -- Mã định danh duy nhất cho kiểu đóng gói
    PackagingType NVARCHAR(50) NOT NULL,       -- Loại đóng gói (ví dụ: hộp, viên, vỉ)
    Description NVARCHAR(MAX)                  -- Mô tả thêm về kiểu đóng gói
);

CREATE TABLE ProductPackagingDetails (
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),   -- Liên kết tới bảng Products
    PackagingID INT FOREIGN KEY REFERENCES ProductPackaging(PackagingID), -- Liên kết tới bảng ProductPackaging
    QuantityPerPackage INT,           -- Số lượng sản phẩm trong mỗi đơn vị đóng gói
    UnitPrice DECIMAL(18,2),          -- Giá của từng đơn vị đóng gói
    PRIMARY KEY (ProductID, PackagingID), -- Khóa chính tổ hợp
	IsActive BIT DEFAULT 1                       -- Trạng thái hoạt động của bản ghi tồn kho (1 là hoạt động, 0 là không hoạt động)
);




CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY IDENTITY,          -- Mã định danh duy nhất cho đánh giá
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID), -- Liên kết tới bảng Products
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID), -- Liên kết tới bảng Customers
    Rating INT NOT NULL,                        -- Đánh giá của khách hàng (0-5 sao)
    ReviewText NVARCHAR(MAX),                   -- Nội dung đánh giá
    ReviewDate DATE DEFAULT GETDATE()           -- Ngày đánh giá
);

CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY IDENTITY,           -- Mã định danh duy nhất cho hình ảnh
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID), -- Liên kết tới bảng Products
    ImageURL NVARCHAR(255) NOT NULL,            -- Đường dẫn đến hình ảnh
    IsMain BIT DEFAULT 0                        -- Xác định xem đây có phải là hình ảnh chính hay không
);




CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY IDENTITY,          -- Mã định danh duy nhất cho trạng thái đơn hàng
    StatusName NVARCHAR(50) NOT NULL UNIQUE     -- Tên trạng thái: 'Pending', 'Completed', 'Cancelled'
);

CREATE TABLE PaymentStatus (
    PaymentStatusID INT PRIMARY KEY IDENTITY,    -- Mã định danh duy nhất cho trạng thái thanh toán
    PaymentStatusName NVARCHAR(50) NOT NULL UNIQUE -- Tên trạng thái thanh toán: 'Paid', 'Unpaid'
);

CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY IDENTITY,     -- Mã định danh duy nhất cho phương thức thanh toán
    MethodName NVARCHAR(50) NOT NULL UNIQUE       -- Tên phương thức thanh toán: 'Credit Card', 'Cash', 'Bank Transfer', etc.
);



CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,                 -- Mã định danh duy nhất cho đơn hàng
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID), -- Liên kết đến bảng Customers
    OrderDate DATETIME DEFAULT GETDATE(),             -- Ngày đặt hàng
    TotalAmount DECIMAL(18, 2) NOT NULL,             -- Tổng số tiền đơn hàng (có thể tính toán từ OrderDetails)
    StatusID INT FOREIGN KEY REFERENCES OrderStatus(StatusID), -- Trạng thái đơn hàng (liên kết đến bảng OrderStatus)
    ShippingAddress NVARCHAR(255) NULL,              -- Địa chỉ giao hàng
    ShippingCost DECIMAL(18, 2) NULL,                -- Chi phí giao hàng
    DeliveryDate DATETIME NULL,                       -- Ngày dự kiến giao hàng
    IsActive BIT DEFAULT 1                            -- Trạng thái hoạt động của đơn hàng: 1 là hoạt động, 0 là không hoạt động
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,      -- Mã định danh duy nhất cho chi tiết đơn hàng
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID), -- Liên kết tới bảng Orders
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID), -- Liên kết tới bảng ProductDetails
    Quantity INT NOT NULL,                        -- Số lượng sản phẩm trong đơn hàng
    UnitPrice DECIMAL(18,2) NOT NULL,            -- Giá của từng sản phẩm tại thời điểm đặt hàng
    TotalPrice AS (Quantity * UnitPrice),        -- Tổng giá cho sản phẩm (tính toán tự động)
    IsActive BIT DEFAULT 1                       -- Trạng thái hoạt động của bản ghi (1 là hoạt động, 0 là không hoạt động)
);
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY,              -- Mã định danh duy nhất cho giao dịch thanh toán
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID), -- Liên kết đến bảng Orders
    PaymentDate DATETIME DEFAULT GETDATE(),         -- Ngày thanh toán
    PaymentAmount DECIMAL(18, 2) NOT NULL,         -- Số tiền thanh toán
    PaymentMethodID INT FOREIGN KEY REFERENCES PaymentMethod(PaymentMethodID), -- Phương thức thanh toán
    PaymentStatusID INT FOREIGN KEY REFERENCES PaymentStatus(PaymentStatusID), -- Trạng thái thanh toán
);
-- Tạo bảng Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY,  -- Mã định danh duy nhất cho khoa/bộ phận
    DepartmentName NVARCHAR(100) NOT NULL  -- Tên khoa/bộ phận
);
-- Tạo bảng Roles
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY,       -- Mã định danh duy nhất cho vai trò
    RoleName NVARCHAR(50) NOT NULL UNIQUE  -- Tên vai trò
);

-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,       -- Mã định danh duy nhất cho người dùng
    Username NVARCHAR(50) UNIQUE NULL,     -- Tên đăng nhập (có thể dùng cho đăng nhập bằng email hoặc tên đăng nhập)
    PasswordHash NVARCHAR(255) NULL,       -- Mật khẩu đã mã hóa (nếu đăng nhập bằng email)
    Email NVARCHAR(100) UNIQUE NULL,       -- Địa chỉ email (có thể dùng cho đăng nhập bằng email)
    PhoneNumber NVARCHAR(15) UNIQUE NULL,  -- Số điện thoại (có thể dùng cho đăng nhập bằng số điện thoại)
    IsActive BIT DEFAULT 1,                -- Trạng thái tài khoản: 1 là hoạt động, 0 là không hoạt động
    
);
-- Tạo bảng DoctorDetails kế thừa từ Users
CREATE TABLE DoctorDetails (
    DoctorID INT PRIMARY KEY IDENTITY,     -- Mã định danh duy nhất cho bác sĩ
    UserID INT UNIQUE NOT NULL,            -- Liên kết tới bảng Users
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID), -- Liên kết tới bảng Departments
    WorkHistory NVARCHAR(MAX),             -- Quá trình công tác
    EducationHistory NVARCHAR(MAX),        -- Quá trình đào tạo
    Description NVARCHAR(1000),            -- Mô tả về bác sĩ
    Portrait NVARCHAR(255),                -- Đường dẫn ảnh chân dung
    IsActive BIT DEFAULT 1,                -- Trạng thái tài khoản: 1 là hoạt động, 0 là không hoạt động
    CONSTRAINT FK_Doctor_User FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Khóa ngoại tới Users
);

-- Tạo bảng Pharmacies
CREATE TABLE Pharmacies (
    PharmacyID INT PRIMARY KEY IDENTITY,        -- Mã định danh duy nhất cho nhà thuốc
    Name NVARCHAR(100) NOT NULL,                -- Tên nhà thuốc
    Address NVARCHAR(255) NOT NULL,             -- Địa chỉ nhà thuốc
    Phone NVARCHAR(15),                         -- Số điện thoại liên hệ
    OpeningHours NVARCHAR(100),                 -- Giờ mở cửa
    ClosingHours NVARCHAR(100),                 -- Giờ đóng cửa
    Description NVARCHAR(1000),                 -- Mô tả nhà thuốc
    ImageURL NVARCHAR(255),                     -- Đường dẫn đến hình ảnh nhà thuốc
    IsActive BIT DEFAULT 1,                -- Trạng thái : 1 là hoạt động, 0 là không hoạt động
    City NVARCHAR(100),                         -- Thành phố
    Region NVARCHAR(100),                       -- Khu vực hoặc vùng nơi nhà thuốc tọa lạc
    ZipCode NVARCHAR(10) NULL                   -- Mã bưu chính
);

ALTER TABLE Users
ADD PharmacyID INT NULL,
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacies(PharmacyID);

ALTER TABLE Users
ADD RoleID INT FOREIGN KEY REFERENCES Roles(RoleID);


CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY,        -- Mã định danh duy nhất cho thông tin tồn kho
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID), -- Liên kết tới bảng Products
    PackagingID INT FOREIGN KEY REFERENCES ProductPackaging(PackagingID), -- Liên kết tới bảng ProductPackaging
    QuantityInStock INT,                         -- Số lượng hiện có trong kho
    ReorderLevel INT,                            -- Mức tồn kho tối thiểu để đặt hàng lại
    DateReceived DATE,                           -- Ngày nhập hàng
    ExpirationDate DATE,                         -- Ngày hết hạn của hàng hóa
    IsActive BIT DEFAULT 1                       -- Trạng thái hoạt động của bản ghi tồn kho (1 là hoạt động, 0 là không hoạt động)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY,       -- Mã định danh duy nhất cho nhà cung cấp
    SupplierName NVARCHAR(100) NOT NULL,       -- Tên nhà cung cấp
    ContactPhone NVARCHAR(15) NULL,            -- Số điện thoại liên hệ
    Address NVARCHAR(255) NULL,                -- Địa chỉ nhà cung cấp
    City NVARCHAR(100) NULL,                   -- Thành phố
    Country NVARCHAR(100) NULL                 -- Quốc gia
);

ALTER TABLE Inventory
ADD SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID); -- Liên kết tới bảng Suppliers

Alter table Orders 
Add UserID int foreign key references Users(UserID)

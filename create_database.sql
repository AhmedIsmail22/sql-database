create table offices(
	officeCode varchar(10) not null,
    city varchar(50) not null,
    phone varchar(50) not null,
    addressLine1 varchar(50) not null,
    addressLine2 varchar(50),
    state varchar(50),
    country varchar(50),
    postalCode varchar(15),
    
    PRIMARY KEY(officeCode)
);
CREATE table employees(
	employeeNumber int AUTO_INCREMENT,
    lastName varchar(50) not null,
    firstName varchar(50) not null,
    extension varchar(10) not null,
    email varchar(100) not null,
    officeCode varchar(10) not null,
    reportsTo int not null,
    jopTitle varchar(50) not null,
    PRIMARY KEY(employeeNumber),
    
    CONSTRAINT employeeRelations
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)on UPDATE CASCADE on DELETE CASCADE,
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode)on UPDATE CASCADE on DELETE CASCADE
);
create table customers(
	customerNumber int AUTO_INCREMENT,
    customerName varchar(50) not null,
    contactLastName varchar(50) not null,
    contactFirstName varchar(50) not null,
    phone varchar(50) not null,
    addressLine1 varchar(50) not null,
    addressLine2 varchar(50),
    city varchar(50) not null,
    state varchar(50),
    postalCode varchar(15),
    country varchar(50),
    salesRepEmployeeNumber int not null,
    criditLimit decimal(10,2),
    PRIMARY KEY(customerNumber),
    
    CONSTRAINT customerRelations
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)on UPDATE CASCADE on DELETE CASCADE
);
create table payments(
	customerNumber int not null,
    checkNumber varchar(50) not null,
    paymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount decimal(10,2),
    
    CONSTRAINT paymentRelations
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)ON UPDATE CASCADE on DELETE CASCADE
);
CREATE TABLE orders(
	orderNumber int AUTO_INCREMENT,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    requireDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shippedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status varchar(15),
    comments text,
    customerNumber int not null,
    PRIMARY KEY (orderNumber),
    
    CONSTRAINT orderRelations
        FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)ON UPDATE CASCADE on DELETE CASCADE
);
create table productLines(
	productLine varchar(50) PRIMARY KEY,
    textDescription varchar(4000),
    htmlDescription mediumtext,
    image mediumtext
);
create table products(
	productCode varchar(15) NOT null PRIMARY KEY,
    productName varchar(70) not null,
    productLine varchar(50) not null,
    productScale varchar(10) not null,
    productVendor varchar(50) not null,
    productDescription text not null,
    quantityStock SMALLINT(6) not null,
    buyPrice decimal(10,2) not null,
    MSRP decimal(10,2) not null,
    
    CONSTRAINT productsRelations
            	FOREIGN KEY (productLine) REFERENCES productLines(productLine)ON UPDATE CASCADE on DELETE CASCADE
);
create table orderDetails(
	orderNumber int not null,
    productCode varchar(15) not null,
    quantityOrder int not null,
    priceEach decimal(10,2),
    orderLineNumber SMALLINT(6),
    
    CONSTRAINT orderDetailsRelations
            FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber)ON UPDATE CASCADE on DELETE CASCADE,
        	FOREIGN KEY (productCode) REFERENCES products(productCode)ON UPDATE CASCADE on DELETE CASCADE
);
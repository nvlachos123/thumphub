-- Drop tables if they exist to ensure a clean slate
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS order_products;


-- Create Users table
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL
);

-- Insert sample data into Users
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan1', 'bass1@email.com', 'hashedpass1');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan2', 'bass2@email.com', 'hashedpass2');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan3', 'bass3@email.com', 'hashedpass3');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan4', 'bass4@email.com', 'hashedpass4');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan5', 'bass5@email.com', 'hashedpass5');

-- Create Products table
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

-- Insert sample data into Products
INSERT INTO Products (name, price, stock) VALUES ('Fender Jazz', 999.99, 10);
INSERT INTO Products (name, price, stock) VALUES ('Ibanez TMB100', 549.99, 5);
INSERT INTO Products (name, price, stock) VALUES ('Yamaha BB435', 599.99, 15);
INSERT INTO Products (name, price, stock) VALUES ('Squier Classic Vibe', 749.99, 20);
INSERT INTO Products (name, price, stock) VALUES ('Epiphone SG Bass', 639.99, 3);

-- Create Orders table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    order_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Insert sample data into Orders
INSERT INTO Orders (user_id, order_date, status) VALUES (1, '2025-09-13', 'pending');
INSERT INTO Orders (user_id, order_date, status) VALUES (2, '2025-09-12', 'pending');
INSERT INTO Orders (user_id, order_date, status) VALUES (3, '2025-09-11', 'shipped');
INSERT INTO Orders (user_id, order_date, status) VALUES (4, '2025-09-10', 'shipped');
INSERT INTO Orders (user_id, order_date, status) VALUES (5, '2025-09-09', 'delivered');

-- Create order_products table
CREATE TABLE order_products (
    order_product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id),
    UNIQUE (order_id, product_id)
);

-- Insert sample data into order_products
INSERT INTO order_products (order_id, product_id, quantity) VALUES (1, 1, 2);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (2, 2, 1);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (3, 3, 3);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (4, 4, 1);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (5, 5, 2);
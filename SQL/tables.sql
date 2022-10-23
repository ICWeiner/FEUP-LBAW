DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS addressBook CASCADE;
DROP TABLE IF EXISTS paymentInfo CASCADE;
DROP TABLE IF EXISTS Ord CASCADE;
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS productOrder CASCADE;
DROP TABLE IF EXISTS Collection CASCADE;
DROP TABLE IF EXISTS funkoPop CASCADE;
DROP TABLE IF EXISTS Publisher CASCADE;
DROP TABLE IF EXISTS Book CASCADE;
DROP TABLE IF EXISTS Author CASCADE;
DROP TABLE IF EXISTS authorBook CASCADE;
DROP TABLE IF EXISTS Shoe CASCADE;
DROP TABLE IF EXISTS Color CASCADE;
DROP TABLE IF EXISTS Size CASCADE;
DROP TABLE IF EXISTS shoeColorSize CASCADE;

CREATE TABLE users(
  id_User SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  url TEXT 
);

CREATE TABLE addressBook(
  id_addressBook SERIAL PRIMARY KEY,
  address TEXT NOT NULL,
  phoneNumber TEXT NOT NULL,
  name TEXT NOT NULL,
  id_User INTEGER REFERENCES users (id_User) ON UPDATE CASCADE
);

CREATE TABLE paymentInfo(
  id_paymentInfo SERIAL PRIMARY KEY,
  address TEXT NOT NULL,
  name TEXT NOT NULL,
  cardNumber TEXT NOT NULL UNIQUE,-- put this back CHECK (length(cardNumber) = 16),
  id_User INTEGER REFERENCES users (id_User) ON UPDATE CASCADE
);

create table Ord(
  id_Ord SERIAL PRIMARY KEY,
  price FLOAT NOT NULL CHECK (price >= 0),
  trackingNumber TEXT,
  buyDate DATE, -- NOT NULL, Constraints removed TEMPORARILY for students sanity while inputing mock data:^)
  shippingDate DATE, -- CHECK (shippingDate > buyDate),
  arrivalDate DATE,--  CHECK (arrivalDate > shippingDate),
  id_User INTEGER REFERENCES users (id_User) ON UPDATE CASCADE
);

CREATE TABLE Review(
  id_Review SERIAL PRIMARY KEY,
  comment TEXT NOT NULL,
  rating FLOAT NOT NULL CHECK (rating >=0 AND rating <= 5),
  reviewDate DATE NOT NULL,
  id_Ord INTEGER REFERENCES Ord (id_Ord) ON UPDATE CASCADE
);

CREATE TABLE Product(
  id_Product SERIAL PRIMARY KEY,
  price FLOAT NOT NULL CHECK (price >=0),
  quantity INTEGER NOT NULL CHECK (quantity >= 0),
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  year INTEGER NOT NULL,
  rating FLOAT NOT NULL CHECK (rating >=0 AND rating <= 5),
  sku TEXT NOT NULL
);

CREATE TABLE productOrder(
  id_Product INTEGER NOT NULL REFERENCES Product (id_Product) ON UPDATE CASCADE,
  id_Ord INTEGER NOT NULL REFERENCES Ord (id_Ord) ON UPDATE CASCADE,
  PRIMARY KEY(id_Product, id_Ord)
);

CREATE TABLE Collection(
  id_Collection SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  id_Product INTEGER REFERENCES Product (id_Product) ON UPDATE CASCADE
);

CREATE TABLE funkoPop(
  id_funkoPop SERIAL PRIMARY KEY,
  numberPop INTEGER NOT NULL UNIQUE,
  id_Product INTEGER REFERENCES Product (id_Product) ON UPDATE CASCADE
);

CREATE TABLE Publisher(
  id_Publisher SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE Book(
  id_Book SERIAL PRIMARY KEY,
  edition INTEGER NOT NULL,
  isbn TEXT NOT NULL UNIQUE,
  id_Publisher INTEGER REFERENCES Publisher (id_Publisher) ON UPDATE CASCADE,
  id_Product INTEGER REFERENCES Product (id_Product) ON UPDATE CASCADE
);

CREATE TABLE Author(
  id_Author SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  url TEXT NOT NULL
);

CREATE TABLE authorBook(
  id_Author INTEGER NOT NULL REFERENCES Author (id_Author) ON UPDATE CASCADE,
  id_Book INTEGER NOT NULL REFERENCES Book (id_Book) ON UPDATE CASCADE,
  PRIMARY KEY(id_Author, id_Book)
);

CREATE TABLE Shoe(
  id_Shoe SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  typeName TEXT NOT NULL,
  brandName TEXT NOT NULL
);

CREATE TABLE Color(
  id_Color SERIAL PRIMARY KEY,
  colorName TEXT NOT NULL
);

CREATE TABLE Size(
  id_Size SERIAL PRIMARY KEY,
  sizeEU INTEGER NOT NULL,
  sizeUS INTEGER 
);

CREATE TABLE shoeColorSize(
  id_Shoe INTEGER NOT NULL REFERENCES Shoe (id_Shoe) ON UPDATE CASCADE,
  id_Color INTEGER NOT NULL REFERENCES Color (id_Color) ON UPDATE CASCADE,
  id_Size INTEGER NOT NULL REFERENCES Size (id_Size) ON UPDATE CASCADE,
  PRIMARY KEY(id_Shoe, id_Color, id_Size)
);


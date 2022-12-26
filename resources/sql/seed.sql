CREATE SCHEMA IF NOT EXISTS lbaw2292;

SET search_path TO lbaw2292;

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS banned CASCADE;
DROP TABLE IF EXISTS addressBook CASCADE;
DROP TABLE IF EXISTS paymentInfo CASCADE;
DROP TABLE IF EXISTS ord CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS comment CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS flagged CASCADE;
DROP TABLE IF EXISTS productOrd CASCADE;
DROP TABLE IF EXISTS collection CASCADE;
DROP TABLE IF EXISTS funkoPop CASCADE;
DROP TABLE IF EXISTS publisher CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS author CASCADE;
DROP TABLE IF EXISTS authorBook CASCADE;
DROP TABLE IF EXISTS shoe CASCADE;
DROP TABLE IF EXISTS color CASCADE;
DROP TABLE IF EXISTS size CASCADE;
DROP TABLE IF EXISTS shoeColorSize CASCADE;
DROP TABLE IF EXISTS productCart CASCADE;
DROP TABLE IF EXISTS wishlist CASCADE;


CREATE TABLE users( --table name is plural because "user" is a reserved keyword
  id_user SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  image TEXT,
  user_is_banned BOOLEAN DEFAULT FALSE,
  user_is_admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE banned(
  id_banned SERIAL PRIMARY KEY,
  reason TEXT NOT NULL,
  official_date DATE NOT NULL,
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);

CREATE TABLE addressBook(
  id_address_book SERIAL PRIMARY KEY,
  address TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  name TEXT NOT NULL,
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);


CREATE TABLE paymentInfo(
  id_payment_info SERIAL PRIMARY KEY,
  address TEXT NOT NULL,
  name TEXT NOT NULL,
  card_number TEXT NOT NULL UNIQUE CHECK (length(card_number) = 16),
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);

CREATE TABLE ord(
  id_ord SERIAL PRIMARY KEY,
  total_price FLOAT NOT NULL CHECK (total_price >= 0),
  tracking_number TEXT,
  buy_date DATE NOT NULL,
  shipping_date DATE CHECK (shipping_date > buy_date),
  arrival_date DATE CHECK (arrival_date > shipping_date),
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);

CREATE TABLE product(
  id_product SERIAL PRIMARY KEY,
  price FLOAT NOT NULL CHECK (price >=0),
  stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0),
  description TEXT ,
  name TEXT NOT NULL,
  url TEXT ,
  year INTEGER NOT NULL,
  rating FLOAT NOT NULL CHECK (rating >=0 AND rating <= 5),
  deleted_at DATE,
  sku TEXT NOT NULL
);

CREATE TABLE productCart(
    id_cart serial PRIMARY KEY,
    id_user integer NOT NULL REFERENCES users(id_user) ON DELETE CASCADE,
    id_product integer NOT NULL REFERENCES product(id_product) ON DELETE CASCADE,
    quantity integer NOT NULL,
    CONSTRAINT quantity CHECK ((quantity > 0)),
    UNIQUE(id_user, id_product)
);

CREATE TABLE wishlist(
    id_wishlist serial PRIMARY KEY,
    id_user integer NOT NULL REFERENCES users(id_user) ON DELETE CASCADE,
    id_product integer NOT NULL REFERENCES product(id_product) ON DELETE CASCADE,
    date_added DATE NOT NULL,
    UNIQUE(id_user, id_product)
);

CREATE TABLE review(
  id_review SERIAL PRIMARY KEY,
  comment TEXT NOT NULL,
  rating FLOAT NOT NULL CHECK (rating >=0 AND rating <= 5),
  review_date DATE NOT NULL,
  id_product INTEGER REFERENCES product (id_product) ON UPDATE CASCADE,
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);

CREATE TABLE comment(
  id_comment SERIAL PRIMARY KEY,
  content TEXT,
  rating FLOAT NOT NULL,
  id_review INTEGER REFERENCES review (id_review) ON UPDATE CASCADE,
  id_user INTEGER REFERENCES users (id_user) ON UPDATE CASCADE
);

CREATE TABLE flagged(
  id_flagged SERIAL PRIMARY KEY,
  reason TEXT NOT NULL,
  id_review INTEGER REFERENCES review (id_review) ON UPDATE CASCADE,
  id_comment INTEGER REFERENCES comment (id_comment) ON UPDATE CASCADE
);


CREATE TABLE productOrd(
  quantity INTEGER NOT NULL CHECK (quantity >= 0),
  id_product INTEGER NOT NULL REFERENCES product (id_product) ON UPDATE CASCADE,
  id_ord INTEGER NOT NULL REFERENCES ord (id_ord) ON UPDATE CASCADE,
  PRIMARY KEY(id_product, id_ord)
);

CREATE TABLE collection(
  id_collection SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  id_product INTEGER REFERENCES product (id_product) ON UPDATE CASCADE
);

CREATE TABLE funkoPop(
  id_product INTEGER PRIMARY KEY REFERENCES product (id_product) ON UPDATE CASCADE,
  number_pop INTEGER NOT NULL UNIQUE
);

CREATE TABLE publisher(
  id_publisher SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE book(
  id_product INTEGER PRIMARY KEY REFERENCES product (id_product) ON UPDATE CASCADE,
  edition INTEGER NOT NULL,
  isbn TEXT NOT NULL UNIQUE,
  id_publisher INTEGER REFERENCES publisher (id_publisher) ON UPDATE CASCADE
);

CREATE TABLE author(
  id_author SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  url TEXT NOT NULL
);

CREATE TABLE authorBook(
  id_author INTEGER NOT NULL REFERENCES author (id_author) ON UPDATE CASCADE,
  id_book INTEGER NOT NULL REFERENCES book (id_product) ON UPDATE CASCADE,
  PRIMARY KEY(id_author, id_book)
);

CREATE TABLE shoe(
  id_product INTEGER PRIMARY KEY REFERENCES product (id_product) ON UPDATE CASCADE,
  name TEXT NOT NULL,
  type_name TEXT NOT NULL,
  brand_name TEXT NOT NULL
);

CREATE TABLE color(
  id_color SERIAL PRIMARY KEY,
  color_name TEXT NOT NULL
);

CREATE TABLE size(
  id_size SERIAL PRIMARY KEY,
  size_eu INTEGER NOT NULL,
  size_us INTEGER
);

CREATE TABLE shoeColorSize(
  id_shoe INTEGER NOT NULL REFERENCES shoe (id_product) ON UPDATE CASCADE,
  id_primaryColor INTEGER NOT NULL REFERENCES color (id_color) ON UPDATE CASCADE,
  id_secondaryColor INTEGER NOT NULL REFERENCES color (id_color) ON UPDATE CASCADE,
  id_size INTEGER NOT NULL REFERENCES size (id_size) ON UPDATE CASCADE,
  PRIMARY KEY(id_shoe, id_primaryColor, id_secondaryColor, id_size)
);


INSERT INTO users ( name, email, password, user_is_banned, user_is_admin, image) VALUES ( 'Shinji', 'shinji@mail.com', '$2y$10$bE7fMVTJYEIPB69ssRQRTO4Jjr9UHpE.BD2KcnL1o1yd7/fZOMfha', TRUE, FALSE, 'images/users/1.jpg');
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin, image) VALUES ( 'Asuka', 'asuka@mail.com', '$2y$10$U2zRchRSIh5b8M/0wx2ZgOEI2fkMMpL5pbOwJkmUNbX4yIXahNP5q', FALSE, TRUE, 'images/users/2.jpg');
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin, image) VALUES ( 'Rei', 'rei@mail.com', '$2y$10$KJ4gx2LEnS.DDlU0oe2PjuQUI81Xq5X/c0rznfwQd3Jj9Of1nAi2S', FALSE, FALSE, 'images/users/3.jpg');

INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Angel', 'acrowne3@pcworld.com', '$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Pascal', 'pvivash4@webs.com', '$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Lesly', 'lgarley5@printfriendly.com', '$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Nydia', 'noverlow6@privacy.gov.au', '$2y$10$wfc4Nmj44890TOx46DkIcuF1KnMuGSiXpsw8QZv1kgyd0qj4MS5Wq', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Beatriz', 'bboxall7@surveymonkey.com', '$2y$10$XcoAXfceonuRtEN66x1bMOBfgKK/93sUvYr0jrJdE0VSp2tWaAGVq', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Lucilia', 'lbanasik8@discovery.com', '$2y$10$khdeH96eplrrnxA7WP0z/OqG6DkJ8Gmi68gv./Ha3yeIr4/6KRPbu', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Jacques', 'jfont9@icq.com', '$2y$10$7n.hcKH56xHh1Umwg3JK9.Gefa5s38ePokH.Vak/hnCcW6aAiukSG', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Gweneth', 'gmaplethorpa@clickbank.net', '$2y$10$bW4FohOS4g7ydwl.Jg4vTeLEcWAoqdvza.QSlzJaJErx2ZjANXC2q', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Peria', 'pboolsenb@fema.gov', '$2y$10$Iu.uVutcZYoFTnOLQpIyx.TILwyaDs/Q7bmpEszl6JEE06Uk/', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Town', 'tgashionc@nytimes.com', '$2y$10$LEglPy4vYaq9v4PAzJLBx.zR52bM9r7hLjop4Pzi4rXV3c/4', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Pip', 'pmcgillivrayd@blinklist.com', '.$2y$10$RC1IvwLmzIE7R60IY59Qp.NusO5krgcpq2lKlpKJ/1', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Trevar', 'tbethunee@linkedin.com', '$2y$10$v2K5sF0oEoLLwgYqkYdNieCPLOH15.7', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Elden', 'eattocf@addthis.com', '$2y$10$uiZlZOrEilzJtdCrpbrzBOZCl5a4XotPazdsDikRT1ukQ.Mxd3xsS', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Piggy', 'pbreederg@guardian.co.uk', '$2y$10$L7N1SP.zvmyrQy1sHIG1g.7TkPLtbJvFi26KM/H4plHZxWoPs9OQa', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Wilbert', 'wjevonsh@va.gov', '$2y$10$sTZSh5XYJoByoILkwF4vgeqds0ftGj7Ka6nI5wm61ESlU8sebCqb2', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Jone', 'jmolloni@ehow.com', '$2y$10$r1ENwdyd/wLb3bSrO5zWsuvmEH.cConm4l0X0QGswPOmRXNDx0bcW', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Seka', 'srottej@whitehouse.gov', '$2y$10$m37KP6yg9j66Mgn2yz4VauuxTarSkWGVRHXDe8ZQJYo5cuc3Le8/S', FALSE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'George', 'theCuriousOne@caribean.gov', '$2y$10$7Wi527nfci7QrD.XrtrY4uDzy9k0LH1B9D5QygU81WirJYZnGbaRS', FALSE, TRUE);

INSERT INTO banned (id_banned, reason, official_date, id_user) VALUES (1,'Spam','9/24/2022', 5);
INSERT INTO banned (id_banned, reason, official_date, id_user) VALUES (2,'Spam','9/24/2022', 4);

INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '98803 Rigney Point', '9451434356', 'Tadio', 1);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '1989 Stone Corner Road', '9394674239', 'Odelia', 2);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '7456 Marcy Lane', '7428066695', 'Bank', 3);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '4817 Crescent Oaks Trail', '7901689666', 'Wendel', 4);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '50091 Annamark Road', '1382288588', 'Allie', 5);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '78414 Lakewood Gardens Junction', '1705284480', 'Tybalt', 6);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '200 Judy Drive', '6412588014', 'Malvina', 7);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '93 Del Mar Terrace', '6633462308', 'Farlie', 8);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '141 Bunker Hill Way', '3905806280', 'Ebeneser', 9);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '36923 Hoepker Hill', '8027043882', 'Sascha', 10);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '2584 Lakewood Way', '3952053788', 'Saundra', 11);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '195 Linden Terrace', '2434583413', 'Emmalee', 12);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '5 Hintze Plaza', '1276529356', 'Gustavus', 13);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '9032 Meadow Ridge Trail', '1932135077', 'Abelard', 14);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '4618 Nancy Hill', '7013141115', 'Alika', 15);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '187 Granby Avenue', '9242562384', 'Frederic', 16);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '932 Bellgrove Point', '6253135298', 'Ronnie', 17);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '1907 Mcbride Junction', '4139345281', 'Reinaldos', 18);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '7210 Beilfuss Avenue', '6084346420', 'Antonietta', 19);
INSERT INTO addressbook ( address, phone_number, name, id_user) VALUES ( '1849 Nova Junction', '4389646480', 'Emlynne', 20);

INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '367 Sunbrook Center', 'Ingram', '3046340250751587', 1);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '56 Farragut Circle', 'Blondy', '3007398620067421', 2);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '7 Dahle Park', 'Theodosia', '4026631876634241', 3);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '601 Becker Lane', 'Lucky', '3005087236351974', 4);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '7552 La Follette Trail', 'Perceval', '5610928872443854', 5);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '95 Dahle Crossing', 'Miguelita', '3555295293473061', 6);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '3010 Warbler Lane', 'Marco', '2404159329280885', 7);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '8 Paget Way', 'Mag', '3549138229856034', 8);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '3664 Roth Terrace', 'Angelita', '3549701708722918', 9);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '256 Carey Plaza', 'Ellen', '5002351384484873', 10);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '7294 Tony Trail', 'Corny', '3026254971731269', 11);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '37248 Algoma Lane', 'Evonne', '3544261620421698', 12);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '12680 Prentice Point', 'Ferrel', '5602217152772902', 13);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '13 Fieldstone Circle', 'Lynea', '3560709140115942', 14);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '16421 Spenser Drive', 'Osbert', '4903217127477982', 15);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '1307 Sunfield Lane', 'Cissiee', '3560176592513067', 16);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '61430 Northview Point', 'Rosalinda', '5610448812849018', 17);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '8643 High Crossing Pass', 'Lenora', '7530458425093600', 18);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '59572 Schurz Point', 'Tim', '3557587186744709', 19);
INSERT INTO paymentInfo ( address, name, card_number, id_user) VALUES ( '35 Butternut Avenue', 'Becki', '6796214252437708', 20);

INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 61.48, 'VK5573261LH', '5/18/2022', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 109.53, 'VR6271479BY', '10/31/2021', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 108.63, 'HF2169152VL', '10/19/2021', null, null, 13);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 85.26, 'MH2438360RO', '11/26/2021', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 19.1, 'RJ9504436OV', '7/26/2022', null, null, 11);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 128.79, 'WU6951005AC', '7/1/2022', null, null, 20);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 171.58, 'ET1341531XS', '4/26/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 193.0, 'SD9554902VP', '4/15/2022', null, null, 8);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 156.89, 'AZ7841498ER', '12/8/2021', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 86.76, 'TW8077325NM', '8/27/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 74.63, 'JO0765811OS', '10/30/2021', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 139.42, 'WM1609764ZN', '6/7/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 141.99, 'SJ3436860XQ', '2/16/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 186.71, 'YZ3882815FQ', '9/28/2022', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 47.19, 'CL0052209HQ', '10/6/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 107.02, 'HL9882202YE', '7/3/2022', null, null, 20);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 44.0 ,'JM5237348HG', '3/16/2022', null, null, 20);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 56.0 ,'IF8603833QY', '11/23/2021', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 81.0 ,'JS2015769AH', '4/11/2022', null, null, 7);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 113.0 ,'LX4431053SW', '8/24/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 28.0 ,'HQ3955601HV', '12/7/2021', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 165.0 ,'GJ6107695SI', '9/23/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 5.0 ,'FF2551788ZY', '10/7/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 69.0 ,'BY5153911WW', '8/17/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 127.0 ,'PJ6283005BG', '7/3/2022', null, null, 17);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 61.09, 'NK5307761UJ', '6/7/2022', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 159.0, 'SK1988180DB', '9/10/2022', null, null, 10);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 86.0 ,'ZP4236797YM', '5/6/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 17.0,'YQ6960425QG', '6/19/2022', null, null, 7);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 183.0, 'FP4217697ET', '8/15/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 14.02, 'OK6265798LV', '8/4/2022', null, null, 7);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 126.0, 'NI7904915YH', '11/11/2021', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 87.0 ,'AF7538768IV', '10/18/2021', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 170.0, 'RC9647068ZR', '4/23/2022', null, null, 9);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 177.0 ,'MJ1484279JB', '7/15/2022', null, null, 7);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 13.0,'IV4276624DF', '4/30/2022', null, null, 1);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 53.0 ,'MD6571603QG', '1/16/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 74.0 ,'YS6243760SS', '3/8/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 185.0 ,'SC9627932KG', '9/14/2022', null, null, 3);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 198.0 ,'RW0901170HZ', '1/25/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 67.0 ,'XP8897527MO', '11/27/2021', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 18.0 ,'CE1594382RE', '7/20/2022', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 66.0 ,'MP7868193OR', '5/14/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 41.05, 'WH2598644BV', '11/3/2021', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 86.0 ,'UP6365456HW', '11/23/2021', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 30.0 ,'UO7864624YQ', '7/31/2022', null, null, 20);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 110.0 ,'QZ8286878DX', '4/30/2022', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 107.0 ,'TN2891915VA', '2/16/2022', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 143.0 ,'EI7231738IU', '3/23/2022', null, null, 3);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 129.0 ,'PO4441365MK', '10/10/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 156.08, 'UZ8992691UW', '8/21/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 182.0 ,'MW6975196LC', '1/3/2022', null, null, 10);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 124.0 ,'JZ4773993ED', '3/12/2022', null, null, 4);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 112.0 ,'QU3264530IR', '9/5/2022', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 38.06, 'RE2520128WC', '11/25/2021', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 179.0 ,'SK8427499ZQ', '1/6/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 192.0 ,'PG8744844XE', '11/28/2021', null, null, 9);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 38.0 ,'KP7283511IK', '8/28/2022', null, null, 8);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 18.0 ,'BZ4420795JX', '9/9/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 92.0 ,'MA5837561AS', '1/31/2022', null, null, 8);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 192.0 ,'JH7155093NB', '2/28/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 12.01, 'WJ2665120UA', '12/2/2021', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 170.0 ,'AX5114271CV', '9/22/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 120.0 ,'KO0609620RC', '5/11/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 18.0 ,'SW2941493XV', '2/7/2022', null, null, 17);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 198.0 ,'MM0283445TI', '11/3/2021', null, null, 12);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 174.0 ,'NP8141404UN', '8/12/2022', null, null, 4);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 47.0 ,'EQ1225329XX', '4/13/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 161.06, 'MN7591219MN', '9/4/2022', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 89.0 ,'DY6912395LN', '6/11/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 180.05, 'ZL9052382SF', '2/28/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 128.0 ,'ZY1985043XH', '2/19/2022', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 197.0 ,'NK4242533XB', '11/10/2021', null, null, 6);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 170.0 ,'GA4723853SM', '3/1/2022', null, null, 7);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 173.0 ,'VM3587302EU', '3/28/2022', null, null, 19);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 54.0 ,'PS0951420XG', '10/10/2022', null, null, 1);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 67.0 ,'ZH4943372PN', '7/26/2022', null, null, 17);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 18.0 ,'SZ6161171CS', '10/26/2021', null, null, 8);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 199.0 ,'EU4770255IL', '5/12/2022', null, null, 9);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 152.0 ,'WE9316637BD', '2/7/2022', null, null, 19);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 154.0 ,'FO4533781GF', '12/20/2021', null, null, 12);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 95.0 ,'OL7810508VG', '7/19/2022', null, null, 15);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 137.0 ,'LZ7968888HA', '4/22/2022', null, null, 14);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 48.0 ,'TB0179870UB', '2/22/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 191.0 ,'RE6286948DK', '3/28/2022', null, null, 11);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 173.0 ,'PI7419376ZB', '8/10/2022', null, null, 1);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 27.0 ,'OU2093846VA', '4/29/2022', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 171.0 ,'ZP8026770IL', '5/10/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 144.0 ,'BR8203439ZO', '12/16/2021', null, null, 10);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 114.0 ,'AB0267200HD', '3/11/2022', null, null, 11);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 144.0 ,'WL9605430OL', '8/23/2022', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 196.0 ,'NH1936807EW', '4/10/2022', null, null, 18);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 141.0 ,'HS1394739KG', '6/12/2022', null, null, 5);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 188.0 ,'CU9005039KB', '1/7/2022', null, null, 3);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 190.0 ,'JO4636282MS', '6/23/2022', null, null, 3);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 109.0,'BT1568166GV', '6/18/2022', null, null, 2);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 151.01, 'ZW4895348FU', '4/17/2022', null, null, 10);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 161.02, 'JR7496521IC', '3/24/2022', null, null, 16);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 178.0 ,'VL3297075AL', '12/2/2021', null, null, 20);
INSERT INTO ord ( total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ( 40.49, 'DW5970309JW', '4/7/2022', null, null, 4);

insert into product (price, stock_quantity, name, url, year, rating, sku) values (130.5, 72, 'Anna Karenina', 'images/products/1.jpg', 1997, 1, '497-67759-786');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (186.75, 41, 'Madame Bovary', 'images/products/2.jpg', 2000, 5, '750-60542-988');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (54.88, 60, 'War and Peace', 'images/products/3.jpg', 2003, 1, '838-83169-850');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (155.13, 62, 'Lolita', 'images/products/4.jpg', 1993, 2, '258-86221-024');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (15.53, 26, 'The Adventures of Huckleberry Finn', 'images/products/5.jpg', 1987, 4, '200-67142-363');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (68.49, 48, 'Hamlet', 'images/products/6.jpg', 1994, 2, '083-19054-202');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (5.33, 9, 'The Great Gatsby', 'images/products/7.jpg', 1996, 4, '575-48646-885');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (28.19, 79, 'In Search of Lost Time', 'images/products/8.jpg', 1991, 4, '879-65843-560');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (176.56, 74, 'The Stories of Anton Chekhov', 'images/products/9.jpg', 1992, 4, '632-88046-890');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (220.21, 48, 'Middlemarch', 'images/products/10.jpg', 2004, 3, '518-13899-459');

insert into product (price, stock_quantity, name, url, year, rating, sku) values (80.17, 76, 'Air Jordan 1', 'images/products/11.jpg', 2006, 2, '065-23204-908');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (234.39, 52, 'Nike Zoom Mercurial Vapor 15 Elite SG-Pro Anti-Clog Traction', 'images/products/12.jpg', 2005, 4, '438-85543-820');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (42.28, 61, 'NikeCourt Legacy', 'images/products/13.jpg', 1995, 2, '758-14850-229');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (90.86, 55, 'Nike Victori One', 'images/products/14.jpg', 2010, 4, '978-94841-004');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (222.29, 3, 'Nike SB Dunk High Pro PRM', 'images/products/15.jpg', 2012, 5, '570-38209-866');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (233.36, 66, 'Nike LeBron 9 Low', 'images/products/16.jpg', 1986, 1, '274-08757-159');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (201.05, 40, 'Adidas Breaknet Plus', 'images/products/17.jpg', 2003, 5, '740-10549-260');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (96.74, 23, 'Adidoks Ultraboost 22', 'images/products/18.jpg', 2010, 3, '062-38083-212');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (93.24, 39, 'Men`s GG boot', 'images/products/19.jpg', 2011, 3, '092-74559-947');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (196.63, 90, 'Trigreca Trainers', 'images/products/20.jpg', 2008, 1, '008-67245-090');

insert into product (price, stock_quantity, name, url, year, rating, sku) values (55.04, 1, 'Lebron James in 6 Jersey - Los Angeles Lakers', 'images/products/21.jpg', 1996, 3, '340-54513-892');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (177.57, 7, 'Sinister Six: Electro - Marvel', 'images/products/22.jpg', 1992, 1, '663-02819-043');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (193.53, 17, 'Hawkman with Armor - DC Comics', 'images/products/23.jpg', 1992, 4, '168-55099-585');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (87.17, 23, 'Michael Jordan in 45 Jersey - Bulls', 'images/products/24.jpg', 1994, 1, '496-51905-964');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (182.09, 72, 'Boyband Kenny - South Park', 'images/products/25.jpg', 1998, 5, '254-75345-292');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (210.34, 99, 'True Heart Bear - Care Bears 40th', 'images/products/26.jpg', 1998, 2, '780-75265-273');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (166.24, 69, 'Nobara Kugisaki in Fight Stance - Jujutsu Kaisen', 'images/products/27.jpg', 1997, 2, '483-84516-630');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (179.98, 3, 'Mikasa Ackermann with Swords - Attack on Titan', 'images/products/28.jpg', 2012, 1, '461-48982-304');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (228.83, 91, 'Eleven in Tank Suit - Stranger Things Season 4', 'images/products/29.jpg', 2003, 5, '015-43838-568');
insert into product (price, stock_quantity, name, url, year, rating, sku) values (41.0, 5, 'Frodo Baggins - Lord of the Rings', 'images/products/30.jpg', 1987, 3, '172-24929-048');


INSERT INTO collection ( name, id_product) VALUES ( 'Schmitt-Koch', 1);
INSERT INTO collection ( name, id_product) VALUES ( 'Strosin-Hegmann', 2);
INSERT INTO collection ( name, id_product) VALUES ( 'Sipes-Runolfsdottir', 3);
INSERT INTO collection ( name, id_product) VALUES ( 'Witting-Rogahn', 4);
INSERT INTO collection ( name, id_product) VALUES ( 'Tillman, Wisozk and Bergstrom', 5);

INSERT INTO publisher ( name) VALUES ( 'Mynte');
INSERT INTO publisher ( name) VALUES ( 'Skilith');
INSERT INTO publisher ( name) VALUES ( 'Nlounge');
INSERT INTO publisher ( name) VALUES ( 'Zoonder');
INSERT INTO publisher ( name) VALUES ( 'Thoughtblab');
INSERT INTO publisher ( name) VALUES ( 'Flashdog');
INSERT INTO publisher ( name) VALUES ( 'Plajo');
INSERT INTO publisher ( name) VALUES ( 'Jaxworks');

INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (1, 12, '221867981-7', 1);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (2, 18, '330441159-3', 2);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (3, 4, '160268660-2', 3);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (4, 13, '700935313-1', 4);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (5, 9, '520123076-8', 5);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (6, 19, '604838590-0', 6);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (7, 3, '451723505-2', 7);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (8, 2, '384500643-7', 8);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (9, 2, '190501937-6', 7);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (10, 2, '195924643-8', 8);

INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (11, 'Stavudine', 'real-time', 11);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (12, 'PINUS STROBUS POLLEN', 'Enhanced', 12);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (13, 'Tolnaftate', 'Reduced', 13);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (14, 'McKesson Unna Boot with Calamine 4', 'Pre-emptive', 14);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (15, 'Valacyclovir Hydrochloride', 'Switchable', 15);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (16, 'Argentite Urtica Special order', 'hybrid', 16);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (17, 'Dove', 'functionalities', 17);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (18, 'EMBEDA', 'archive', 18);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (19, 'Matte Moisturizer SPF 15', 'multi-tasking', 19);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (20, 'IOPE BRIGHTGEN', 'human-resource', 20);

INSERT INTO funkoPop (id_product, number_pop) VALUES (21, 1803);
INSERT INTO funkoPop (id_product, number_pop) VALUES (22, 3446);
INSERT INTO funkoPop (id_product, number_pop) VALUES (23, 1923);
INSERT INTO funkoPop (id_product, number_pop) VALUES (24, 1625);
INSERT INTO funkoPop (id_product, number_pop) VALUES (25, 1512);
INSERT INTO funkoPop (id_product, number_pop) VALUES (26, 108);
INSERT INTO funkoPop (id_product, number_pop) VALUES (27, 1005);
INSERT INTO funkoPop (id_product, number_pop) VALUES (28, 829);
INSERT INTO funkoPop (id_product, number_pop) VALUES (29, 3028);
INSERT INTO funkoPop (id_product, number_pop) VALUES (30, 2990);

INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Persistent incremental monitoring', 2, '9/24/2022', 1, 4);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Phased 5th generation workforce', 5, '7/18/2022', 2, 6);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Total homogeneous product', 4, '7/18/2022', 3, 9);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Multi-channelled multi-tasking matrices', 1, '7/20/2022', 4, 12);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Synergistic background intranet', 4, '5/6/2022', 5, 14);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Virtual system-worthy extranet', 1, '10/14/2022', 6, 1);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Quality-focused intangible access', 2, '2/9/2022', 7, 13);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Focused impactful help-desk', 2, '10/7/2022', 8, 3);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Diverse holistic moderator', 1, '6/10/2022', 9, 9);
INSERT INTO review ( comment, rating, review_date, id_product, id_user) VALUES ( 'Grass-roots interactive framework', 4, '2/12/2022', 10, 21);

INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Multi-lateral bi-directional circuit', 3, 4, 11);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Right-sized grid-enabled capacity', 4, 6, 3);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Integrated zero tolerance function', 2, 1, 6);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Multi-channelled dynamic moderator', 4, 9, 20);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Programmable bi-directional orchestration', 4, 2, 19);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Business-focused heuristic capacity', 3, 1, 19);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Quality-focused system-worthy middleware', 4, 6, 1);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Synergistic tertiary encryption', 3, 7, 13);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Optional tertiary firmware', 1, 1, 14);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Right-sized responsive protocol', 1, 1, 7);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Focused impactful groupware', 5, 2, 20);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Down-sized dynamic utilisation', 5, 3, 21);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Organized analyzing flexibility', 5, 5, 19);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Diverse multi-tasking architecture', 3, 6, 20);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Digitized well-modulated migration', 4, 10, 4);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Re-contextualized fresh-thinking ability', 4, 3, 18);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Persistent uniform task-force', 5, 5, 13);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Decentralized logistical algorithm', 2, 5, 2);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Devolved foreground pricing structure', 3, 2, 21);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Business-focused heuristic capacity', 4, 2, 20);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Open-source intermediate workforce', 5, 10, 2);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Multi-channelled holistic matrix', 2, 6, 11);
INSERT INTO comment ( Content, Rating, id_review, id_user) VALUES ( 'Robust zero tolerance success', 5, 4, 12);

INSERT INTO author ( name, url) VALUES ( 'Thorsten Wilce', 'https://narod.ru/eget/tempus/vel/pede/morbi.aspx?pede=in&libero=est&quis=risus&orci=auctor&nullam=sed&molestie=tristique&nibh=in&in=tempus&lectus=sit&pellentesque=amet&at=sem&nulla=fusce&suspendisse=consequat&potenti=nulla&cras=nisl&in=nunc&purus=nisl&eu=duis&magna=bibendum&vulputate=felis&luctus=sed&cum=interdum&sociis=venenatis&natoque=turpis&penatibus=enim&et=blandit&magnis=mi&dis=in&parturient=porttitor&montes=pede&nascetur=justo&ridiculus=eu&mus=massa&vivamus=donec&vestibulum=dapibus&sagittis=duis&sapien=at&cum=velit&sociis=eu&natoque=est&penatibus=congue&et=elementum&magnis=in&dis=hac&parturient=habitasse&montes=platea&nascetur=dictumst&ridiculus=morbi&mus=vestibulum&etiam=velit&vel=id&augue=pretium&vestibulum=iaculis&rutrum=diam&rutrum=erat&neque=fermentum&aenean=justo&auctor=nec&gravida=condimentum&sem=neque&praesent=sapien&id=placerat&massa=ante&id=nulla&nisl=justo&venenatis=aliquam&lacinia=quis');
INSERT INTO author ( name, url) VALUES ( 'Rori Halshaw', 'https://unesco.org/lorem/ipsum/dolor.html?accumsan=proin&tellus=risus&nisi=praesent&eu=lectus&orci=vestibulum&mauris=quam&lacinia=sapien&sapien=varius&quis=ut&libero=blandit&nullam=non&sit=interdum&amet=in&turpis=ante&elementum=vestibulum&ligula=ante&vehicula=ipsum&consequat=primis&morbi=in&a=faucibus&ipsum=orci');
INSERT INTO author ( name, url) VALUES ( 'Dorothea Cafferky', 'http://japanpost.jp/platea/dictumst/etiam.json?id=eget&lobortis=eros&convallis=elementum&tortor=pellentesque&risus=quisque&dapibus=porta&augue=volutpat&vel=erat&accumsan=quisque&tellus=erat&nisi=eros&eu=viverra&orci=eget');
INSERT INTO author ( name, url) VALUES ( 'Averell Aucott', 'https://admin.ch/morbi/ut/odio/cras.html?nisl=erat&aenean=fermentum&lectus=justo&pellentesque=nec&eget=condimentum&nunc=neque&donec=sapien&quis=placerat&orci=ante&eget=nulla&orci=justo&vehicula=aliquam&condimentum=quis&curabitur=turpis&in=eget&libero=elit&ut=sodales&massa=scelerisque&volutpat=mauris&convallis=sit&morbi=amet&odio=eros&odio=suspendisse&elementum=accumsan&eu=tortor&interdum=quis&eu=turpis&tincidunt=sed&in=ante&leo=vivamus&maecenas=tortor&pulvinar=duis&lobortis=mattis&est=egestas');
INSERT INTO author ( name, url) VALUES ( 'Brear Fonzone', 'https://last.fm/ornare/imperdiet/sapien/urna/pretium.jsp?nunc=tempus&nisl=sit&duis=amet&bibendum=sem&felis=fusce&sed=consequat&interdum=nulla&venenatis=nisl&turpis=nunc&enim=nisl&blandit=duis&mi=bibendum&in=felis&porttitor=sed&pede=interdum&justo=venenatis&eu=turpis&massa=enim&donec=blandit&dapibus=mi&duis=in&at=porttitor&velit=pede&eu=justo&est=eu&congue=massa&elementum=donec&in=dapibus&hac=duis&habitasse=at&platea=velit&dictumst=eu&morbi=est&vestibulum=congue&velit=elementum&id=in&pretium=hac&iaculis=habitasse&diam=platea&erat=dictumst&fermentum=morbi&justo=vestibulum&nec=velit&condimentum=id&neque=pretium&sapien=iaculis&placerat=diam&ante=erat&nulla=fermentum&justo=justo&aliquam=nec&quis=condimentum&turpis=neque&eget=sapien&elit=placerat&sodales=ante&scelerisque=nulla&mauris=justo&sit=aliquam');
INSERT INTO author ( name, url) VALUES ( 'Mischa Fussey', 'https://e-recht24.de/tristique/est/et/tempus.jpg?est=sit&risus=amet&auctor=erat&sed=nulla&tristique=tempus&in=vivamus&tempus=in&sit=felis&amet=eu&sem=sapien&fusce=cursus&consequat=vestibulum&nulla=proin&nisl=eu&nunc=mi&nisl=nulla&duis=ac&bibendum=enim&felis=in&sed=tempor&interdum=turpis&venenatis=nec&turpis=euismod&enim=scelerisque&blandit=quam&mi=turpis&in=adipiscing&porttitor=lorem&pede=vitae&justo=mattis&eu=nibh&massa=ligula&donec=nec&dapibus=sem&duis=duis&at=aliquam&velit=convallis&eu=nunc&est=proin&congue=at&elementum=turpis&in=a&hac=pede&habitasse=posuere&platea=nonummy&dictumst=integer&morbi=non&vestibulum=velit&velit=donec&id=diam&pretium=neque&iaculis=vestibulum&diam=eget&erat=vulputate&fermentum=ut&justo=ultrices&nec=vel&condimentum=augue&neque=vestibulum&sapien=ante&placerat=ipsum&ante=primis&nulla=in&justo=faucibus&aliquam=orci&quis=luctus&turpis=et&eget=ultrices&elit=posuere&sodales=cubilia&scelerisque=curae');
INSERT INTO author ( name, url) VALUES ( 'Franzen Swapp', 'https://slashdot.org/vestibulum/sagittis/sapien/cum/sociis/natoque/penatibus.jsp?in=a&hac=odio&habitasse=in&platea=hac&dictumst=habitasse&etiam=platea&faucibus=dictumst&cursus=maecenas&urna=ut&ut=massa&tellus=quis&nulla=augue&ut=luctus&erat=tincidunt&id=nulla&mauris=mollis&vulputate=molestie&elementum=lorem&nullam=quisque&varius=ut&nulla=erat&facilisi=curabitur&cras=gravida&non=nisi&velit=at&nec=nibh&nisi=in&vulputate=hac&nonummy=habitasse&maecenas=platea&tincidunt=dictumst&lacus=aliquam&at=augue&velit=quam&vivamus=sollicitudin&vel=vitae&nulla=consectetuer&eget=eget&eros=rutrum&elementum=at&pellentesque=lorem&quisque=integer&porta=tincidunt&volutpat=ante&erat=vel&quisque=ipsum&erat=praesent&eros=blandit&viverra=lacinia&eget=erat&congue=vestibulum&eget=sed&semper=magna&rutrum=at&nulla=nunc&nunc=commodo&purus=placerat&phasellus=praesent&in=blandit&felis=nam&donec=nulla');
INSERT INTO author ( name, url) VALUES ( 'Charley Scown', 'http://unesco.org/vivamus.aspx?ipsum=donec&praesent=vitae&blandit=nisi&lacinia=nam&erat=ultrices&vestibulum=libero&sed=non&magna=mattis&at=pulvinar&nunc=nulla&commodo=pede&placerat=ullamcorper&praesent=augue&blandit=a&nam=suscipit&nulla=nulla&integer=elit&pede=ac&justo=nulla&lacinia=sed&eget=vel&tincidunt=enim&eget=sit&tempus=amet&vel=nunc&pede=viverra&morbi=dapibus&porttitor=nulla&lorem=suscipit&id=ligula&ligula=in&suspendisse=lacus&ornare=curabitur&consequat=at&lectus=ipsum');
INSERT INTO author ( name, url) VALUES ( 'Astrix Ruddell', 'https://shareasale.com/consequat/morbi.png?in=risus&porttitor=praesent&pede=lectus&justo=vestibulum&eu=quam&massa=sapien&donec=varius&dapibus=ut&duis=blandit&at=non&velit=interdum&eu=in&est=ante&congue=vestibulum&elementum=ante&in=ipsum&hac=primis&habitasse=in&platea=faucibus&dictumst=orci&morbi=luctus&vestibulum=et&velit=ultrices&id=posuere&pretium=cubilia&iaculis=curae&diam=duis&erat=faucibus&fermentum=accumsan&justo=odio&nec=curabitur&condimentum=convallis&neque=duis&sapien=consequat&placerat=dui&ante=nec&nulla=nisi&justo=volutpat');
INSERT INTO author ( name, url) VALUES ( 'Margaretta Scraney', 'http://jugem.jp/amet/eros/suspendisse/accumsan/tortor/quis.aspx?enim=risus&blandit=dapibus&mi=augue');
INSERT INTO author ( name, url) VALUES ( 'Cathy Tesche', 'https://tamu.edu/tellus/in.jsp?quis=odio&orci=in&eget=hac&orci=habitasse&vehicula=platea&condimentum=dictumst&curabitur=maecenas&in=ut&libero=massa&ut=quis&massa=augue');
INSERT INTO author ( name, url) VALUES ( 'Audre McSperron', 'http://bloglines.com/eget/semper/rutrum/nulla/nunc/purus/phasellus.png?rutrum=vestibulum&at=velit&lorem=id&integer=pretium&tincidunt=iaculis&ante=diam&vel=erat&ipsum=fermentum&praesent=justo&blandit=nec&lacinia=condimentum&erat=neque&vestibulum=sapien&sed=placerat&magna=ante&at=nulla&nunc=justo&commodo=aliquam&placerat=quis&praesent=turpis&blandit=eget&nam=elit&nulla=sodales&integer=scelerisque&pede=mauris&justo=sit&lacinia=amet&eget=eros&tincidunt=suspendisse&eget=accumsan&tempus=tortor&vel=quis&pede=turpis&morbi=sed&porttitor=ante&lorem=vivamus&id=tortor&ligula=duis&suspendisse=mattis&ornare=egestas&consequat=metus&lectus=aenean&in=fermentum&est=donec&risus=ut&auctor=mauris');
INSERT INTO author ( name, url) VALUES ( 'Bernie Croome', 'http://columbia.edu/donec/vitae/nisi/nam.js?eleifend=enim&luctus=leo&ultricies=rhoncus&eu=sed&nibh=vestibulum&quisque=sit&id=amet&justo=cursus&sit=id&amet=turpis&sapien=integer&dignissim=aliquet&vestibulum=massa&vestibulum=id&ante=lobortis&ipsum=convallis&primis=tortor&in=risus&faucibus=dapibus&orci=augue&luctus=vel&et=accumsan&ultrices=tellus&posuere=nisi&cubilia=eu&curae=orci&nulla=mauris&dapibus=lacinia&dolor=sapien');
INSERT INTO author ( name, url) VALUES ( 'Grethel Suett', 'http://infoseek.co.jp/nam/tristique/tortor/eu/pede.aspx?sapien=ornare&sapien=imperdiet&non=sapien&mi=urna&integer=pretium&ac=nisl&neque=ut&duis=volutpat&bibendum=sapien&morbi=arcu&non=sed&quam=augue&nec=aliquam&dui=erat&luctus=volutpat&rutrum=in&nulla=congue&tellus=etiam&in=justo&sagittis=etiam&dui=pretium&vel=iaculis&nisl=justo&duis=in&ac=hac&nibh=habitasse&fusce=platea&lacus=dictumst&purus=etiam&aliquet=faucibus&at=cursus&feugiat=urna&non=ut&pretium=tellus&quis=nulla&lectus=ut&suspendisse=erat&potenti=id&in=mauris&eleifend=vulputate&quam=elementum&a=nullam&odio=varius&in=nulla');
INSERT INTO author ( name, url) VALUES ( 'Corly Orgen', 'https://hud.gov/phasellus/in/felis/donec/semper/sapien/a.xml?odio=quis&curabitur=orci&convallis=nullam&duis=molestie&consequat=nibh&dui=in&nec=lectus&nisi=pellentesque&volutpat=at&eleifend=nulla&donec=suspendisse&ut=potenti&dolor=cras&morbi=in&vel=purus&lectus=eu&in=magna&quam=vulputate&fringilla=luctus&rhoncus=cum&mauris=sociis&enim=natoque&leo=penatibus&rhoncus=et&sed=magnis&vestibulum=dis&sit=parturient&amet=montes&cursus=nascetur&id=ridiculus&turpis=mus&integer=vivamus&aliquet=vestibulum&massa=sagittis&id=sapien&lobortis=cum&convallis=sociis&tortor=natoque&risus=penatibus&dapibus=et&augue=magnis&vel=dis&accumsan=parturient&tellus=montes&nisi=nascetur&eu=ridiculus&orci=mus&mauris=etiam&lacinia=vel&sapien=augue&quis=vestibulum&libero=rutrum&nullam=rutrum&sit=neque&amet=aenean&turpis=auctor&elementum=gravida&ligula=sem&vehicula=praesent&consequat=id&morbi=massa&a=id&ipsum=nisl&integer=venenatis&a=lacinia&nibh=aenean&in=sit&quis=amet&justo=justo&maecenas=morbi&rhoncus=ut&aliquam=odio&lacus=cras&morbi=mi&quis=pede&tortor=malesuada&id=in&nulla=imperdiet&ultrices=et&aliquet=commodo&maecenas=vulputate&leo=justo&odio=in&condimentum=blandit&id=ultrices&luctus=enim&nec=lorem&molestie=ipsum&sed=dolor&justo=sit&pellentesque=amet&viverra=consectetuer&pede=adipiscing&ac=elit&diam=proin');
INSERT INTO author ( name, url) VALUES ( 'Lexy Satterfitt', 'http://cornell.edu/in/magna/bibendum/imperdiet/nullam/orci/pede.aspx?nisi=quam&venenatis=nec&tristique=dui&fusce=luctus&congue=rutrum');
INSERT INTO author ( name, url) VALUES ( 'Kevon Gilbanks', 'https://arstechnica.com/luctus/cum/sociis/natoque/penatibus/et/magnis.png?quam=adipiscing&suspendisse=elit&potenti=proin&nullam=interdum&porttitor=mauris&lacus=non&at=ligula&turpis=pellentesque&donec=ultrices&posuere=phasellus&metus=id&vitae=sapien&ipsum=in&aliquam=sapien&non=iaculis&mauris=congue&morbi=vivamus&non=metus&lectus=arcu&aliquam=adipiscing&sit=molestie&amet=hendrerit&diam=at&in=vulputate&magna=vitae&bibendum=nisl&imperdiet=aenean&nullam=lectus&orci=pellentesque&pede=eget&venenatis=nunc&non=donec&sodales=quis&sed=orci&tincidunt=eget&eu=orci&felis=vehicula&fusce=condimentum&posuere=curabitur&felis=in&sed=libero&lacus=ut&morbi=massa&sem=volutpat&mauris=convallis&laoreet=morbi&ut=odio&rhoncus=odio&aliquet=elementum&pulvinar=eu&sed=interdum&nisl=eu&nunc=tincidunt&rhoncus=in&dui=leo&vel=maecenas&sem=pulvinar&sed=lobortis&sagittis=est&nam=phasellus');
INSERT INTO author ( name, url) VALUES ( 'Mariejeanne Gladstone', 'http://nydailynews.com/convallis/nulla.aspx?consequat=blandit&metus=nam&sapien=nulla&ut=integer&nunc=pede&vestibulum=justo&ante=lacinia&ipsum=eget&primis=tincidunt&in=eget&faucibus=tempus&orci=vel&luctus=pede&et=morbi&ultrices=porttitor&posuere=lorem&cubilia=id&curae=ligula&mauris=suspendisse&viverra=ornare&diam=consequat&vitae=lectus&quam=in&suspendisse=est&potenti=risus&nullam=auctor&porttitor=sed&lacus=tristique&at=in&turpis=tempus&donec=sit&posuere=amet&metus=sem&vitae=fusce&ipsum=consequat&aliquam=nulla&non=nisl&mauris=nunc&morbi=nisl&non=duis&lectus=bibendum&aliquam=felis&sit=sed&amet=interdum&diam=venenatis&in=turpis&magna=enim&bibendum=blandit&imperdiet=mi&nullam=in&orci=porttitor');
INSERT INTO author ( name, url) VALUES ( 'Clement Whitington', 'http://seattletimes.com/nulla/integer/pede/justo.png?congue=duis&diam=bibendum&id=felis&ornare=sed&imperdiet=interdum&sapien=venenatis&urna=turpis&pretium=enim&nisl=blandit&ut=mi&volutpat=in&sapien=porttitor&arcu=pede&sed=justo&augue=eu&aliquam=massa&erat=donec&volutpat=dapibus&in=duis&congue=at&etiam=velit&justo=eu&etiam=est&pretium=congue&iaculis=elementum&justo=in&in=hac&hac=habitasse&habitasse=platea&platea=dictumst&dictumst=morbi&etiam=vestibulum&faucibus=velit&cursus=id&urna=pretium&ut=iaculis&tellus=diam&nulla=erat&ut=fermentum&erat=justo&id=nec&mauris=condimentum&vulputate=neque&elementum=sapien&nullam=placerat&varius=ante&nulla=nulla&facilisi=justo&cras=aliquam&non=quis&velit=turpis&nec=eget&nisi=elit&vulputate=sodales&nonummy=scelerisque&maecenas=mauris&tincidunt=sit&lacus=amet&at=eros');
INSERT INTO author ( name, url) VALUES ( 'Addie Savin', 'https://cdbaby.com/ut.json?vel=in&accumsan=hac&tellus=habitasse&nisi=platea&eu=dictumst&orci=etiam&mauris=faucibus&lacinia=cursus&sapien=urna&quis=ut&libero=tellus&nullam=nulla&sit=ut&amet=erat&turpis=id&elementum=mauris&ligula=vulputate&vehicula=elementum&consequat=nullam&morbi=varius&a=nulla&ipsum=facilisi&integer=cras&a=non&nibh=velit&in=nec&quis=nisi&justo=vulputate&maecenas=nonummy&rhoncus=maecenas&aliquam=tincidunt&lacus=lacus&morbi=at&quis=velit&tortor=vivamus&id=vel&nulla=nulla&ultrices=eget&aliquet=eros&maecenas=elementum&leo=pellentesque&odio=quisque&condimentum=porta&id=volutpat&luctus=erat&nec=quisque');

INSERT INTO authorBook (id_author, id_book) VALUES (1, 1);
INSERT INTO authorBook (id_author, id_book) VALUES (2, 2);
INSERT INTO authorBook (id_author, id_book) VALUES (3, 3);
INSERT INTO authorBook (id_author, id_book) VALUES (4, 4);
INSERT INTO authorBook (id_author, id_book) VALUES (5, 5);
INSERT INTO authorBook (id_author, id_book) VALUES (6, 6);
INSERT INTO authorBook (id_author, id_book) VALUES (7, 7);
INSERT INTO authorBook (id_author, id_book) VALUES (8, 8);

INSERT INTO color ( color_name) VALUES ( 'Goldenrod');
INSERT INTO color ( color_name) VALUES ( 'Pink');
INSERT INTO color ( color_name) VALUES ( 'Orange');
INSERT INTO color ( color_name) VALUES ( 'Goldenrod');
INSERT INTO color ( color_name) VALUES ( 'Blue');
INSERT INTO color ( color_name) VALUES ( 'Blue');
INSERT INTO color ( color_name) VALUES ( 'Orange');
INSERT INTO color ( color_name) VALUES ( 'Violet');
INSERT INTO color ( color_name) VALUES ( 'Indigo');
INSERT INTO color ( color_name) VALUES ( 'Aquamarine');
INSERT INTO color ( color_name) VALUES ( 'Crimson');
INSERT INTO color ( color_name) VALUES ( 'Aquamarine');
INSERT INTO color ( color_name) VALUES ( 'Orange');
INSERT INTO color ( color_name) VALUES ( 'Fuscia');
INSERT INTO color ( color_name) VALUES ( 'Mauv');
INSERT INTO color ( color_name) VALUES ( 'Purple');
INSERT INTO color ( color_name) VALUES ( 'Puce');
INSERT INTO color ( color_name) VALUES ( 'Teal');
INSERT INTO color ( color_name) VALUES ( 'Green');
INSERT INTO color ( color_name) VALUES ( 'Crimson');
INSERT INTO color ( color_name) VALUES ( 'Violet');
INSERT INTO color ( color_name) VALUES ( 'Orange');
INSERT INTO color ( color_name) VALUES ( 'Crimson');
INSERT INTO color ( color_name) VALUES ( 'Yellow');
INSERT INTO color ( color_name) VALUES ( 'Blue');
INSERT INTO color ( color_name) VALUES ( 'Green');
INSERT INTO color ( color_name) VALUES ( 'Puce');
INSERT INTO color ( color_name) VALUES ( 'Blue');
INSERT INTO color ( color_name) VALUES ( 'Indigo');
INSERT INTO color ( color_name) VALUES ( 'Khaki');
INSERT INTO color ( color_name) VALUES ( 'Khaki');
INSERT INTO color ( color_name) VALUES ( 'Crimson');
INSERT INTO color ( color_name) VALUES ( 'Teal');
INSERT INTO color ( color_name) VALUES ( 'Pink');
INSERT INTO color ( color_name) VALUES ( 'Turquoise');
INSERT INTO color ( color_name) VALUES ( 'Green');
INSERT INTO color ( color_name) VALUES ( 'Purple');
INSERT INTO color ( color_name) VALUES ( 'Green');
INSERT INTO color ( color_name) VALUES ( 'Red');
INSERT INTO color ( color_name) VALUES ( 'Goldenrod');
INSERT INTO color ( color_name) VALUES ( 'Red');
INSERT INTO color ( color_name) VALUES ( 'Pink');
INSERT INTO color ( color_name) VALUES ( 'Yellow');
INSERT INTO color ( color_name) VALUES ( 'Indigo');
INSERT INTO color ( color_name) VALUES ( 'Green');
INSERT INTO color ( color_name) VALUES ( 'Violet');
INSERT INTO color ( color_name) VALUES ( 'Pink');
INSERT INTO color ( color_name) VALUES ( 'Turquoise');
INSERT INTO color ( color_name) VALUES ( 'Teal');
INSERT INTO color ( color_name) VALUES ( 'Red');

INSERT INTO size ( size_eu, size_us) VALUES ( 38, 6);
INSERT INTO size ( size_eu, size_us) VALUES ( 38.5, 6.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 39, 6.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 39.5, 7);
INSERT INTO size ( size_eu, size_us) VALUES ( 40, 7.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 40.5, 8);
INSERT INTO size ( size_eu, size_us) VALUES ( 41, 8);
INSERT INTO size ( size_eu, size_us) VALUES ( 41.5, 8.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 42, 9);
INSERT INTO size ( size_eu, size_us) VALUES ( 42.5, 9.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 43, 10);
INSERT INTO size ( size_eu, size_us) VALUES ( 43.5, 10.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 44, 10.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 44.5, 11);
INSERT INTO size ( size_eu, size_us) VALUES ( 45, 11.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 45.5, 12);
INSERT INTO size ( size_eu, size_us) VALUES ( 46, 12);
INSERT INTO size ( size_eu, size_us) VALUES ( 46.5, 12.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 47, 13);
INSERT INTO size ( size_eu, size_us) VALUES ( 47.5, 13.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 48, 13.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 48.5, 14);
INSERT INTO size ( size_eu, size_us) VALUES ( 49, 14);
INSERT INTO size ( size_eu, size_us) VALUES ( 49.5, 14.5);
INSERT INTO size ( size_eu, size_us) VALUES ( 50, 15);

INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (11, 25, 40, 16);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (12, 48, 40, 7);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (13, 31, 13, 18);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (14, 9, 11, 18);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (15, 20, 36, 24);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (16, 2, 2, 10);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (17, 33, 46, 9);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (18, 19, 16, 8);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (19, 9, 2, 2);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (20, 40, 25, 4);

INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 1, 1);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 2, 2);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 3, 3);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 4, 4);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 5, 5);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 6, 6);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 7, 7);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 8, 8);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 9, 9);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 10, 10);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 11, 11);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 12, 12);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 13, 13);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 14, 14);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 15, 15);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 16, 16);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 17, 17);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 18, 18);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 19, 19);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 20, 20);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 21, 21);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 22, 22);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 23, 23);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 24, 24);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 25, 25);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 26, 26);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 27, 27);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 28, 28);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 29, 29);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 30, 30);

INSERT INTO flagged (reason, id_review, id_comment) VALUES ('Spam',1,null);

-- IDX01  It's useful for searching products of a certain product that have the price lower than a certain value defined much faster,
CREATE INDEX product_price_idx ON product USING btree (price);

-- IDX02  Every time we need to make a query to get the address of an user, it has to be fast, because it can be executed several times
CREATE INDEX address_iduser_idx ON addressBook USING hash (id_user);

-- IDX03  Every time we need to make a query to get an order of any user, it has to be fast, because it can be executed several time
CREATE INDEX order_iduser_idx ON ord USING hash (id_user);

-- IDX04 To improve overall performance of full-text searches while searching for products by name.
CREATE INDEX search_product_name_idx ON product USING GIST (to_tsvector('english', name));



-- TRIGGER02
-- This trigger will it so a user can't buy more than the available quantity. (ABR.02)


CREATE OR REPLACE FUNCTION check_if_enough_stock() RETURNS TRIGGER AS
    $BODY$
    BEGIN
        IF EXISTS (
          SELECT productOrd.quantity
          FROM productOrd, product, ord WHERE productOrd.id_product = product.id_product AND productOrd.id_ord = Ord.id_ord AND productOrd.quantity > product.stock_quantity) THEN
           RAISE EXCEPTION 'There isn''t enough stock of products for the order.';
        END IF;
        RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_stock
        BEFORE INSERT OR UPDATE ON productOrd
        FOR EACH ROW
        EXECUTE PROCEDURE check_if_enough_stock();

-- TRIGGER03
-- This trigger will make users unable to make comments or reports on their own reviews (BR.013)

CREATE OR REPLACE FUNCTION check_own_review() RETURNS TRIGGER AS
    $BODY$
    BEGIN
        IF EXISTS (
            SELECT *
            FROM review WHERE review.id_user = New.id_user) THEN
        RAISE EXCEPTION 'User cannot comment or report its own review.';
        END IF;
        RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_own_review_flag
    BEFORE INSERT OR UPDATE ON flagged
    FOR EACH ROW
    EXECUTE PROCEDURE check_own_review();


CREATE TRIGGER check_own_review_comment
    BEFORE INSERT OR UPDATE ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE check_own_review();



-- TRIGGER04

-- Description
-- This trigger will make it so a user can only review a specific product once.(ABR.03)

CREATE OR REPLACE FUNCTION check_review_amount() RETURNS TRIGGER AS
    $BODY$
    BEGIN
        IF EXISTS (
            SELECT *
            FROM review WHERE review.id_product = New.id_product AND
            review.id_user = New.id_user
            ) THEN
            RAISE EXCEPTION 'User cannot have more reviews than purchased items';
        END IF;
        RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_review_amount
    BEFORE INSERT ON Review
    FOR EACH ROW
    EXECUTE PROCEDURE check_review_amount();




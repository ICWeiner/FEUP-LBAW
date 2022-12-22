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
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  year INTEGER NOT NULL,
  rating FLOAT NOT NULL CHECK (rating >=0 AND rating <= 5),
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


INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Shinji', 'shinji@mail.com', '$2y$10$bE7fMVTJYEIPB69ssRQRTO4Jjr9UHpE.BD2KcnL1o1yd7/fZOMfha', TRUE, FALSE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Asuka', 'asuka@mail.com', '$2y$10$U2zRchRSIh5b8M/0wx2ZgOEI2fkMMpL5pbOwJkmUNbX4yIXahNP5q', FALSE, TRUE);
INSERT INTO users ( name, email, password, user_is_banned, user_is_admin) VALUES ( 'Rei', 'rei@mail.com', '$2y$10$KJ4gx2LEnS.DDlU0oe2PjuQUI81Xq5X/c0rznfwQd3Jj9Of1nAi2S', FALSE, FALSE);
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

INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 233.2, 59, 63, 'http://yale.edu/porta/volutpat/erat/quisque/erat/eros/viverra.html?convallis=suspendisse&tortor=potenti&risus=cras&dapibus=in&augue=purus&vel=eu&accumsan=magna&tellus=vulputate&nisi=luctus&eu=cum&orci=sociis&mauris=natoque&lacinia=penatibus&sapien=et&quis=magnis&libero=dis&nullam=parturient&sit=montes&amet=nascetur&turpis=ridiculus&elementum=mus&ligula=vivamus&vehicula=vestibulum&consequat=sagittis&morbi=sapien&a=cum&ipsum=sociis&integer=natoque&a=penatibus&nibh=et&in=magnis&quis=dis&justo=parturient&maecenas=montes&rhoncus=nascetur&aliquam=ridiculus&lacus=mus&morbi=etiam&quis=vel&tortor=augue', 2002, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 221.4, 40, 15, 'http://domainmarket.com/luctus/et.json?mus=morbi&etiam=vel&vel=lectus&augue=in&vestibulum=quam&rutrum=fringilla&rutrum=rhoncus&neque=mauris&aenean=enim&auctor=leo&gravida=rhoncus&sem=sed&praesent=vestibulum&id=sit&massa=amet&id=cursus&nisl=id&venenatis=turpis&lacinia=integer&aenean=aliquet&sit=massa&amet=id&justo=lobortis&morbi=convallis&ut=tortor&odio=risus&cras=dapibus&mi=augue&pede=vel&malesuada=accumsan&in=tellus&imperdiet=nisi&et=eu&commodo=orci&vulputate=mauris&justo=lacinia&in=sapien&blandit=quis&ultrices=libero&enim=nullam&lorem=sit&ipsum=amet&dolor=turpis&sit=elementum&amet=ligula&consectetuer=vehicula&adipiscing=consequat&elit=morbi&proin=a&interdum=ipsum&mauris=integer&non=a&ligula=nibh&pellentesque=in&ultrices=quis&phasellus=justo&id=maecenas&sapien=rhoncus&in=aliquam&sapien=lacus&iaculis=morbi&congue=quis&vivamus=tortor&metus=id&arcu=nulla&adipiscing=ultrices&molestie=aliquet&hendrerit=maecenas&at=leo&vulputate=odio&vitae=condimentum&nisl=id&aenean=luctus&lectus=nec&pellentesque=molestie&eget=sed&nunc=justo&donec=pellentesque', 2002, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 178.32, 71, 26, 'http://uol.com.br/consectetuer.jpg?lacinia=est&nisi=congue&venenatis=elementum&tristique=in&fusce=hac&congue=habitasse&diam=platea&id=dictumst&ornare=morbi&imperdiet=vestibulum&sapien=velit&urna=id&pretium=pretium&nisl=iaculis&ut=diam&volutpat=erat&sapien=fermentum&arcu=justo&sed=nec&augue=condimentum&aliquam=neque&erat=sapien&volutpat=placerat&in=ante&congue=nulla&etiam=justo&justo=aliquam&etiam=quis&pretium=turpis&iaculis=eget&justo=elit&in=sodales&hac=scelerisque&habitasse=mauris&platea=sit&dictumst=amet&etiam=eros&faucibus=suspendisse&cursus=accumsan&urna=tortor&ut=quis&tellus=turpis&nulla=sed&ut=ante&erat=vivamus&id=tortor&mauris=duis&vulputate=mattis', 2012, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 143.46, 99, 96, 'https://hexun.com/maecenas/leo/odio/condimentum/id/luctus.json?quis=duis&libero=mattis&nullam=egestas&sit=metus', 1993, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 191.48, 14, 52, 'http://diigo.com/vivamus/metus/arcu/adipiscing/molestie.aspx?quam=cum&turpis=sociis&adipiscing=natoque&lorem=penatibus&vitae=et&mattis=magnis&nibh=dis&ligula=parturient&nec=montes&sem=nascetur&duis=ridiculus&aliquam=mus&convallis=etiam', 2005, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 223.87, 66, 55, 'https://cisco.com/elementum/eu/interdum/eu/tincidunt.html?integer=mauris&a=vulputate&nibh=elementum&in=nullam&quis=varius&justo=nulla&maecenas=facilisi&rhoncus=cras&aliquam=non&lacus=velit&morbi=nec&quis=nisi&tortor=vulputate&id=nonummy&nulla=maecenas&ultrices=tincidunt&aliquet=lacus&maecenas=at&leo=velit&odio=vivamus&condimentum=vel&id=nulla&luctus=eget&nec=eros&molestie=elementum&sed=pellentesque&justo=quisque&pellentesque=porta&viverra=volutpat&pede=erat&ac=quisque&diam=erat&cras=eros&pellentesque=viverra&volutpat=eget&dui=congue&maecenas=eget&tristique=semper&est=rutrum&et=nulla&tempus=nunc&semper=purus&est=phasellus&quam=in&pharetra=felis&magna=donec&ac=semper&consequat=sapien&metus=a&sapien=libero&ut=nam&nunc=dui&vestibulum=proin&ante=leo&ipsum=odio&primis=porttitor&in=id&faucibus=consequat&orci=in&luctus=consequat&et=ut&ultrices=nulla&posuere=sed&cubilia=accumsan&curae=felis&mauris=ut&viverra=at&diam=dolor&vitae=quis&quam=odio&suspendisse=consequat', 1994, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 110.66, 93, 58, 'https://yolasite.com/ipsum/dolor/sit/amet/consectetuer.png?vel=consectetuer&sem=adipiscing&sed=elit&sagittis=proin&nam=interdum&congue=mauris&risus=non&semper=ligula&porta=pellentesque&volutpat=ultrices&quam=phasellus&pede=id&lobortis=sapien&ligula=in&sit=sapien&amet=iaculis&eleifend=congue&pede=vivamus&libero=metus&quis=arcu&orci=adipiscing&nullam=molestie&molestie=hendrerit&nibh=at&in=vulputate&lectus=vitae&pellentesque=nisl&at=aenean&nulla=lectus&suspendisse=pellentesque&potenti=eget&cras=nunc&in=donec&purus=quis&eu=orci&magna=eget&vulputate=orci&luctus=vehicula&cum=condimentum&sociis=curabitur&natoque=in&penatibus=libero&et=ut&magnis=massa&dis=volutpat&parturient=convallis&montes=morbi&nascetur=odio&ridiculus=odio&mus=elementum&vivamus=eu&vestibulum=interdum&sagittis=eu&sapien=tincidunt&cum=in&sociis=leo&natoque=maecenas&penatibus=pulvinar&et=lobortis&magnis=est&dis=phasellus&parturient=sit&montes=amet&nascetur=erat&ridiculus=nulla&mus=tempus&etiam=vivamus&vel=in&augue=felis&vestibulum=eu&rutrum=sapien&rutrum=cursus&neque=vestibulum&aenean=proin&auctor=eu&gravida=mi&sem=nulla&praesent=ac&id=enim&massa=in&id=tempor&nisl=turpis&venenatis=nec&lacinia=euismod&aenean=scelerisque&sit=quam&amet=turpis&justo=adipiscing&morbi=lorem&ut=vitae&odio=mattis&cras=nibh&mi=ligula&pede=nec&malesuada=sem&in=duis&imperdiet=aliquam&et=convallis&commodo=nunc', 1994, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 191.33, 61, 79, 'http://weather.com/magna/vulputate/luctus/cum/sociis/natoque.html?nibh=pede&ligula=malesuada&nec=in&sem=imperdiet&duis=et&aliquam=commodo&convallis=vulputate&nunc=justo&proin=in&at=blandit&turpis=ultrices&a=enim&pede=lorem&posuere=ipsum', 2000, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 205.35, 89, 78, 'https://ihg.com/varius/nulla/facilisi.jsp?suscipit=ac', 2007, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 22.22, 63, 24, 'https://com.com/eu/nibh/quisque/id.aspx?etiam=vitae&pretium=quam&iaculis=suspendisse&justo=potenti&in=nullam&hac=porttitor&habitasse=lacus&platea=at&dictumst=turpis&etiam=donec&faucibus=posuere&cursus=metus&urna=vitae&ut=ipsum&tellus=aliquam&nulla=non&ut=mauris&erat=morbi&id=non&mauris=lectus&vulputate=aliquam&elementum=sit&nullam=amet&varius=diam&nulla=in&facilisi=magna&cras=bibendum&non=imperdiet&velit=nullam&nec=orci&nisi=pede&vulputate=venenatis&nonummy=non&maecenas=sodales&tincidunt=sed&lacus=tincidunt&at=eu&velit=felis&vivamus=fusce&vel=posuere&nulla=felis&eget=sed&eros=lacus&elementum=morbi&pellentesque=sem&quisque=mauris&porta=laoreet&volutpat=ut&erat=rhoncus&quisque=aliquet&erat=pulvinar&eros=sed&viverra=nisl&eget=nunc&congue=rhoncus&eget=dui&semper=vel&rutrum=sem&nulla=sed&nunc=sagittis&purus=nam&phasellus=congue&in=risus&felis=semper&donec=porta&semper=volutpat&sapien=quam&a=pede&libero=lobortis&nam=ligula&dui=sit&proin=amet&leo=eleifend&odio=pede&porttitor=libero&id=quis&consequat=orci&in=nullam&consequat=molestie&ut=nibh&nulla=in&sed=lectus&accumsan=pellentesque&felis=at&ut=nulla&at=suspendisse&dolor=potenti&quis=cras&odio=in&consequat=purus&varius=eu&integer=magna&ac=vulputate&leo=luctus&pellentesque=cum&ultrices=sociis&mattis=natoque&odio=penatibus&donec=et&vitae=magnis', 1986, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 218.5, 64, 59, 'http://csmonitor.com/libero/ut/massa/volutpat/convallis.html?massa=montes&tempor=nascetur&convallis=ridiculus&nulla=mus&neque=etiam&libero=vel&convallis=augue&eget=vestibulum&eleifend=rutrum&luctus=rutrum&ultricies=neque&eu=aenean&nibh=auctor&quisque=gravida&id=sem&justo=praesent&sit=id&amet=massa&sapien=id&dignissim=nisl&vestibulum=venenatis&vestibulum=lacinia&ante=aenean&ipsum=sit&primis=amet&in=justo&faucibus=morbi&orci=ut&luctus=odio&et=cras&ultrices=mi&posuere=pede&cubilia=malesuada&curae=in&nulla=imperdiet&dapibus=et&dolor=commodo', 2005, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 131.93, 66, 57, 'http://narod.ru/facilisi/cras/non/velit/nec/nisi/vulputate.xml?at=ut&nulla=at&suspendisse=dolor&potenti=quis&cras=odio&in=consequat&purus=varius&eu=integer&magna=ac&vulputate=leo&luctus=pellentesque&cum=ultrices&sociis=mattis&natoque=odio&penatibus=donec&et=vitae&magnis=nisi&dis=nam&parturient=ultrices&montes=libero&nascetur=non&ridiculus=mattis&mus=pulvinar&vivamus=nulla&vestibulum=pede&sagittis=ullamcorper&sapien=augue&cum=a&sociis=suscipit&natoque=nulla&penatibus=elit&et=ac&magnis=nulla&dis=sed&parturient=vel&montes=enim&nascetur=sit&ridiculus=amet&mus=nunc&etiam=viverra&vel=dapibus&augue=nulla&vestibulum=suscipit&rutrum=ligula&rutrum=in&neque=lacus&aenean=curabitur&auctor=at&gravida=ipsum&sem=ac&praesent=tellus&id=semper&massa=interdum&id=mauris&nisl=ullamcorper&venenatis=purus&lacinia=sit&aenean=amet&sit=nulla&amet=quisque&justo=arcu&morbi=libero&ut=rutrum&odio=ac&cras=lobortis&mi=vel', 1987, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 83.06, 27, 99, 'http://delicious.com/tincidunt/eu.jsp?etiam=pede&justo=ac&etiam=diam&pretium=cras&iaculis=pellentesque&justo=volutpat&in=dui&hac=maecenas&habitasse=tristique&platea=est&dictumst=et&etiam=tempus&faucibus=semper&cursus=est&urna=quam&ut=pharetra&tellus=magna&nulla=ac&ut=consequat&erat=metus&id=sapien&mauris=ut&vulputate=nunc&elementum=vestibulum&nullam=ante&varius=ipsum&nulla=primis&facilisi=in&cras=faucibus&non=orci&velit=luctus&nec=et&nisi=ultrices&vulputate=posuere&nonummy=cubilia&maecenas=curae&tincidunt=mauris', 1997, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 12.87, 83, 17, 'https://printfriendly.com/justo/eu/massa/donec/dapibus/duis.png?amet=justo&consectetuer=sit&adipiscing=amet&elit=sapien&proin=dignissim&interdum=vestibulum&mauris=vestibulum&non=ante&ligula=ipsum&pellentesque=primis&ultrices=in&phasellus=faucibus&id=orci&sapien=luctus&in=et&sapien=ultrices&iaculis=posuere&congue=cubilia&vivamus=curae&metus=nulla&arcu=dapibus&adipiscing=dolor&molestie=vel&hendrerit=est&at=donec&vulputate=odio&vitae=justo&nisl=sollicitudin&aenean=ut&lectus=suscipit&pellentesque=a&eget=feugiat&nunc=et&donec=eros&quis=vestibulum&orci=ac&eget=est&orci=lacinia&vehicula=nisi&condimentum=venenatis&curabitur=tristique&in=fusce&libero=congue&ut=diam&massa=id&volutpat=ornare&convallis=imperdiet&morbi=sapien&odio=urna&odio=pretium&elementum=nisl&eu=ut&interdum=volutpat&eu=sapien&tincidunt=arcu&in=sed&leo=augue&maecenas=aliquam&pulvinar=erat&lobortis=volutpat&est=in&phasellus=congue&sit=etiam&amet=justo&erat=etiam&nulla=pretium&tempus=iaculis&vivamus=justo', 2013, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 161.4, 30, 83, 'http://liveinternet.ru/amet/erat/nulla/tempus.xml?vel=vestibulum&sem=proin&sed=eu&sagittis=mi&nam=nulla&congue=ac&risus=enim&semper=in&porta=tempor&volutpat=turpis&quam=nec&pede=euismod&lobortis=scelerisque&ligula=quam&sit=turpis&amet=adipiscing&eleifend=lorem&pede=vitae&libero=mattis&quis=nibh&orci=ligula&nullam=nec&molestie=sem&nibh=duis&in=aliquam&lectus=convallis&pellentesque=nunc&at=proin&nulla=at&suspendisse=turpis&potenti=a&cras=pede&in=posuere&purus=nonummy&eu=integer&magna=non&vulputate=velit&luctus=donec&cum=diam&sociis=neque&natoque=vestibulum&penatibus=eget&et=vulputate&magnis=ut&dis=ultrices&parturient=vel&montes=augue&nascetur=vestibulum&ridiculus=ante&mus=ipsum&vivamus=primis&vestibulum=in&sagittis=faucibus&sapien=orci', 2012, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 73.63, 24, 50, 'https://businessinsider.com/ultrices/libero.png?cum=purus&sociis=aliquet&natoque=at&penatibus=feugiat&et=non&magnis=pretium&dis=quis&parturient=lectus&montes=suspendisse&nascetur=potenti&ridiculus=in&mus=eleifend&vivamus=quam&vestibulum=a&sagittis=odio&sapien=in&cum=hac&sociis=habitasse&natoque=platea&penatibus=dictumst&et=maecenas&magnis=ut&dis=massa&parturient=quis&montes=augue&nascetur=luctus&ridiculus=tincidunt&mus=nulla&etiam=mollis&vel=molestie&augue=lorem&vestibulum=quisque&rutrum=ut&rutrum=erat&neque=curabitur&aenean=gravida&auctor=nisi&gravida=at&sem=nibh&praesent=in&id=hac&massa=habitasse&id=platea&nisl=dictumst&venenatis=aliquam&lacinia=augue&aenean=quam&sit=sollicitudin&amet=vitae&justo=consectetuer&morbi=eget&ut=rutrum&odio=at&cras=lorem&mi=integer&pede=tincidunt&malesuada=ante&in=vel&imperdiet=ipsum&et=praesent', 1994, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 131.01, 44, 90, 'https://irs.gov/aliquam/augue/quam/sollicitudin.jsp?quis=sed&turpis=vestibulum&eget=sit&elit=amet&sodales=cursus&scelerisque=id&mauris=turpis&sit=integer&amet=aliquet&eros=massa&suspendisse=id&accumsan=lobortis&tortor=convallis&quis=tortor&turpis=risus&sed=dapibus&ante=augue&vivamus=vel&tortor=accumsan&duis=tellus&mattis=nisi&egestas=eu&metus=orci&aenean=mauris&fermentum=lacinia&donec=sapien&ut=quis&mauris=libero&eget=nullam&massa=sit&tempor=amet&convallis=turpis&nulla=elementum&neque=ligula&libero=vehicula&convallis=consequat&eget=morbi&eleifend=a&luctus=ipsum&ultricies=integer&eu=a&nibh=nibh&quisque=in&id=quis&justo=justo&sit=maecenas&amet=rhoncus&sapien=aliquam&dignissim=lacus&vestibulum=morbi&vestibulum=quis&ante=tortor&ipsum=id&primis=nulla&in=ultrices&faucibus=aliquet&orci=maecenas&luctus=leo&et=odio&ultrices=condimentum&posuere=id&cubilia=luctus&curae=nec&nulla=molestie&dapibus=sed&dolor=justo&vel=pellentesque&est=viverra&donec=pede&odio=ac&justo=diam&sollicitudin=cras&ut=pellentesque&suscipit=volutpat&a=dui&feugiat=maecenas&et=tristique&eros=est&vestibulum=et&ac=tempus&est=semper&lacinia=est&nisi=quam&venenatis=pharetra&tristique=magna&fusce=ac&congue=consequat', 2008, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 141.92, 65, 9, 'https://chron.com/at/lorem/integer/tincidunt.html?augue=id&aliquam=pretium&erat=iaculis&volutpat=diam&in=erat&congue=fermentum&etiam=justo&justo=nec&etiam=condimentum&pretium=neque&iaculis=sapien&justo=placerat&in=ante&hac=nulla&habitasse=justo&platea=aliquam&dictumst=quis&etiam=turpis&faucibus=eget&cursus=elit&urna=sodales&ut=scelerisque&tellus=mauris&nulla=sit&ut=amet&erat=eros&id=suspendisse&mauris=accumsan&vulputate=tortor&elementum=quis&nullam=turpis&varius=sed&nulla=ante&facilisi=vivamus&cras=tortor&non=duis&velit=mattis&nec=egestas&nisi=metus&vulputate=aenean&nonummy=fermentum&maecenas=donec&tincidunt=ut&lacus=mauris&at=eget&velit=massa&vivamus=tempor&vel=convallis&nulla=nulla&eget=neque&eros=libero&elementum=convallis&pellentesque=eget&quisque=eleifend&porta=luctus&volutpat=ultricies', 2007, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 51.91, 100, 30, 'https://gov.uk/rhoncus/sed.jpg?ut=nullam&nunc=molestie&vestibulum=nibh&ante=in&ipsum=lectus&primis=pellentesque&in=at&faucibus=nulla&orci=suspendisse&luctus=potenti&et=cras&ultrices=in&posuere=purus&cubilia=eu&curae=magna&mauris=vulputate&viverra=luctus&diam=cum&vitae=sociis&quam=natoque&suspendisse=penatibus&potenti=et&nullam=magnis&porttitor=dis&lacus=parturient&at=montes&turpis=nascetur&donec=ridiculus&posuere=mus&metus=vivamus&vitae=vestibulum&ipsum=sagittis&aliquam=sapien&non=cum&mauris=sociis&morbi=natoque&non=penatibus&lectus=et&aliquam=magnis&sit=dis&amet=parturient&diam=montes&in=nascetur&magna=ridiculus&bibendum=mus&imperdiet=etiam&nullam=vel&orci=augue&pede=vestibulum&venenatis=rutrum', 2004, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 46.82, 37, 97, 'http://myspace.com/vestibulum/ante.aspx?maecenas=nec&tincidunt=euismod&lacus=scelerisque&at=quam&velit=turpis&vivamus=adipiscing&vel=lorem&nulla=vitae&eget=mattis&eros=nibh&elementum=ligula&pellentesque=nec&quisque=sem&porta=duis&volutpat=aliquam&erat=convallis&quisque=nunc&erat=proin&eros=at&viverra=turpis&eget=a&congue=pede&eget=posuere&semper=nonummy&rutrum=integer&nulla=non&nunc=velit&purus=donec&phasellus=diam&in=neque&felis=vestibulum&donec=eget&semper=vulputate&sapien=ut&a=ultrices&libero=vel&nam=augue&dui=vestibulum&proin=ante&leo=ipsum&odio=primis&porttitor=in&id=faucibus&consequat=orci&in=luctus&consequat=et&ut=ultrices&nulla=posuere&sed=cubilia&accumsan=curae&felis=donec&ut=pharetra&at=magna&dolor=vestibulum&quis=aliquet&odio=ultrices&consequat=erat&varius=tortor&integer=sollicitudin&ac=mi&leo=sit&pellentesque=amet&ultrices=lobortis&mattis=sapien&odio=sapien&donec=non&vitae=mi&nisi=integer&nam=ac&ultrices=neque&libero=duis&non=bibendum&mattis=morbi&pulvinar=non&nulla=quam&pede=nec&ullamcorper=dui&augue=luctus&a=rutrum&suscipit=nulla&nulla=tellus&elit=in&ac=sagittis&nulla=dui&sed=vel&vel=nisl&enim=duis&sit=ac&amet=nibh&nunc=fusce&viverra=lacus&dapibus=purus&nulla=aliquet&suscipit=at&ligula=feugiat&in=non', 1992, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 139.23, 50, 33, 'http://tinyurl.com/vehicula/condimentum/curabitur/in/libero.xml?quam=in&fringilla=purus&rhoncus=eu&mauris=magna&enim=vulputate&leo=luctus&rhoncus=cum&sed=sociis&vestibulum=natoque&sit=penatibus&amet=et&cursus=magnis&id=dis&turpis=parturient&integer=montes&aliquet=nascetur&massa=ridiculus&id=mus&lobortis=vivamus&convallis=vestibulum&tortor=sagittis&risus=sapien&dapibus=cum&augue=sociis&vel=natoque&accumsan=penatibus&tellus=et&nisi=magnis&eu=dis&orci=parturient&mauris=montes&lacinia=nascetur&sapien=ridiculus&quis=mus', 1999, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 161.82, 70, 32, 'https://examiner.com/in/tempor/turpis/nec/euismod/scelerisque/quam.png?posuere=urna&cubilia=pretium&curae=nisl&duis=ut&faucibus=volutpat&accumsan=sapien&odio=arcu&curabitur=sed&convallis=augue&duis=aliquam&consequat=erat&dui=volutpat&nec=in&nisi=congue&volutpat=etiam&eleifend=justo&donec=etiam&ut=pretium&dolor=iaculis&morbi=justo&vel=in&lectus=hac&in=habitasse&quam=platea&fringilla=dictumst&rhoncus=etiam&mauris=faucibus&enim=cursus&leo=urna&rhoncus=ut&sed=tellus&vestibulum=nulla&sit=ut&amet=erat&cursus=id&id=mauris&turpis=vulputate&integer=elementum&aliquet=nullam&massa=varius&id=nulla&lobortis=facilisi&convallis=cras&tortor=non&risus=velit&dapibus=nec&augue=nisi&vel=vulputate&accumsan=nonummy&tellus=maecenas&nisi=tincidunt&eu=lacus&orci=at&mauris=velit&lacinia=vivamus&sapien=vel&quis=nulla&libero=eget&nullam=eros&sit=elementum&amet=pellentesque&turpis=quisque&elementum=porta&ligula=volutpat&vehicula=erat&consequat=quisque&morbi=erat&a=eros&ipsum=viverra&integer=eget&a=congue&nibh=eget&in=semper&quis=rutrum&justo=nulla&maecenas=nunc&rhoncus=purus&aliquam=phasellus&lacus=in&morbi=felis&quis=donec&tortor=semper&id=sapien&nulla=a&ultrices=libero&aliquet=nam&maecenas=dui&leo=proin&odio=leo&condimentum=odio&id=porttitor', 1992, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 72.41, 88, 83, 'http://forbes.com/amet/sapien/dignissim/vestibulum.html?feugiat=neque&et=vestibulum&eros=eget&vestibulum=vulputate&ac=ut&est=ultrices&lacinia=vel&nisi=augue&venenatis=vestibulum&tristique=ante&fusce=ipsum&congue=primis&diam=in&id=faucibus&ornare=orci&imperdiet=luctus&sapien=et&urna=ultrices&pretium=posuere&nisl=cubilia&ut=curae', 2009, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 205.32, 55, 77, 'http://imageshack.us/posuere/cubilia/curae/duis/faucibus.xml?justo=non&etiam=mi&pretium=integer', 1997, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 244.54, 31, 72, 'https://ox.ac.uk/cras/non.jpg?et=duis&ultrices=consequat&posuere=dui&cubilia=nec&curae=nisi&mauris=volutpat&viverra=eleifend&diam=donec&vitae=ut&quam=dolor&suspendisse=morbi&potenti=vel&nullam=lectus&porttitor=in&lacus=quam&at=fringilla&turpis=rhoncus&donec=mauris&posuere=enim&metus=leo&vitae=rhoncus&ipsum=sed&aliquam=vestibulum&non=sit&mauris=amet&morbi=cursus&non=id&lectus=turpis&aliquam=integer&sit=aliquet&amet=massa&diam=id&in=lobortis&magna=convallis&bibendum=tortor&imperdiet=risus&nullam=dapibus&orci=augue&pede=vel&venenatis=accumsan&non=tellus&sodales=nisi&sed=eu', 1994, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 98.56, 16, 33, 'http://mlb.com/sapien/varius/ut.json?fusce=ac&congue=est&diam=lacinia&id=nisi&ornare=venenatis&imperdiet=tristique&sapien=fusce&urna=congue&pretium=diam&nisl=id&ut=ornare&volutpat=imperdiet&sapien=sapien&arcu=urna&sed=pretium&augue=nisl&aliquam=ut&erat=volutpat&volutpat=sapien&in=arcu&congue=sed&etiam=augue&justo=aliquam&etiam=erat&pretium=volutpat&iaculis=in&justo=congue&in=etiam&hac=justo&habitasse=etiam&platea=pretium&dictumst=iaculis&etiam=justo&faucibus=in&cursus=hac&urna=habitasse&ut=platea&tellus=dictumst&nulla=etiam&ut=faucibus&erat=cursus&id=urna&mauris=ut&vulputate=tellus&elementum=nulla&nullam=ut&varius=erat&nulla=id&facilisi=mauris&cras=vulputate&non=elementum&velit=nullam&nec=varius&nisi=nulla&vulputate=facilisi&nonummy=cras&maecenas=non&tincidunt=velit&lacus=nec&at=nisi&velit=vulputate&vivamus=nonummy&vel=maecenas&nulla=tincidunt&eget=lacus&eros=at&elementum=velit&pellentesque=vivamus&quisque=vel&porta=nulla&volutpat=eget&erat=eros&quisque=elementum&erat=pellentesque&eros=quisque&viverra=porta&eget=volutpat', 1997, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 211.39, 100, 22, 'http://epa.gov/curabitur/gravida/nisi/at/nibh/in/hac.jsp?cras=vestibulum&in=ac&purus=est', 1992, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 22.52, 33, 33, 'http://goo.ne.jp/nibh/fusce/lacus/purus.html?ipsum=molestie&primis=lorem&in=quisque&faucibus=ut&orci=erat&luctus=curabitur&et=gravida&ultrices=nisi&posuere=at&cubilia=nibh&curae=in&mauris=hac&viverra=habitasse&diam=platea&vitae=dictumst&quam=aliquam&suspendisse=augue&potenti=quam&nullam=sollicitudin&porttitor=vitae&lacus=consectetuer&at=eget&turpis=rutrum&donec=at&posuere=lorem&metus=integer&vitae=tincidunt&ipsum=ante&aliquam=vel&non=ipsum&mauris=praesent&morbi=blandit&non=lacinia&lectus=erat&aliquam=vestibulum&sit=sed&amet=magna&diam=at&in=nunc&magna=commodo&bibendum=placerat&imperdiet=praesent&nullam=blandit&orci=nam&pede=nulla&venenatis=integer&non=pede&sodales=justo&sed=lacinia&tincidunt=eget&eu=tincidunt&felis=eget&fusce=tempus&posuere=vel&felis=pede&sed=morbi&lacus=porttitor&morbi=lorem&sem=id&mauris=ligula&laoreet=suspendisse&ut=ornare&rhoncus=consequat&aliquet=lectus&pulvinar=in&sed=est&nisl=risus&nunc=auctor&rhoncus=sed&dui=tristique&vel=in&sem=tempus&sed=sit&sagittis=amet&nam=sem&congue=fusce&risus=consequat&semper=nulla&porta=nisl&volutpat=nunc&quam=nisl&pede=duis&lobortis=bibendum&ligula=felis&sit=sed&amet=interdum&eleifend=venenatis&pede=turpis&libero=enim&quis=blandit&orci=mi', 1991, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 114.5, 92, 1, 'http://opensource.org/quis/tortor/id/nulla/ultrices/aliquet.js?congue=morbi&risus=odio&semper=odio&porta=elementum&volutpat=eu&quam=interdum&pede=eu&lobortis=tincidunt&ligula=in&sit=leo&amet=maecenas&eleifend=pulvinar&pede=lobortis&libero=est&quis=phasellus&orci=sit&nullam=amet&molestie=erat&nibh=nulla&in=tempus&lectus=vivamus&pellentesque=in&at=felis&nulla=eu&suspendisse=sapien&potenti=cursus&cras=vestibulum&in=proin&purus=eu&eu=mi&magna=nulla&vulputate=ac&luctus=enim&cum=in&sociis=tempor&natoque=turpis&penatibus=nec&et=euismod&magnis=scelerisque&dis=quam&parturient=turpis', 2008, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 224.44, 70, 45, 'https://reddit.com/sit/amet/lobortis/sapien/sapien/non/mi.jsp?nulla=libero&neque=quis&libero=orci&convallis=nullam&eget=molestie&eleifend=nibh&luctus=in&ultricies=lectus&eu=pellentesque&nibh=at&quisque=nulla&id=suspendisse&justo=potenti&sit=cras&amet=in&sapien=purus&dignissim=eu&vestibulum=magna&vestibulum=vulputate&ante=luctus&ipsum=cum&primis=sociis&in=natoque&faucibus=penatibus&orci=et&luctus=magnis&et=dis&ultrices=parturient&posuere=montes&cubilia=nascetur&curae=ridiculus&nulla=mus&dapibus=vivamus&dolor=vestibulum', 1993, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 218.09, 52, 5, 'https://creativecommons.org/turpis.json?ipsum=convallis&primis=duis&in=consequat&faucibus=dui&orci=nec&luctus=nisi&et=volutpat&ultrices=eleifend&posuere=donec&cubilia=ut&curae=dolor&donec=morbi&pharetra=vel&magna=lectus&vestibulum=in&aliquet=quam&ultrices=fringilla&erat=rhoncus&tortor=mauris&sollicitudin=enim&mi=leo&sit=rhoncus&amet=sed&lobortis=vestibulum&sapien=sit&sapien=amet&non=cursus&mi=id&integer=turpis&ac=integer', 2004, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 71.99, 82, 24, 'http://twitpic.com/volutpat/in/congue.xml?ligula=ornare&vehicula=consequat&consequat=lectus&morbi=in&a=est&ipsum=risus&integer=auctor&a=sed&nibh=tristique&in=in&quis=tempus&justo=sit&maecenas=amet&rhoncus=sem&aliquam=fusce&lacus=consequat&morbi=nulla&quis=nisl&tortor=nunc&id=nisl&nulla=duis&ultrices=bibendum&aliquet=felis', 1972, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 58.8, 50, 27, 'http://wikia.com/nulla.xml?sapien=felis&non=sed&mi=interdum&integer=venenatis&ac=turpis&neque=enim&duis=blandit&bibendum=mi&morbi=in&non=porttitor&quam=pede&nec=justo&dui=eu&luctus=massa&rutrum=donec&nulla=dapibus&tellus=duis&in=at&sagittis=velit&dui=eu&vel=est&nisl=congue&duis=elementum&ac=in&nibh=hac&fusce=habitasse&lacus=platea&purus=dictumst&aliquet=morbi&at=vestibulum&feugiat=velit&non=id&pretium=pretium&quis=iaculis&lectus=diam&suspendisse=erat&potenti=fermentum&in=justo&eleifend=nec&quam=condimentum&a=neque&odio=sapien&in=placerat&hac=ante&habitasse=nulla&platea=justo&dictumst=aliquam', 2011, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 35.3, 50, 6, 'http://buzzfeed.com/pede/venenatis/non/sodales/sed.html?sed=tincidunt&nisl=nulla&nunc=mollis&rhoncus=molestie&dui=lorem&vel=quisque&sem=ut&sed=erat&sagittis=curabitur&nam=gravida&congue=nisi&risus=at&semper=nibh&porta=in&volutpat=hac&quam=habitasse&pede=platea&lobortis=dictumst&ligula=aliquam&sit=augue&amet=quam&eleifend=sollicitudin&pede=vitae&libero=consectetuer&quis=eget&orci=rutrum&nullam=at&molestie=lorem&nibh=integer&in=tincidunt&lectus=ante&pellentesque=vel&at=ipsum&nulla=praesent', 1998, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 200.67, 37, 1, 'http://yolasite.com/accumsan/tellus.jsp?velit=commodo&eu=vulputate&est=justo&congue=in&elementum=blandit&in=ultrices&hac=enim&habitasse=lorem&platea=ipsum&dictumst=dolor&morbi=sit&vestibulum=amet&velit=consectetuer&id=adipiscing&pretium=elit&iaculis=proin&diam=interdum&erat=mauris&fermentum=non&justo=ligula&nec=pellentesque&condimentum=ultrices&neque=phasellus&sapien=id&placerat=sapien&ante=in&nulla=sapien&justo=iaculis&aliquam=congue&quis=vivamus&turpis=metus&eget=arcu&elit=adipiscing&sodales=molestie&scelerisque=hendrerit&mauris=at&sit=vulputate&amet=vitae&eros=nisl&suspendisse=aenean&accumsan=lectus&tortor=pellentesque&quis=eget&turpis=nunc&sed=donec&ante=quis&vivamus=orci&tortor=eget&duis=orci&mattis=vehicula&egestas=condimentum&metus=curabitur&aenean=in&fermentum=libero&donec=ut&ut=massa&mauris=volutpat&eget=convallis&massa=morbi', 2002, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 97.07, 72, 29, 'https://auda.org.au/integer/a/nibh.aspx?scelerisque=et&quam=ultrices&turpis=posuere&adipiscing=cubilia&lorem=curae&vitae=mauris&mattis=viverra&nibh=diam&ligula=vitae&nec=quam&sem=suspendisse&duis=potenti&aliquam=nullam&convallis=porttitor&nunc=lacus&proin=at&at=turpis&turpis=donec&a=posuere&pede=metus&posuere=vitae&nonummy=ipsum&integer=aliquam&non=non&velit=mauris&donec=morbi&diam=non&neque=lectus&vestibulum=aliquam&eget=sit&vulputate=amet&ut=diam&ultrices=in', 2009, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 242.59, 16, 76, 'https://addtoany.com/nec/condimentum.html?in=posuere&magna=nonummy&bibendum=integer&imperdiet=non&nullam=velit&orci=donec&pede=diam&venenatis=neque&non=vestibulum&sodales=eget&sed=vulputate&tincidunt=ut&eu=ultrices&felis=vel&fusce=augue&posuere=vestibulum&felis=ante&sed=ipsum&lacus=primis&morbi=in&sem=faucibus&mauris=orci&laoreet=luctus&ut=et&rhoncus=ultrices&aliquet=posuere&pulvinar=cubilia&sed=curae&nisl=donec&nunc=pharetra&rhoncus=magna&dui=vestibulum&vel=aliquet&sem=ultrices&sed=erat&sagittis=tortor&nam=sollicitudin&congue=mi&risus=sit&semper=amet&porta=lobortis&volutpat=sapien&quam=sapien&pede=non&lobortis=mi&ligula=integer&sit=ac&amet=neque&eleifend=duis&pede=bibendum&libero=morbi&quis=non&orci=quam&nullam=nec&molestie=dui&nibh=luctus&in=rutrum&lectus=nulla&pellentesque=tellus&at=in&nulla=sagittis&suspendisse=dui&potenti=vel&cras=nisl&in=duis&purus=ac&eu=nibh&magna=fusce&vulputate=lacus&luctus=purus&cum=aliquet&sociis=at&natoque=feugiat&penatibus=non&et=pretium&magnis=quis&dis=lectus', 2001, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 143.04, 81, 92, 'http://eepurl.com/bibendum/imperdiet.json?sapien=vestibulum&arcu=eget&sed=vulputate&augue=ut&aliquam=ultrices&erat=vel&volutpat=augue&in=vestibulum&congue=ante&etiam=ipsum&justo=primis&etiam=in&pretium=faucibus&iaculis=orci&justo=luctus&in=et&hac=ultrices&habitasse=posuere&platea=cubilia&dictumst=curae&etiam=donec&faucibus=pharetra&cursus=magna&urna=vestibulum&ut=aliquet&tellus=ultrices&nulla=erat&ut=tortor&erat=sollicitudin&id=mi&mauris=sit&vulputate=amet&elementum=lobortis&nullam=sapien&varius=sapien&nulla=non&facilisi=mi&cras=integer&non=ac&velit=neque&nec=duis&nisi=bibendum&vulputate=morbi&nonummy=non&maecenas=quam&tincidunt=nec&lacus=dui&at=luctus&velit=rutrum&vivamus=nulla&vel=tellus&nulla=in&eget=sagittis&eros=dui&elementum=vel&pellentesque=nisl&quisque=duis&porta=ac&volutpat=nibh&erat=fusce&quisque=lacus&erat=purus&eros=aliquet&viverra=at&eget=feugiat&congue=non&eget=pretium&semper=quis&rutrum=lectus&nulla=suspendisse&nunc=potenti&purus=in&phasellus=eleifend&in=quam&felis=a&donec=odio&semper=in&sapien=hac&a=habitasse&libero=platea&nam=dictumst', 1987, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 129.82, 71, 4, 'http://archive.org/aliquet/ultrices/erat/tortor/sollicitudin/mi/sit.js?posuere=habitasse&cubilia=platea&curae=dictumst&nulla=morbi&dapibus=vestibulum&dolor=velit&vel=id&est=pretium&donec=iaculis&odio=diam&justo=erat&sollicitudin=fermentum&ut=justo&suscipit=nec&a=condimentum&feugiat=neque&et=sapien&eros=placerat&vestibulum=ante&ac=nulla&est=justo&lacinia=aliquam&nisi=quis&venenatis=turpis&tristique=eget&fusce=elit&congue=sodales&diam=scelerisque&id=mauris&ornare=sit&imperdiet=amet&sapien=eros&urna=suspendisse&pretium=accumsan&nisl=tortor&ut=quis&volutpat=turpis&sapien=sed&arcu=ante&sed=vivamus&augue=tortor&aliquam=duis&erat=mattis&volutpat=egestas&in=metus&congue=aenean&etiam=fermentum&justo=donec&etiam=ut', 1997, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 23.33, 40, 68, 'http://google.com/et/ultrices/posuere/cubilia/curae.aspx?platea=molestie&dictumst=sed&maecenas=justo&ut=pellentesque&massa=viverra&quis=pede&augue=ac&luctus=diam&tincidunt=cras&nulla=pellentesque&mollis=volutpat&molestie=dui&lorem=maecenas&quisque=tristique&ut=est&erat=et&curabitur=tempus&gravida=semper&nisi=est&at=quam&nibh=pharetra&in=magna&hac=ac&habitasse=consequat&platea=metus&dictumst=sapien&aliquam=ut&augue=nunc&quam=vestibulum&sollicitudin=ante&vitae=ipsum&consectetuer=primis&eget=in&rutrum=faucibus&at=orci&lorem=luctus&integer=et&tincidunt=ultrices&ante=posuere&vel=cubilia&ipsum=curae&praesent=mauris&blandit=viverra&lacinia=diam&erat=vitae&vestibulum=quam&sed=suspendisse&magna=potenti&at=nullam&nunc=porttitor&commodo=lacus&placerat=at&praesent=turpis&blandit=donec&nam=posuere&nulla=metus&integer=vitae&pede=ipsum&justo=aliquam&lacinia=non&eget=mauris&tincidunt=morbi&eget=non&tempus=lectus&vel=aliquam&pede=sit&morbi=amet&porttitor=diam&lorem=in&id=magna&ligula=bibendum&suspendisse=imperdiet', 1998, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 6.87, 60, 4, 'https://scribd.com/pede/libero.xml?consequat=nulla&lectus=ac&in=enim&est=in&risus=tempor&auctor=turpis&sed=nec&tristique=euismod&in=scelerisque&tempus=quam&sit=turpis&amet=adipiscing&sem=lorem&fusce=vitae&consequat=mattis&nulla=nibh&nisl=ligula&nunc=nec&nisl=sem&duis=duis&bibendum=aliquam&felis=convallis&sed=nunc&interdum=proin&venenatis=at&turpis=turpis&enim=a&blandit=pede&mi=posuere&in=nonummy&porttitor=integer&pede=non&justo=velit&eu=donec&massa=diam&donec=neque&dapibus=vestibulum&duis=eget&at=vulputate&velit=ut&eu=ultrices&est=vel&congue=augue&elementum=vestibulum&in=ante&hac=ipsum&habitasse=primis&platea=in&dictumst=faucibus&morbi=orci&vestibulum=luctus&velit=et&id=ultrices&pretium=posuere&iaculis=cubilia&diam=curae&erat=donec&fermentum=pharetra&justo=magna&nec=vestibulum&condimentum=aliquet&neque=ultrices&sapien=erat&placerat=tortor&ante=sollicitudin&nulla=mi&justo=sit&aliquam=amet&quis=lobortis&turpis=sapien&eget=sapien&elit=non&sodales=mi&scelerisque=integer&mauris=ac&sit=neque&amet=duis&eros=bibendum&suspendisse=morbi&accumsan=non&tortor=quam&quis=nec&turpis=dui&sed=luctus&ante=rutrum&vivamus=nulla&tortor=tellus&duis=in&mattis=sagittis&egestas=dui&metus=vel&aenean=nisl&fermentum=duis&donec=ac&ut=nibh&mauris=fusce', 2006, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 72.73, 49, 63, 'https://zimbio.com/accumsan/tellus/nisi.xml?mauris=turpis&vulputate=nec&elementum=euismod&nullam=scelerisque&varius=quam&nulla=turpis&facilisi=adipiscing&cras=lorem&non=vitae&velit=mattis&nec=nibh&nisi=ligula&vulputate=nec&nonummy=sem&maecenas=duis', 2005, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 156.13, 68, 65, 'https://ovh.net/sed/lacus/morbi/sem.json?augue=massa&vestibulum=donec&rutrum=dapibus&rutrum=duis&neque=at&aenean=velit&auctor=eu&gravida=est&sem=congue&praesent=elementum&id=in&massa=hac&id=habitasse&nisl=platea&venenatis=dictumst&lacinia=morbi&aenean=vestibulum&sit=velit&amet=id&justo=pretium&morbi=iaculis&ut=diam&odio=erat&cras=fermentum&mi=justo&pede=nec&malesuada=condimentum', 2002, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 85.53, 3, 16, 'https://hostgator.com/interdum/mauris/ullamcorper/purus/sit/amet.png?morbi=pellentesque&sem=volutpat&mauris=dui&laoreet=maecenas&ut=tristique&rhoncus=est&aliquet=et&pulvinar=tempus&sed=semper&nisl=est&nunc=quam&rhoncus=pharetra&dui=magna&vel=ac&sem=consequat&sed=metus&sagittis=sapien&nam=ut&congue=nunc&risus=vestibulum&semper=ante&porta=ipsum&volutpat=primis&quam=in&pede=faucibus&lobortis=orci&ligula=luctus&sit=et&amet=ultrices&eleifend=posuere&pede=cubilia&libero=curae&quis=mauris&orci=viverra&nullam=diam&molestie=vitae&nibh=quam&in=suspendisse&lectus=potenti&pellentesque=nullam&at=porttitor&nulla=lacus&suspendisse=at&potenti=turpis&cras=donec&in=posuere&purus=metus&eu=vitae&magna=ipsum&vulputate=aliquam&luctus=non&cum=mauris&sociis=morbi&natoque=non&penatibus=lectus&et=aliquam&magnis=sit&dis=amet&parturient=diam&montes=in&nascetur=magna&ridiculus=bibendum&mus=imperdiet&vivamus=nullam', 1997, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 75.7, 66, 88, 'http://themeforest.net/sit/amet/turpis/elementum/ligula.json?ac=tristique&consequat=est&metus=et&sapien=tempus&ut=semper&nunc=est&vestibulum=quam&ante=pharetra&ipsum=magna&primis=ac&in=consequat&faucibus=metus&orci=sapien&luctus=ut&et=nunc&ultrices=vestibulum&posuere=ante&cubilia=ipsum&curae=primis&mauris=in&viverra=faucibus&diam=orci&vitae=luctus&quam=et&suspendisse=ultrices&potenti=posuere&nullam=cubilia&porttitor=curae&lacus=mauris&at=viverra&turpis=diam&donec=vitae&posuere=quam&metus=suspendisse&vitae=potenti&ipsum=nullam&aliquam=porttitor&non=lacus&mauris=at&morbi=turpis&non=donec&lectus=posuere&aliquam=metus&sit=vitae&amet=ipsum&diam=aliquam&in=non&magna=mauris&bibendum=morbi&imperdiet=non&nullam=lectus&orci=aliquam&pede=sit&venenatis=amet&non=diam&sodales=in&sed=magna&tincidunt=bibendum&eu=imperdiet&felis=nullam&fusce=orci&posuere=pede&felis=venenatis&sed=non&lacus=sodales&morbi=sed&sem=tincidunt&mauris=eu&laoreet=felis&ut=fusce&rhoncus=posuere&aliquet=felis&pulvinar=sed&sed=lacus&nisl=morbi&nunc=sem&rhoncus=mauris&dui=laoreet&vel=ut&sem=rhoncus&sed=aliquet&sagittis=pulvinar&nam=sed&congue=nisl&risus=nunc&semper=rhoncus', 2006, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 28.77, 71, 22, 'https://discuz.net/elementum/eu/interdum/eu/tincidunt/in.aspx?vel=vestibulum&sem=proin&sed=eu&sagittis=mi&nam=nulla&congue=ac&risus=enim&semper=in&porta=tempor&volutpat=turpis&quam=nec&pede=euismod&lobortis=scelerisque&ligula=quam&sit=turpis&amet=adipiscing&eleifend=lorem&pede=vitae&libero=mattis&quis=nibh&orci=ligula&nullam=nec&molestie=sem&nibh=duis&in=aliquam&lectus=convallis&pellentesque=nunc&at=proin&nulla=at&suspendisse=turpis&potenti=a&cras=pede&in=posuere&purus=nonummy&eu=integer&magna=non&vulputate=velit&luctus=donec&cum=diam&sociis=neque&natoque=vestibulum&penatibus=eget&et=vulputate&magnis=ut&dis=ultrices&parturient=vel&montes=augue&nascetur=vestibulum&ridiculus=ante&mus=ipsum&vivamus=primis&vestibulum=in&sagittis=faucibus&sapien=orci&cum=luctus&sociis=et&natoque=ultrices&penatibus=posuere&et=cubilia&magnis=curae&dis=donec&parturient=pharetra&montes=magna&nascetur=vestibulum&ridiculus=aliquet&mus=ultrices&etiam=erat&vel=tortor&augue=sollicitudin&vestibulum=mi&rutrum=sit&rutrum=amet&neque=lobortis', 2004, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 235.2, 50, 41, 'https://sakura.ne.jp/semper.png?vivamus=non&vel=sodales&nulla=sed&eget=tincidunt&eros=eu&elementum=felis&pellentesque=fusce&quisque=posuere&porta=felis&volutpat=sed&erat=lacus&quisque=morbi&erat=sem&eros=mauris&viverra=laoreet&eget=ut&congue=rhoncus&eget=aliquet&semper=pulvinar&rutrum=sed&nulla=nisl&nunc=nunc&purus=rhoncus&phasellus=dui&in=vel&felis=sem&donec=sed&semper=sagittis&sapien=nam&a=congue&libero=risus&nam=semper&dui=porta&proin=volutpat&leo=quam&odio=pede&porttitor=lobortis&id=ligula&consequat=sit&in=amet&consequat=eleifend&ut=pede', 2011, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 124.71, 80, 98, 'http://163.com/ac/lobortis/vel/dapibus/at.aspx?fermentum=iaculis&donec=congue&ut=vivamus&mauris=metus&eget=arcu&massa=adipiscing&tempor=molestie&convallis=hendrerit&nulla=at&neque=vulputate&libero=vitae&convallis=nisl&eget=aenean&eleifend=lectus&luctus=pellentesque&ultricies=eget&eu=nunc&nibh=donec&quisque=quis&id=orci&justo=eget&sit=orci&amet=vehicula&sapien=condimentum&dignissim=curabitur&vestibulum=in&vestibulum=libero&ante=ut&ipsum=massa&primis=volutpat&in=convallis&faucibus=morbi&orci=odio&luctus=odio&et=elementum&ultrices=eu&posuere=interdum&cubilia=eu&curae=tincidunt&nulla=in&dapibus=leo&dolor=maecenas&vel=pulvinar&est=lobortis&donec=est&odio=phasellus&justo=sit&sollicitudin=amet&ut=erat&suscipit=nulla&a=tempus&feugiat=vivamus&et=in&eros=felis&vestibulum=eu&ac=sapien&est=cursus&lacinia=vestibulum&nisi=proin&venenatis=eu&tristique=mi&fusce=nulla&congue=ac&diam=enim&id=in&ornare=tempor&imperdiet=turpis&sapien=nec&urna=euismod&pretium=scelerisque&nisl=quam&ut=turpis', 1984, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 178.11, 99, 96, 'http://360.cn/ipsum/ac/tellus/semper/interdum/mauris/ullamcorper.jpg?nascetur=lectus&ridiculus=suspendisse&mus=potenti&vivamus=in&vestibulum=eleifend&sagittis=quam&sapien=a&cum=odio&sociis=in&natoque=hac&penatibus=habitasse&et=platea&magnis=dictumst&dis=maecenas&parturient=ut&montes=massa&nascetur=quis&ridiculus=augue&mus=luctus&etiam=tincidunt&vel=nulla&augue=mollis&vestibulum=molestie&rutrum=lorem&rutrum=quisque&neque=ut&aenean=erat&auctor=curabitur&gravida=gravida&sem=nisi&praesent=at&id=nibh&massa=in&id=hac&nisl=habitasse&venenatis=platea&lacinia=dictumst&aenean=aliquam&sit=augue&amet=quam&justo=sollicitudin&morbi=vitae&ut=consectetuer&odio=eget&cras=rutrum&mi=at&pede=lorem&malesuada=integer&in=tincidunt&imperdiet=ante&et=vel&commodo=ipsum&vulputate=praesent&justo=blandit&in=lacinia&blandit=erat', 1992, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 230.0, 32, 99, 'https://alibaba.com/erat.png?primis=risus&in=semper&faucibus=porta&orci=volutpat&luctus=quam&et=pede&ultrices=lobortis&posuere=ligula&cubilia=sit&curae=amet&nulla=eleifend&dapibus=pede&dolor=libero&vel=quis&est=orci&donec=nullam&odio=molestie&justo=nibh&sollicitudin=in&ut=lectus&suscipit=pellentesque&a=at&feugiat=nulla&et=suspendisse&eros=potenti&vestibulum=cras&ac=in&est=purus&lacinia=eu&nisi=magna', 2012, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 139.79, 52, 17, 'http://dedecms.com/nisi/nam/ultrices/libero/non/mattis.xml?mauris=non&laoreet=velit&ut=donec&rhoncus=diam&aliquet=neque&pulvinar=vestibulum&sed=eget&nisl=vulputate&nunc=ut&rhoncus=ultrices&dui=vel&vel=augue&sem=vestibulum&sed=ante&sagittis=ipsum&nam=primis&congue=in&risus=faucibus&semper=orci&porta=luctus&volutpat=et&quam=ultrices&pede=posuere&lobortis=cubilia&ligula=curae&sit=donec&amet=pharetra&eleifend=magna&pede=vestibulum&libero=aliquet&quis=ultrices&orci=erat&nullam=tortor&molestie=sollicitudin&nibh=mi&in=sit&lectus=amet', 2006, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 171.58, 24, 65, 'https://gravatar.com/penatibus/et.jsp?in=phasellus&hac=id&habitasse=sapien&platea=in&dictumst=sapien&morbi=iaculis&vestibulum=congue&velit=vivamus&id=metus&pretium=arcu&iaculis=adipiscing&diam=molestie&erat=hendrerit&fermentum=at&justo=vulputate&nec=vitae&condimentum=nisl&neque=aenean&sapien=lectus&placerat=pellentesque&ante=eget&nulla=nunc&justo=donec&aliquam=quis&quis=orci&turpis=eget&eget=orci&elit=vehicula&sodales=condimentum&scelerisque=curabitur&mauris=in&sit=libero&amet=ut&eros=massa&suspendisse=volutpat', 1974, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 168.58, 46, 18, 'https://psu.edu/vestibulum.js?ultricies=vestibulum&eu=velit&nibh=id&quisque=pretium&id=iaculis&justo=diam&sit=erat&amet=fermentum&sapien=justo&dignissim=nec&vestibulum=condimentum&vestibulum=neque&ante=sapien&ipsum=placerat&primis=ante&in=nulla&faucibus=justo&orci=aliquam&luctus=quis&et=turpis&ultrices=eget&posuere=elit&cubilia=sodales&curae=scelerisque&nulla=mauris&dapibus=sit&dolor=amet&vel=eros&est=suspendisse&donec=accumsan&odio=tortor&justo=quis&sollicitudin=turpis&ut=sed&suscipit=ante&a=vivamus&feugiat=tortor&et=duis&eros=mattis&vestibulum=egestas&ac=metus&est=aenean&lacinia=fermentum&nisi=donec&venenatis=ut&tristique=mauris&fusce=eget&congue=massa&diam=tempor&id=convallis&ornare=nulla&imperdiet=neque&sapien=libero&urna=convallis&pretium=eget&nisl=eleifend&ut=luctus&volutpat=ultricies&sapien=eu&arcu=nibh&sed=quisque&augue=id&aliquam=justo&erat=sit&volutpat=amet&in=sapien&congue=dignissim&etiam=vestibulum&justo=vestibulum&etiam=ante&pretium=ipsum&iaculis=primis&justo=in&in=faucibus&hac=orci&habitasse=luctus&platea=et&dictumst=ultrices&etiam=posuere&faucibus=cubilia&cursus=curae&urna=nulla&ut=dapibus&tellus=dolor&nulla=vel&ut=est&erat=donec&id=odio&mauris=justo&vulputate=sollicitudin&elementum=ut&nullam=suscipit&varius=a&nulla=feugiat&facilisi=et&cras=eros&non=vestibulum&velit=ac&nec=est&nisi=lacinia', 1994, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 3.22, 11, 75, 'https://g.co/congue/etiam/justo.jpg?sapien=at&sapien=velit&non=eu&mi=est&integer=congue&ac=elementum&neque=in&duis=hac&bibendum=habitasse&morbi=platea&non=dictumst&quam=morbi&nec=vestibulum&dui=velit&luctus=id&rutrum=pretium&nulla=iaculis&tellus=diam&in=erat&sagittis=fermentum&dui=justo&vel=nec&nisl=condimentum&duis=neque&ac=sapien&nibh=placerat&fusce=ante&lacus=nulla&purus=justo&aliquet=aliquam&at=quis&feugiat=turpis&non=eget&pretium=elit&quis=sodales&lectus=scelerisque&suspendisse=mauris&potenti=sit&in=amet&eleifend=eros&quam=suspendisse&a=accumsan&odio=tortor&in=quis&hac=turpis&habitasse=sed&platea=ante&dictumst=vivamus&maecenas=tortor&ut=duis&massa=mattis&quis=egestas&augue=metus&luctus=aenean&tincidunt=fermentum&nulla=donec&mollis=ut&molestie=mauris&lorem=eget&quisque=massa&ut=tempor&erat=convallis&curabitur=nulla&gravida=neque&nisi=libero&at=convallis&nibh=eget&in=eleifend&hac=luctus&habitasse=ultricies&platea=eu&dictumst=nibh&aliquam=quisque&augue=id&quam=justo&sollicitudin=sit&vitae=amet&consectetuer=sapien&eget=dignissim&rutrum=vestibulum&at=vestibulum&lorem=ante&integer=ipsum&tincidunt=primis&ante=in&vel=faucibus&ipsum=orci&praesent=luctus&blandit=et&lacinia=ultrices&erat=posuere&vestibulum=cubilia&sed=curae&magna=nulla&at=dapibus&nunc=dolor', 1998, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 88.76, 42, 91, 'http://opera.com/vel/augue/vestibulum/rutrum.png?lacus=ultricies&morbi=eu&quis=nibh&tortor=quisque&id=id&nulla=justo&ultrices=sit&aliquet=amet&maecenas=sapien', 1988, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 56.37, 13, 72, 'http://pinterest.com/sed/sagittis/nam/congue.json?curae=habitasse&donec=platea&pharetra=dictumst&magna=maecenas&vestibulum=ut&aliquet=massa&ultrices=quis&erat=augue&tortor=luctus&sollicitudin=tincidunt&mi=nulla&sit=mollis&amet=molestie&lobortis=lorem&sapien=quisque&sapien=ut&non=erat&mi=curabitur&integer=gravida&ac=nisi&neque=at&duis=nibh&bibendum=in&morbi=hac&non=habitasse&quam=platea&nec=dictumst&dui=aliquam&luctus=augue', 1994, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 234.15, 33, 19, 'http://ezinearticles.com/ut.aspx?tempus=phasellus&sit=id&amet=sapien&sem=in&fusce=sapien&consequat=iaculis&nulla=congue&nisl=vivamus&nunc=metus&nisl=arcu&duis=adipiscing&bibendum=molestie&felis=hendrerit&sed=at&interdum=vulputate&venenatis=vitae&turpis=nisl&enim=aenean&blandit=lectus&mi=pellentesque&in=eget&porttitor=nunc&pede=donec&justo=quis&eu=orci&massa=eget&donec=orci&dapibus=vehicula&duis=condimentum&at=curabitur&velit=in&eu=libero&est=ut&congue=massa&elementum=volutpat&in=convallis&hac=morbi&habitasse=odio&platea=odio&dictumst=elementum&morbi=eu&vestibulum=interdum&velit=eu&id=tincidunt&pretium=in&iaculis=leo&diam=maecenas&erat=pulvinar&fermentum=lobortis&justo=est&nec=phasellus&condimentum=sit&neque=amet&sapien=erat&placerat=nulla&ante=tempus&nulla=vivamus&justo=in&aliquam=felis&quis=eu&turpis=sapien&eget=cursus&elit=vestibulum&sodales=proin&scelerisque=eu&mauris=mi&sit=nulla&amet=ac&eros=enim&suspendisse=in&accumsan=tempor&tortor=turpis&quis=nec&turpis=euismod', 1958, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 208.35, 21, 10, 'http://mac.com/leo/odio/porttitor/id/consequat/in/consequat.xml?non=sed&lectus=magna&aliquam=at&sit=nunc&amet=commodo&diam=placerat&in=praesent&magna=blandit&bibendum=nam&imperdiet=nulla&nullam=integer&orci=pede&pede=justo&venenatis=lacinia&non=eget&sodales=tincidunt&sed=eget&tincidunt=tempus&eu=vel&felis=pede&fusce=morbi&posuere=porttitor&felis=lorem&sed=id&lacus=ligula&morbi=suspendisse&sem=ornare&mauris=consequat&laoreet=lectus&ut=in&rhoncus=est&aliquet=risus&pulvinar=auctor&sed=sed&nisl=tristique&nunc=in&rhoncus=tempus&dui=sit&vel=amet&sem=sem&sed=fusce&sagittis=consequat&nam=nulla&congue=nisl&risus=nunc&semper=nisl&porta=duis&volutpat=bibendum&quam=felis&pede=sed&lobortis=interdum&ligula=venenatis&sit=turpis&amet=enim&eleifend=blandit&pede=mi&libero=in&quis=porttitor&orci=pede&nullam=justo&molestie=eu&nibh=massa&in=donec&lectus=dapibus&pellentesque=duis&at=at&nulla=velit&suspendisse=eu&potenti=est&cras=congue&in=elementum&purus=in&eu=hac&magna=habitasse&vulputate=platea&luctus=dictumst&cum=morbi&sociis=vestibulum&natoque=velit&penatibus=id&et=pretium&magnis=iaculis&dis=diam&parturient=erat&montes=fermentum&nascetur=justo&ridiculus=nec&mus=condimentum&vivamus=neque&vestibulum=sapien&sagittis=placerat&sapien=ante&cum=nulla', 1995, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 161.14, 41, 8, 'http://netlog.com/mi/integer.json?elementum=lectus&nullam=in&varius=quam&nulla=fringilla&facilisi=rhoncus&cras=mauris&non=enim&velit=leo&nec=rhoncus&nisi=sed&vulputate=vestibulum&nonummy=sit&maecenas=amet&tincidunt=cursus&lacus=id&at=turpis&velit=integer&vivamus=aliquet&vel=massa&nulla=id&eget=lobortis&eros=convallis&elementum=tortor&pellentesque=risus&quisque=dapibus&porta=augue&volutpat=vel&erat=accumsan&quisque=tellus&erat=nisi&eros=eu&viverra=orci&eget=mauris&congue=lacinia&eget=sapien&semper=quis&rutrum=libero&nulla=nullam&nunc=sit&purus=amet&phasellus=turpis&in=elementum&felis=ligula&donec=vehicula&semper=consequat&sapien=morbi&a=a&libero=ipsum&nam=integer&dui=a&proin=nibh&leo=in&odio=quis&porttitor=justo&id=maecenas&consequat=rhoncus&in=aliquam&consequat=lacus&ut=morbi&nulla=quis&sed=tortor&accumsan=id&felis=nulla&ut=ultrices&at=aliquet&dolor=maecenas&quis=leo&odio=odio&consequat=condimentum&varius=id&integer=luctus&ac=nec&leo=molestie&pellentesque=sed&ultrices=justo&mattis=pellentesque&odio=viverra&donec=pede&vitae=ac&nisi=diam&nam=cras&ultrices=pellentesque&libero=volutpat&non=dui', 2006, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 41.52, 42, 73, 'https://npr.org/amet/turpis/elementum/ligula.html?hendrerit=hac&at=habitasse&vulputate=platea&vitae=dictumst&nisl=aliquam&aenean=augue&lectus=quam&pellentesque=sollicitudin&eget=vitae&nunc=consectetuer&donec=eget&quis=rutrum&orci=at&eget=lorem&orci=integer&vehicula=tincidunt&condimentum=ante&curabitur=vel&in=ipsum&libero=praesent&ut=blandit&massa=lacinia&volutpat=erat&convallis=vestibulum&morbi=sed&odio=magna&odio=at&elementum=nunc&eu=commodo&interdum=placerat&eu=praesent&tincidunt=blandit&in=nam&leo=nulla&maecenas=integer&pulvinar=pede&lobortis=justo&est=lacinia&phasellus=eget&sit=tincidunt&amet=eget&erat=tempus&nulla=vel&tempus=pede&vivamus=morbi&in=porttitor&felis=lorem&eu=id&sapien=ligula&cursus=suspendisse&vestibulum=ornare&proin=consequat&eu=lectus&mi=in&nulla=est&ac=risus&enim=auctor&in=sed', 2002, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 130.02, 11, 1, 'https://cnn.com/convallis/nunc.jsp?rutrum=pharetra&nulla=magna&nunc=ac&purus=consequat&phasellus=metus&in=sapien&felis=ut&donec=nunc&semper=vestibulum&sapien=ante&a=ipsum&libero=primis&nam=in&dui=faucibus&proin=orci&leo=luctus&odio=et&porttitor=ultrices&id=posuere&consequat=cubilia&in=curae&consequat=mauris&ut=viverra&nulla=diam&sed=vitae&accumsan=quam&felis=suspendisse&ut=potenti&at=nullam&dolor=porttitor&quis=lacus&odio=at&consequat=turpis&varius=donec&integer=posuere&ac=metus&leo=vitae&pellentesque=ipsum&ultrices=aliquam&mattis=non&odio=mauris&donec=morbi&vitae=non&nisi=lectus&nam=aliquam&ultrices=sit&libero=amet&non=diam&mattis=in&pulvinar=magna&nulla=bibendum&pede=imperdiet&ullamcorper=nullam&augue=orci&a=pede&suscipit=venenatis&nulla=non&elit=sodales&ac=sed&nulla=tincidunt&sed=eu&vel=felis&enim=fusce&sit=posuere&amet=felis&nunc=sed&viverra=lacus&dapibus=morbi&nulla=sem&suscipit=mauris&ligula=laoreet&in=ut&lacus=rhoncus', 2006, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 172.18, 94, 84, 'https://wsj.com/in/leo/maecenas.html?dis=quam&parturient=nec&montes=dui&nascetur=luctus&ridiculus=rutrum&mus=nulla&etiam=tellus&vel=in&augue=sagittis&vestibulum=dui&rutrum=vel&rutrum=nisl&neque=duis&aenean=ac&auctor=nibh&gravida=fusce&sem=lacus&praesent=purus&id=aliquet&massa=at&id=feugiat&nisl=non&venenatis=pretium&lacinia=quis&aenean=lectus&sit=suspendisse&amet=potenti&justo=in&morbi=eleifend&ut=quam&odio=a&cras=odio&mi=in&pede=hac&malesuada=habitasse&in=platea&imperdiet=dictumst&et=maecenas&commodo=ut&vulputate=massa&justo=quis&in=augue&blandit=luctus&ultrices=tincidunt&enim=nulla&lorem=mollis&ipsum=molestie&dolor=lorem&sit=quisque&amet=ut&consectetuer=erat&adipiscing=curabitur&elit=gravida&proin=nisi&interdum=at&mauris=nibh&non=in&ligula=hac&pellentesque=habitasse&ultrices=platea&phasellus=dictumst&id=aliquam&sapien=augue&in=quam&sapien=sollicitudin&iaculis=vitae&congue=consectetuer&vivamus=eget&metus=rutrum&arcu=at&adipiscing=lorem&molestie=integer&hendrerit=tincidunt&at=ante&vulputate=vel&vitae=ipsum&nisl=praesent&aenean=blandit&lectus=lacinia&pellentesque=erat&eget=vestibulum&nunc=sed&donec=magna&quis=at&orci=nunc&eget=commodo&orci=placerat&vehicula=praesent&condimentum=blandit&curabitur=nam&in=nulla&libero=integer&ut=pede', 2001, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 92.83, 50, 100, 'https://sphinn.com/posuere/nonummy/integer/non.js?montes=sit&nascetur=amet&ridiculus=cursus&mus=id&etiam=turpis&vel=integer&augue=aliquet&vestibulum=massa&rutrum=id&rutrum=lobortis&neque=convallis&aenean=tortor&auctor=risus&gravida=dapibus&sem=augue&praesent=vel&id=accumsan&massa=tellus&id=nisi&nisl=eu&venenatis=orci&lacinia=mauris&aenean=lacinia&sit=sapien&amet=quis&justo=libero&morbi=nullam&ut=sit&odio=amet&cras=turpis&mi=elementum&pede=ligula', 1992, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 15.46, 23, 82, 'http://alexa.com/risus/praesent.xml?nullam=molestie&porttitor=lorem&lacus=quisque&at=ut&turpis=erat&donec=curabitur&posuere=gravida&metus=nisi&vitae=at&ipsum=nibh&aliquam=in&non=hac&mauris=habitasse&morbi=platea&non=dictumst&lectus=aliquam&aliquam=augue&sit=quam&amet=sollicitudin&diam=vitae&in=consectetuer&magna=eget&bibendum=rutrum&imperdiet=at&nullam=lorem&orci=integer&pede=tincidunt&venenatis=ante&non=vel&sodales=ipsum&sed=praesent&tincidunt=blandit&eu=lacinia&felis=erat&fusce=vestibulum&posuere=sed&felis=magna&sed=at&lacus=nunc&morbi=commodo&sem=placerat&mauris=praesent&laoreet=blandit&ut=nam&rhoncus=nulla&aliquet=integer&pulvinar=pede&sed=justo&nisl=lacinia&nunc=eget&rhoncus=tincidunt&dui=eget&vel=tempus&sem=vel&sed=pede&sagittis=morbi&nam=porttitor&congue=lorem&risus=id&semper=ligula&porta=suspendisse&volutpat=ornare&quam=consequat&pede=lectus&lobortis=in', 2003, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 226.65, 29, 70, 'https://issuu.com/maecenas/leo/odio/condimentum.aspx?vel=ut&est=massa&donec=volutpat&odio=convallis&justo=morbi&sollicitudin=odio&ut=odio&suscipit=elementum&a=eu&feugiat=interdum&et=eu&eros=tincidunt&vestibulum=in&ac=leo&est=maecenas&lacinia=pulvinar&nisi=lobortis&venenatis=est&tristique=phasellus&fusce=sit&congue=amet&diam=erat&id=nulla&ornare=tempus&imperdiet=vivamus', 1995, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 190.36, 43, 98, 'http://vinaora.com/donec/posuere/metus.jpg?enim=in&blandit=lectus&mi=pellentesque&in=at&porttitor=nulla&pede=suspendisse&justo=potenti&eu=cras&massa=in&donec=purus&dapibus=eu&duis=magna&at=vulputate&velit=luctus&eu=cum&est=sociis&congue=natoque&elementum=penatibus&in=et&hac=magnis&habitasse=dis&platea=parturient&dictumst=montes&morbi=nascetur&vestibulum=ridiculus&velit=mus&id=vivamus&pretium=vestibulum&iaculis=sagittis&diam=sapien&erat=cum&fermentum=sociis&justo=natoque&nec=penatibus&condimentum=et&neque=magnis&sapien=dis&placerat=parturient&ante=montes&nulla=nascetur&justo=ridiculus&aliquam=mus&quis=etiam&turpis=vel&eget=augue&elit=vestibulum&sodales=rutrum&scelerisque=rutrum&mauris=neque&sit=aenean&amet=auctor&eros=gravida', 2003, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 102.59, 10, 8, 'https://microsoft.com/congue.jpg?elit=dui&sodales=proin&scelerisque=leo&mauris=odio&sit=porttitor', 1996, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 220.43, 10, 67, 'https://fastcompany.com/quam.json?pretium=nibh&quis=in&lectus=quis&suspendisse=justo&potenti=maecenas&in=rhoncus&eleifend=aliquam&quam=lacus&a=morbi&odio=quis&in=tortor&hac=id&habitasse=nulla&platea=ultrices&dictumst=aliquet&maecenas=maecenas&ut=leo&massa=odio&quis=condimentum&augue=id&luctus=luctus&tincidunt=nec&nulla=molestie&mollis=sed&molestie=justo&lorem=pellentesque&quisque=viverra&ut=pede&erat=ac&curabitur=diam&gravida=cras&nisi=pellentesque&at=volutpat&nibh=dui&in=maecenas&hac=tristique&habitasse=est&platea=et&dictumst=tempus&aliquam=semper&augue=est&quam=quam&sollicitudin=pharetra&vitae=magna&consectetuer=ac&eget=consequat&rutrum=metus&at=sapien&lorem=ut&integer=nunc&tincidunt=vestibulum&ante=ante&vel=ipsum&ipsum=primis&praesent=in&blandit=faucibus&lacinia=orci&erat=luctus&vestibulum=et&sed=ultrices&magna=posuere&at=cubilia&nunc=curae&commodo=mauris&placerat=viverra&praesent=diam&blandit=vitae&nam=quam&nulla=suspendisse&integer=potenti&pede=nullam', 1999, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 241.53, 53, 29, 'http://uol.com.br/vel/accumsan/tellus/nisi/eu.json?mauris=suspendisse&sit=potenti&amet=cras&eros=in&suspendisse=purus&accumsan=eu&tortor=magna&quis=vulputate&turpis=luctus&sed=cum&ante=sociis&vivamus=natoque&tortor=penatibus&duis=et&mattis=magnis&egestas=dis&metus=parturient&aenean=montes&fermentum=nascetur&donec=ridiculus&ut=mus&mauris=vivamus&eget=vestibulum&massa=sagittis&tempor=sapien&convallis=cum&nulla=sociis&neque=natoque&libero=penatibus&convallis=et&eget=magnis&eleifend=dis&luctus=parturient&ultricies=montes&eu=nascetur&nibh=ridiculus&quisque=mus&id=etiam&justo=vel&sit=augue&amet=vestibulum&sapien=rutrum&dignissim=rutrum&vestibulum=neque&vestibulum=aenean&ante=auctor&ipsum=gravida&primis=sem&in=praesent&faucibus=id&orci=massa&luctus=id&et=nisl&ultrices=venenatis&posuere=lacinia&cubilia=aenean&curae=sit&nulla=amet&dapibus=justo&dolor=morbi&vel=ut&est=odio&donec=cras&odio=mi&justo=pede&sollicitudin=malesuada&ut=in&suscipit=imperdiet&a=et&feugiat=commodo&et=vulputate&eros=justo&vestibulum=in&ac=blandit&est=ultrices&lacinia=enim&nisi=lorem&venenatis=ipsum&tristique=dolor&fusce=sit&congue=amet&diam=consectetuer&id=adipiscing&ornare=elit&imperdiet=proin&sapien=interdum&urna=mauris', 1991, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 212.94, 12, 9, 'http://vk.com/felis.png?sit=habitasse&amet=platea&eros=dictumst&suspendisse=maecenas&accumsan=ut&tortor=massa&quis=quis&turpis=augue&sed=luctus&ante=tincidunt&vivamus=nulla&tortor=mollis&duis=molestie&mattis=lorem&egestas=quisque&metus=ut&aenean=erat&fermentum=curabitur&donec=gravida', 2005, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 35.52, 30, 91, 'https://cornell.edu/sollicitudin.png?sed=adipiscing&interdum=elit&venenatis=proin&turpis=risus&enim=praesent&blandit=lectus&mi=vestibulum&in=quam&porttitor=sapien&pede=varius&justo=ut&eu=blandit&massa=non&donec=interdum&dapibus=in&duis=ante&at=vestibulum&velit=ante&eu=ipsum&est=primis&congue=in&elementum=faucibus&in=orci&hac=luctus&habitasse=et&platea=ultrices&dictumst=posuere&morbi=cubilia&vestibulum=curae&velit=duis&id=faucibus&pretium=accumsan&iaculis=odio&diam=curabitur&erat=convallis&fermentum=duis&justo=consequat&nec=dui&condimentum=nec&neque=nisi&sapien=volutpat&placerat=eleifend&ante=donec&nulla=ut&justo=dolor&aliquam=morbi&quis=vel&turpis=lectus&eget=in&elit=quam&sodales=fringilla&scelerisque=rhoncus&mauris=mauris&sit=enim&amet=leo&eros=rhoncus&suspendisse=sed&accumsan=vestibulum&tortor=sit&quis=amet&turpis=cursus&sed=id&ante=turpis&vivamus=integer&tortor=aliquet&duis=massa', 1999, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 216.72, 99, 90, 'http://hibu.com/natoque/penatibus/et/magnis/dis/parturient.html?nulla=aliquam&pede=augue&ullamcorper=quam&augue=sollicitudin&a=vitae&suscipit=consectetuer&nulla=eget&elit=rutrum&ac=at&nulla=lorem&sed=integer&vel=tincidunt&enim=ante&sit=vel&amet=ipsum&nunc=praesent&viverra=blandit&dapibus=lacinia', 1986, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 105.3, 23, 89, 'https://vk.com/in.aspx?in=ultrices&faucibus=posuere&orci=cubilia&luctus=curae&et=nulla&ultrices=dapibus&posuere=dolor&cubilia=vel&curae=est&mauris=donec&viverra=odio&diam=justo&vitae=sollicitudin&quam=ut&suspendisse=suscipit&potenti=a&nullam=feugiat&porttitor=et&lacus=eros&at=vestibulum&turpis=ac&donec=est&posuere=lacinia&metus=nisi&vitae=venenatis&ipsum=tristique&aliquam=fusce&non=congue&mauris=diam&morbi=id&non=ornare&lectus=imperdiet&aliquam=sapien&sit=urna&amet=pretium&diam=nisl&in=ut&magna=volutpat&bibendum=sapien&imperdiet=arcu&nullam=sed&orci=augue&pede=aliquam&venenatis=erat&non=volutpat&sodales=in&sed=congue&tincidunt=etiam&eu=justo&felis=etiam&fusce=pretium&posuere=iaculis&felis=justo&sed=in&lacus=hac&morbi=habitasse&sem=platea&mauris=dictumst&laoreet=etiam&ut=faucibus&rhoncus=cursus&aliquet=urna&pulvinar=ut&sed=tellus&nisl=nulla&nunc=ut&rhoncus=erat&dui=id&vel=mauris&sem=vulputate&sed=elementum', 1998, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 209.23, 70, 56, 'http://google.cn/velit/nec/nisi/vulputate/nonummy/maecenas/tincidunt.jsp?volutpat=felis&eleifend=sed&donec=interdum&ut=venenatis&dolor=turpis&morbi=enim&vel=blandit&lectus=mi&in=in&quam=porttitor&fringilla=pede&rhoncus=justo&mauris=eu&enim=massa&leo=donec&rhoncus=dapibus&sed=duis&vestibulum=at&sit=velit&amet=eu&cursus=est&id=congue&turpis=elementum&integer=in&aliquet=hac&massa=habitasse&id=platea&lobortis=dictumst&convallis=morbi&tortor=vestibulum&risus=velit&dapibus=id&augue=pretium&vel=iaculis&accumsan=diam&tellus=erat&nisi=fermentum&eu=justo&orci=nec&mauris=condimentum&lacinia=neque&sapien=sapien&quis=placerat&libero=ante&nullam=nulla&sit=justo&amet=aliquam&turpis=quis&elementum=turpis&ligula=eget&vehicula=elit&consequat=sodales&morbi=scelerisque&a=mauris&ipsum=sit&integer=amet&a=eros&nibh=suspendisse&in=accumsan&quis=tortor&justo=quis&maecenas=turpis&rhoncus=sed&aliquam=ante&lacus=vivamus&morbi=tortor&quis=duis&tortor=mattis&id=egestas&nulla=metus&ultrices=aenean&aliquet=fermentum&maecenas=donec&leo=ut&odio=mauris&condimentum=eget&id=massa&luctus=tempor&nec=convallis&molestie=nulla&sed=neque&justo=libero&pellentesque=convallis&viverra=eget&pede=eleifend&ac=luctus&diam=ultricies', 2002, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 245.31, 11, 40, 'http://uiuc.edu/eget/congue/eget/semper/rutrum/nulla/nunc.jsp?tristique=dictumst&fusce=aliquam&congue=augue&diam=quam&id=sollicitudin&ornare=vitae&imperdiet=consectetuer&sapien=eget&urna=rutrum&pretium=at&nisl=lorem&ut=integer&volutpat=tincidunt&sapien=ante&arcu=vel&sed=ipsum&augue=praesent&aliquam=blandit&erat=lacinia&volutpat=erat&in=vestibulum&congue=sed&etiam=magna&justo=at&etiam=nunc&pretium=commodo&iaculis=placerat&justo=praesent&in=blandit&hac=nam&habitasse=nulla&platea=integer&dictumst=pede&etiam=justo&faucibus=lacinia&cursus=eget&urna=tincidunt&ut=eget&tellus=tempus&nulla=vel&ut=pede&erat=morbi&id=porttitor&mauris=lorem&vulputate=id&elementum=ligula&nullam=suspendisse&varius=ornare&nulla=consequat&facilisi=lectus&cras=in&non=est&velit=risus&nec=auctor&nisi=sed&vulputate=tristique&nonummy=in&maecenas=tempus&tincidunt=sit&lacus=amet&at=sem&velit=fusce&vivamus=consequat&vel=nulla&nulla=nisl&eget=nunc&eros=nisl&elementum=duis&pellentesque=bibendum&quisque=felis&porta=sed&volutpat=interdum&erat=venenatis&quisque=turpis&erat=enim&eros=blandit&viverra=mi&eget=in&congue=porttitor&eget=pede&semper=justo&rutrum=eu&nulla=massa&nunc=donec&purus=dapibus&phasellus=duis&in=at&felis=velit&donec=eu&semper=est&sapien=congue&a=elementum&libero=in', 2012, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 11.89, 59, 89, 'http://forbes.com/cras/pellentesque/volutpat/dui/maecenas/tristique.html?nullam=sapien&porttitor=varius&lacus=ut&at=blandit&turpis=non&donec=interdum&posuere=in&metus=ante&vitae=vestibulum&ipsum=ante&aliquam=ipsum&non=primis&mauris=in&morbi=faucibus&non=orci&lectus=luctus&aliquam=et&sit=ultrices&amet=posuere&diam=cubilia&in=curae&magna=duis&bibendum=faucibus&imperdiet=accumsan&nullam=odio&orci=curabitur&pede=convallis&venenatis=duis&non=consequat&sodales=dui&sed=nec&tincidunt=nisi&eu=volutpat&felis=eleifend&fusce=donec&posuere=ut&felis=dolor&sed=morbi&lacus=vel&morbi=lectus&sem=in&mauris=quam&laoreet=fringilla&ut=rhoncus&rhoncus=mauris&aliquet=enim&pulvinar=leo&sed=rhoncus&nisl=sed&nunc=vestibulum&rhoncus=sit&dui=amet&vel=cursus&sem=id&sed=turpis&sagittis=integer&nam=aliquet&congue=massa&risus=id', 2010, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 157.37, 63, 98, 'https://ihg.com/lacinia/eget.png?fusce=dolor&posuere=vel&felis=est&sed=donec&lacus=odio&morbi=justo&sem=sollicitudin&mauris=ut&laoreet=suscipit&ut=a&rhoncus=feugiat&aliquet=et&pulvinar=eros&sed=vestibulum&nisl=ac&nunc=est&rhoncus=lacinia&dui=nisi&vel=venenatis&sem=tristique', 1991, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 183.5, 84, 57, 'http://oaic.gov.au/volutpat/erat/quisque/erat/eros/viverra/eget.js?dapibus=nulla&dolor=ultrices&vel=aliquet&est=maecenas&donec=leo&odio=odio&justo=condimentum&sollicitudin=id&ut=luctus&suscipit=nec&a=molestie&feugiat=sed&et=justo&eros=pellentesque&vestibulum=viverra&ac=pede&est=ac&lacinia=diam&nisi=cras&venenatis=pellentesque&tristique=volutpat&fusce=dui&congue=maecenas&diam=tristique&id=est&ornare=et&imperdiet=tempus&sapien=semper&urna=est&pretium=quam&nisl=pharetra&ut=magna&volutpat=ac&sapien=consequat&arcu=metus&sed=sapien&augue=ut&aliquam=nunc&erat=vestibulum&volutpat=ante&in=ipsum&congue=primis&etiam=in&justo=faucibus&etiam=orci&pretium=luctus&iaculis=et&justo=ultrices&in=posuere&hac=cubilia&habitasse=curae', 2012, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 246.1, 10, 63, 'https://omniture.com/nam/nulla/integer.html?integer=volutpat&ac=in&leo=congue&pellentesque=etiam&ultrices=justo&mattis=etiam', 2007, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 133.69, 24, 51, 'https://usgs.gov/ipsum/aliquam/non/mauris/morbi/non/lectus.html?massa=luctus&id=et&lobortis=ultrices&convallis=posuere&tortor=cubilia&risus=curae&dapibus=duis&augue=faucibus&vel=accumsan&accumsan=odio&tellus=curabitur&nisi=convallis&eu=duis&orci=consequat&mauris=dui&lacinia=nec&sapien=nisi&quis=volutpat&libero=eleifend&nullam=donec&sit=ut&amet=dolor&turpis=morbi&elementum=vel&ligula=lectus&vehicula=in&consequat=quam&morbi=fringilla&a=rhoncus&ipsum=mauris&integer=enim&a=leo&nibh=rhoncus&in=sed&quis=vestibulum&justo=sit&maecenas=amet&rhoncus=cursus&aliquam=id&lacus=turpis&morbi=integer&quis=aliquet&tortor=massa', 2011, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 96.04, 25, 64, 'https://soup.io/neque.png?lorem=erat&integer=quisque&tincidunt=erat&ante=eros&vel=viverra&ipsum=eget&praesent=congue&blandit=eget&lacinia=semper&erat=rutrum&vestibulum=nulla&sed=nunc&magna=purus&at=phasellus&nunc=in&commodo=felis&placerat=donec&praesent=semper&blandit=sapien&nam=a&nulla=libero&integer=nam&pede=dui&justo=proin&lacinia=leo&eget=odio&tincidunt=porttitor&eget=id&tempus=consequat&vel=in&pede=consequat&morbi=ut&porttitor=nulla&lorem=sed&id=accumsan&ligula=felis&suspendisse=ut&ornare=at&consequat=dolor&lectus=quis&in=odio&est=consequat', 1998, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 194.49, 69, 34, 'https://bravesites.com/cursus/urna.png?nullam=et&orci=tempus&pede=semper&venenatis=est&non=quam&sodales=pharetra&sed=magna&tincidunt=ac&eu=consequat&felis=metus&fusce=sapien&posuere=ut&felis=nunc&sed=vestibulum&lacus=ante&morbi=ipsum&sem=primis&mauris=in&laoreet=faucibus&ut=orci&rhoncus=luctus&aliquet=et&pulvinar=ultrices&sed=posuere&nisl=cubilia&nunc=curae&rhoncus=mauris&dui=viverra&vel=diam&sem=vitae&sed=quam&sagittis=suspendisse&nam=potenti&congue=nullam&risus=porttitor&semper=lacus&porta=at&volutpat=turpis&quam=donec&pede=posuere&lobortis=metus&ligula=vitae&sit=ipsum&amet=aliquam&eleifend=non&pede=mauris&libero=morbi&quis=non&orci=lectus&nullam=aliquam&molestie=sit&nibh=amet&in=diam&lectus=in&pellentesque=magna&at=bibendum&nulla=imperdiet&suspendisse=nullam&potenti=orci&cras=pede&in=venenatis&purus=non&eu=sodales&magna=sed&vulputate=tincidunt&luctus=eu&cum=felis&sociis=fusce&natoque=posuere', 1993, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 69.35, 28, 92, 'https://123-reg.co.uk/nulla/facilisi.jsp?nibh=in&in=tempus&quis=sit&justo=amet&maecenas=sem&rhoncus=fusce&aliquam=consequat&lacus=nulla&morbi=nisl&quis=nunc&tortor=nisl&id=duis&nulla=bibendum&ultrices=felis&aliquet=sed&maecenas=interdum&leo=venenatis&odio=turpis&condimentum=enim&id=blandit&luctus=mi&nec=in&molestie=porttitor&sed=pede&justo=justo&pellentesque=eu&viverra=massa&pede=donec', 2000, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 96.87, 90, 38, 'https://time.com/placerat/praesent/blandit/nam.png?felis=elit&sed=proin&interdum=risus&venenatis=praesent&turpis=lectus&enim=vestibulum&blandit=quam&mi=sapien&in=varius&porttitor=ut&pede=blandit&justo=non&eu=interdum&massa=in&donec=ante&dapibus=vestibulum&duis=ante&at=ipsum&velit=primis&eu=in&est=faucibus&congue=orci&elementum=luctus&in=et&hac=ultrices&habitasse=posuere&platea=cubilia&dictumst=curae&morbi=duis&vestibulum=faucibus&velit=accumsan&id=odio&pretium=curabitur&iaculis=convallis&diam=duis&erat=consequat&fermentum=dui&justo=nec&nec=nisi&condimentum=volutpat&neque=eleifend&sapien=donec&placerat=ut&ante=dolor&nulla=morbi&justo=vel&aliquam=lectus&quis=in&turpis=quam&eget=fringilla&elit=rhoncus&sodales=mauris&scelerisque=enim&mauris=leo&sit=rhoncus&amet=sed&eros=vestibulum&suspendisse=sit&accumsan=amet&tortor=cursus&quis=id&turpis=turpis&sed=integer&ante=aliquet&vivamus=massa&tortor=id&duis=lobortis&mattis=convallis&egestas=tortor&metus=risus&aenean=dapibus&fermentum=augue&donec=vel&ut=accumsan&mauris=tellus&eget=nisi&massa=eu', 2008, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 79.28, 40, 17, 'https://bluehost.com/faucibus/orci.jpg?eget=sed&elit=sagittis&sodales=nam&scelerisque=congue&mauris=risus&sit=semper&amet=porta&eros=volutpat&suspendisse=quam&accumsan=pede&tortor=lobortis&quis=ligula&turpis=sit&sed=amet&ante=eleifend&vivamus=pede&tortor=libero&duis=quis&mattis=orci&egestas=nullam&metus=molestie&aenean=nibh&fermentum=in&donec=lectus&ut=pellentesque&mauris=at&eget=nulla&massa=suspendisse&tempor=potenti&convallis=cras&nulla=in&neque=purus&libero=eu&convallis=magna&eget=vulputate&eleifend=luctus&luctus=cum&ultricies=sociis&eu=natoque&nibh=penatibus&quisque=et&id=magnis&justo=dis&sit=parturient&amet=montes&sapien=nascetur&dignissim=ridiculus&vestibulum=mus&vestibulum=vivamus&ante=vestibulum&ipsum=sagittis&primis=sapien&in=cum&faucibus=sociis&orci=natoque&luctus=penatibus&et=et', 2000, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 203.26, 65, 48, 'http://mac.com/amet.xml?dapibus=ante&duis=vivamus&at=tortor&velit=duis&eu=mattis&est=egestas&congue=metus&elementum=aenean&in=fermentum&hac=donec&habitasse=ut&platea=mauris&dictumst=eget&morbi=massa&vestibulum=tempor&velit=convallis&id=nulla&pretium=neque&iaculis=libero&diam=convallis&erat=eget&fermentum=eleifend&justo=luctus&nec=ultricies&condimentum=eu&neque=nibh&sapien=quisque&placerat=id&ante=justo&nulla=sit&justo=amet&aliquam=sapien&quis=dignissim&turpis=vestibulum&eget=vestibulum&elit=ante&sodales=ipsum&scelerisque=primis&mauris=in&sit=faucibus&amet=orci&eros=luctus&suspendisse=et&accumsan=ultrices&tortor=posuere&quis=cubilia&turpis=curae&sed=nulla&ante=dapibus&vivamus=dolor&tortor=vel&duis=est&mattis=donec&egestas=odio&metus=justo&aenean=sollicitudin&fermentum=ut&donec=suscipit&ut=a&mauris=feugiat&eget=et&massa=eros&tempor=vestibulum&convallis=ac&nulla=est', 2009, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 233.79, 3, 65, 'http://163.com/nunc/purus/phasellus/in.png?massa=vestibulum&id=sed&nisl=magna&venenatis=at&lacinia=nunc&aenean=commodo&sit=placerat&amet=praesent&justo=blandit&morbi=nam&ut=nulla&odio=integer&cras=pede&mi=justo&pede=lacinia&malesuada=eget&in=tincidunt&imperdiet=eget&et=tempus&commodo=vel&vulputate=pede&justo=morbi&in=porttitor&blandit=lorem&ultrices=id&enim=ligula&lorem=suspendisse&ipsum=ornare', 2000, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 141.71, 10, 58, 'https://vistaprint.com/nunc/purus/phasellus.aspx?congue=hac&elementum=habitasse&in=platea&hac=dictumst&habitasse=aliquam&platea=augue&dictumst=quam&morbi=sollicitudin&vestibulum=vitae&velit=consectetuer&id=eget&pretium=rutrum&iaculis=at&diam=lorem&erat=integer&fermentum=tincidunt&justo=ante&nec=vel&condimentum=ipsum&neque=praesent&sapien=blandit&placerat=lacinia&ante=erat&nulla=vestibulum&justo=sed&aliquam=magna&quis=at&turpis=nunc&eget=commodo&elit=placerat&sodales=praesent&scelerisque=blandit&mauris=nam&sit=nulla&amet=integer&eros=pede&suspendisse=justo&accumsan=lacinia&tortor=eget&quis=tincidunt&turpis=eget&sed=tempus&ante=vel&vivamus=pede&tortor=morbi&duis=porttitor&mattis=lorem&egestas=id&metus=ligula&aenean=suspendisse&fermentum=ornare&donec=consequat&ut=lectus&mauris=in&eget=est&massa=risus&tempor=auctor&convallis=sed&nulla=tristique&neque=in&libero=tempus&convallis=sit&eget=amet&eleifend=sem&luctus=fusce&ultricies=consequat&eu=nulla&nibh=nisl&quisque=nunc&id=nisl&justo=duis&sit=bibendum&amet=felis&sapien=sed&dignissim=interdum&vestibulum=venenatis&vestibulum=turpis&ante=enim&ipsum=blandit&primis=mi&in=in&faucibus=porttitor&orci=pede&luctus=justo&et=eu&ultrices=massa&posuere=donec&cubilia=dapibus', 2000, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 122.02, 93, 69, 'https://phpbb.com/eu/nibh.aspx?ut=nulla&ultrices=sed&vel=accumsan&augue=felis&vestibulum=ut&ante=at&ipsum=dolor&primis=quis&in=odio&faucibus=consequat&orci=varius&luctus=integer&et=ac&ultrices=leo&posuere=pellentesque&cubilia=ultrices&curae=mattis&donec=odio&pharetra=donec&magna=vitae&vestibulum=nisi&aliquet=nam&ultrices=ultrices&erat=libero&tortor=non&sollicitudin=mattis&mi=pulvinar&sit=nulla&amet=pede&lobortis=ullamcorper&sapien=augue&sapien=a&non=suscipit&mi=nulla&integer=elit&ac=ac&neque=nulla&duis=sed&bibendum=vel&morbi=enim&non=sit&quam=amet&nec=nunc&dui=viverra&luctus=dapibus&rutrum=nulla&nulla=suscipit', 1993, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 105.06, 11, 28, 'https://amazon.co.uk/curabitur.png?turpis=arcu&elementum=sed&ligula=augue&vehicula=aliquam&consequat=erat&morbi=volutpat&a=in&ipsum=congue&integer=etiam&a=justo&nibh=etiam&in=pretium&quis=iaculis&justo=justo&maecenas=in&rhoncus=hac&aliquam=habitasse&lacus=platea', 2007, 1, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 71.46, 40, 98, 'https://sciencedaily.com/lacus.js?gravida=quis&nisi=orci&at=nullam&nibh=molestie&in=nibh&hac=in&habitasse=lectus&platea=pellentesque&dictumst=at&aliquam=nulla&augue=suspendisse&quam=potenti&sollicitudin=cras&vitae=in&consectetuer=purus&eget=eu&rutrum=magna&at=vulputate&lorem=luctus&integer=cum&tincidunt=sociis&ante=natoque&vel=penatibus&ipsum=et&praesent=magnis&blandit=dis&lacinia=parturient&erat=montes&vestibulum=nascetur&sed=ridiculus&magna=mus&at=vivamus&nunc=vestibulum&commodo=sagittis&placerat=sapien&praesent=cum&blandit=sociis&nam=natoque&nulla=penatibus&integer=et&pede=magnis&justo=dis&lacinia=parturient&eget=montes&tincidunt=nascetur&eget=ridiculus&tempus=mus&vel=etiam&pede=vel&morbi=augue&porttitor=vestibulum&lorem=rutrum&id=rutrum&ligula=neque&suspendisse=aenean&ornare=auctor&consequat=gravida&lectus=sem&in=praesent&est=id&risus=massa&auctor=id&sed=nisl&tristique=venenatis&in=lacinia&tempus=aenean&sit=sit&amet=amet&sem=justo&fusce=morbi&consequat=ut&nulla=odio&nisl=cras&nunc=mi&nisl=pede&duis=malesuada&bibendum=in&felis=imperdiet&sed=et', 2009, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 74.2, 94, 29, 'https://tripod.com/quam/a/odio/in/hac/habitasse.jsp?neque=massa&libero=quis&convallis=augue&eget=luctus&eleifend=tincidunt&luctus=nulla&ultricies=mollis&eu=molestie&nibh=lorem&quisque=quisque&id=ut&justo=erat&sit=curabitur&amet=gravida&sapien=nisi&dignissim=at&vestibulum=nibh&vestibulum=in&ante=hac&ipsum=habitasse&primis=platea&in=dictumst&faucibus=aliquam&orci=augue&luctus=quam&et=sollicitudin&ultrices=vitae&posuere=consectetuer&cubilia=eget&curae=rutrum&nulla=at&dapibus=lorem&dolor=integer&vel=tincidunt&est=ante&donec=vel&odio=ipsum&justo=praesent&sollicitudin=blandit&ut=lacinia&suscipit=erat&a=vestibulum&feugiat=sed&et=magna&eros=at&vestibulum=nunc&ac=commodo&est=placerat&lacinia=praesent&nisi=blandit&venenatis=nam&tristique=nulla&fusce=integer&congue=pede&diam=justo&id=lacinia&ornare=eget&imperdiet=tincidunt&sapien=eget', 1999, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 130.72, 22, 32, 'https://latimes.com/consectetuer/adipiscing.aspx?id=varius&nisl=ut&venenatis=blandit&lacinia=non&aenean=interdum&sit=in&amet=ante&justo=vestibulum&morbi=ante&ut=ipsum&odio=primis&cras=in&mi=faucibus&pede=orci&malesuada=luctus&in=et&imperdiet=ultrices&et=posuere&commodo=cubilia&vulputate=curae&justo=duis&in=faucibus&blandit=accumsan&ultrices=odio&enim=curabitur&lorem=convallis&ipsum=duis&dolor=consequat&sit=dui&amet=nec&consectetuer=nisi&adipiscing=volutpat&elit=eleifend&proin=donec&interdum=ut&mauris=dolor&non=morbi&ligula=vel&pellentesque=lectus&ultrices=in&phasellus=quam&id=fringilla&sapien=rhoncus&in=mauris&sapien=enim&iaculis=leo&congue=rhoncus&vivamus=sed&metus=vestibulum&arcu=sit&adipiscing=amet&molestie=cursus&hendrerit=id&at=turpis&vulputate=integer&vitae=aliquet&nisl=massa&aenean=id&lectus=lobortis&pellentesque=convallis&eget=tortor&nunc=risus&donec=dapibus&quis=augue&orci=vel&eget=accumsan&orci=tellus&vehicula=nisi&condimentum=eu&curabitur=orci&in=mauris&libero=lacinia&ut=sapien&massa=quis&volutpat=libero&convallis=nullam&morbi=sit&odio=amet&odio=turpis', 2004, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 178.03, 17, 17, 'http://omniture.com/sociis/natoque/penatibus/et/magnis/dis/parturient.jsp?in=porttitor&ante=id&vestibulum=consequat&ante=in&ipsum=consequat&primis=ut&in=nulla&faucibus=sed&orci=accumsan&luctus=felis&et=ut&ultrices=at&posuere=dolor&cubilia=quis&curae=odio&duis=consequat&faucibus=varius&accumsan=integer&odio=ac&curabitur=leo&convallis=pellentesque&duis=ultrices&consequat=mattis&dui=odio&nec=donec&nisi=vitae&volutpat=nisi&eleifend=nam&donec=ultrices&ut=libero&dolor=non&morbi=mattis&vel=pulvinar&lectus=nulla&in=pede&quam=ullamcorper&fringilla=augue&rhoncus=a&mauris=suscipit&enim=nulla&leo=elit&rhoncus=ac&sed=nulla&vestibulum=sed&sit=vel&amet=enim&cursus=sit&id=amet&turpis=nunc&integer=viverra&aliquet=dapibus&massa=nulla&id=suscipit&lobortis=ligula&convallis=in&tortor=lacus&risus=curabitur&dapibus=at&augue=ipsum&vel=ac&accumsan=tellus&tellus=semper&nisi=interdum&eu=mauris&orci=ullamcorper', 2004, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 157.93, 61, 96, 'http://tripadvisor.com/elementum.png?aliquam=erat&non=vestibulum&mauris=sed&morbi=magna&non=at&lectus=nunc&aliquam=commodo&sit=placerat&amet=praesent&diam=blandit&in=nam&magna=nulla&bibendum=integer&imperdiet=pede&nullam=justo&orci=lacinia&pede=eget&venenatis=tincidunt&non=eget&sodales=tempus&sed=vel&tincidunt=pede&eu=morbi&felis=porttitor&fusce=lorem&posuere=id&felis=ligula&sed=suspendisse&lacus=ornare&morbi=consequat&sem=lectus&mauris=in&laoreet=est&ut=risus&rhoncus=auctor&aliquet=sed&pulvinar=tristique&sed=in&nisl=tempus&nunc=sit&rhoncus=amet&dui=sem&vel=fusce&sem=consequat&sed=nulla&sagittis=nisl&nam=nunc&congue=nisl&risus=duis&semper=bibendum&porta=felis&volutpat=sed&quam=interdum&pede=venenatis&lobortis=turpis&ligula=enim&sit=blandit&amet=mi&eleifend=in&pede=porttitor&libero=pede&quis=justo&orci=eu&nullam=massa&molestie=donec&nibh=dapibus&in=duis&lectus=at&pellentesque=velit&at=eu&nulla=est&suspendisse=congue&potenti=elementum&cras=in&in=hac&purus=habitasse&eu=platea&magna=dictumst&vulputate=morbi&luctus=vestibulum&cum=velit&sociis=id&natoque=pretium&penatibus=iaculis&et=diam&magnis=erat&dis=fermentum&parturient=justo&montes=nec&nascetur=condimentum&ridiculus=neque&mus=sapien&vivamus=placerat&vestibulum=ante&sagittis=nulla&sapien=justo&cum=aliquam', 1999, 5, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 54.69, 31, 1, 'http://latimes.com/venenatis.xml?metus=pellentesque&aenean=quisque&fermentum=porta&donec=volutpat&ut=erat&mauris=quisque&eget=erat&massa=eros&tempor=viverra&convallis=eget&nulla=congue&neque=eget&libero=semper&convallis=rutrum&eget=nulla&eleifend=nunc&luctus=purus&ultricies=phasellus&eu=in&nibh=felis&quisque=donec&id=semper&justo=sapien&sit=a&amet=libero&sapien=nam&dignissim=dui&vestibulum=proin', 2010, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 107.7, 31, 43, 'https://msn.com/amet/sem.xml?orci=ut&luctus=dolor&et=morbi&ultrices=vel&posuere=lectus&cubilia=in&curae=quam&duis=fringilla&faucibus=rhoncus&accumsan=mauris&odio=enim&curabitur=leo&convallis=rhoncus&duis=sed&consequat=vestibulum&dui=sit&nec=amet&nisi=cursus&volutpat=id&eleifend=turpis&donec=integer&ut=aliquet&dolor=massa&morbi=id&vel=lobortis&lectus=convallis&in=tortor&quam=risus&fringilla=dapibus&rhoncus=augue&mauris=vel&enim=accumsan&leo=tellus&rhoncus=nisi&sed=eu&vestibulum=orci&sit=mauris&amet=lacinia&cursus=sapien&id=quis&turpis=libero&integer=nullam&aliquet=sit&massa=amet&id=turpis&lobortis=elementum&convallis=ligula&tortor=vehicula&risus=consequat&dapibus=morbi&augue=a&vel=ipsum&accumsan=integer&tellus=a&nisi=nibh&eu=in&orci=quis&mauris=justo&lacinia=maecenas&sapien=rhoncus&quis=aliquam&libero=lacus&nullam=morbi&sit=quis&amet=tortor&turpis=id&elementum=nulla&ligula=ultrices&vehicula=aliquet&consequat=maecenas&morbi=leo&a=odio&ipsum=condimentum&integer=id&a=luctus&nibh=nec&in=molestie&quis=sed&justo=justo&maecenas=pellentesque&rhoncus=viverra&aliquam=pede&lacus=ac&morbi=diam&quis=cras&tortor=pellentesque&id=volutpat&nulla=dui&ultrices=maecenas&aliquet=tristique&maecenas=est&leo=et&odio=tempus&condimentum=semper&id=est&luctus=quam', 1993, 4, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 18.72, 58, 89, 'http://patch.com/eget/eros/elementum/pellentesque/quisque/porta.png?justo=cursus&lacinia=vestibulum&eget=proin&tincidunt=eu&eget=mi&tempus=nulla&vel=ac&pede=enim&morbi=in&porttitor=tempor&lorem=turpis&id=nec&ligula=euismod&suspendisse=scelerisque&ornare=quam&consequat=turpis&lectus=adipiscing&in=lorem&est=vitae&risus=mattis&auctor=nibh&sed=ligula&tristique=nec&in=sem&tempus=duis&sit=aliquam&amet=convallis&sem=nunc&fusce=proin&consequat=at&nulla=turpis&nisl=a&nunc=pede&nisl=posuere&duis=nonummy&bibendum=integer&felis=non&sed=velit&interdum=donec&venenatis=diam&turpis=neque&enim=vestibulum&blandit=eget&mi=vulputate&in=ut&porttitor=ultrices&pede=vel&justo=augue&eu=vestibulum&massa=ante&donec=ipsum&dapibus=primis&duis=in&at=faucibus&velit=orci&eu=luctus&est=et&congue=ultrices&elementum=posuere&in=cubilia&hac=curae&habitasse=donec&platea=pharetra&dictumst=magna&morbi=vestibulum&vestibulum=aliquet&velit=ultrices&id=erat&pretium=tortor', 2012, 3, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 173.13, 94, 6, 'http://taobao.com/elementum/ligula.png?metus=orci&aenean=luctus&fermentum=et&donec=ultrices&ut=posuere&mauris=cubilia&eget=curae&massa=donec&tempor=pharetra&convallis=magna&nulla=vestibulum&neque=aliquet&libero=ultrices&convallis=erat&eget=tortor&eleifend=sollicitudin&luctus=mi&ultricies=sit&eu=amet&nibh=lobortis&quisque=sapien&id=sapien&justo=non&sit=mi&amet=integer&sapien=ac&dignissim=neque&vestibulum=duis&vestibulum=bibendum&ante=morbi&ipsum=non&primis=quam&in=nec&faucibus=dui', 1997, 2, '123-21214-12');
INSERT INTO product ( price, stock_quantity, name, url, year, rating, sku) VALUES ( 35.05, 80, 9, 'https://booking.com/donec/quis/orci/eget/orci.js?habitasse=pharetra&platea=magna&dictumst=ac&aliquam=consequat&augue=metus', 2008, 1, '123-21214-12');

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
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (7, 3, '451723505-X', 7);
INSERT INTO book (id_product, edition, isbn, id_publisher) VALUES (8, 2, '190500643-8', 8);

INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (9, 'Meijer NICOTINE TRANSDERMAL SYSTEM', 'tangible', 9);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (10, 'ACYCLOVIR', 'scalable', 10);
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
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (21, 'Pravastatin Sodium', 'benchmark', 21);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (22, 'Finasteride', 'intangible', 22);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (23, 'Petasites Quercus', 'interactive', 23);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (24, 'Irbesartan and Hydrochlorothiazide', 'benchmark', 24);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (25, 'Sulfacetamide Sodium and Prednisolone Sodium Phosphate', 'discrete', 25);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (26, 'flormar Soft Touch Foundation Sunscreen Broad Spectrum SPF 20 ST01 Light Pink', 'content-based', 26);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (27, 'Compazine', 'Re-contextualized', 27);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (28, '7 select night time relief', 'benchmark', 28);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (29, 'SUGAR FREE SWISS CHERRY HERB THROAT DROPS', 'projection', 29);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (30, 'Liquid corn and Callus Remover', 'superstructure', 30);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (31, 'lice', 'system engine', 31);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (32, 'LOreal Paris Advanced Suncare Invisible Protect Dry 15 Sunscreen Broad Spectrum SPF 15', 'Up-sized', 32);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (33, 'Alvesco', 'open architecture', 33);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (34, 'Docuprene', 'Balanced', 34);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (35, 'NUX VOMICA', 'content-based', 35);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (36, 'Boy Butter', 'Monitored', 36);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (37, 'Carisoprodol', 'optimizing', 37);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (38, 'Neomycin and Polymyxin B Sulfates', 'directional', 38);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (39, 'Friuts and Flowers Clean Cotton Waterless Hand Sanitizer', 'full-range', 39);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (40, 'Wholistic Thyroid Balance', 'function', 40);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (41, 'Bethanechol Chloride', 'interactive', 41);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (42, 'TOBREX', 'high-level', 42);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (43, 'Sumatriptan', 'Self-enabling', 43);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (44, 'Sinus Congestion and Pain', 'Mandatory', 44);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (45, 'Tobramycin in Sodium Chloride', 'multimedia', 45);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (46, 'Up and Up Cold and Head Congestion', 'capacity', 46);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (47, 'First Aid Antiseptic', 'installation', 47);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (48, 'Mirtazapine', 'full-range', 48);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (49, 'Trazodone Hydrochloride', 'Multi-channelled', 49);
INSERT INTO shoe (id_product, name, type_name, brand_name) VALUES (50, 'Milrinone Lactate', 'architecture', 50);

INSERT INTO funkoPop (id_product, number_pop) VALUES (51, 1803);
INSERT INTO funkoPop (id_product, number_pop) VALUES (52, 3446);
INSERT INTO funkoPop (id_product, number_pop) VALUES (53, 1923);
INSERT INTO funkoPop (id_product, number_pop) VALUES (54, 1625);
INSERT INTO funkoPop (id_product, number_pop) VALUES (55, 1512);
INSERT INTO funkoPop (id_product, number_pop) VALUES (56, 108);
INSERT INTO funkoPop (id_product, number_pop) VALUES (57, 1005);
INSERT INTO funkoPop (id_product, number_pop) VALUES (58, 829);
INSERT INTO funkoPop (id_product, number_pop) VALUES (59, 3028);
INSERT INTO funkoPop (id_product, number_pop) VALUES (60, 2990);
INSERT INTO funkoPop (id_product, number_pop) VALUES (61, 426);
INSERT INTO funkoPop (id_product, number_pop) VALUES (62, 2040);
INSERT INTO funkoPop (id_product, number_pop) VALUES (63, 170);
INSERT INTO funkoPop (id_product, number_pop) VALUES (64, 2261);
INSERT INTO funkoPop (id_product, number_pop) VALUES (65, 3606);
INSERT INTO funkoPop (id_product, number_pop) VALUES (66, 1063);
INSERT INTO funkoPop (id_product, number_pop) VALUES (67, 594);
INSERT INTO funkoPop (id_product, number_pop) VALUES (68, 4714);
INSERT INTO funkoPop (id_product, number_pop) VALUES (69, 2533);
INSERT INTO funkoPop (id_product, number_pop) VALUES (70, 1449);
INSERT INTO funkoPop (id_product, number_pop) VALUES (71, 4534);
INSERT INTO funkoPop (id_product, number_pop) VALUES (72, 4998);
INSERT INTO funkoPop (id_product, number_pop) VALUES (73, 4969);
INSERT INTO funkoPop (id_product, number_pop) VALUES (74, 155);
INSERT INTO funkoPop (id_product, number_pop) VALUES (75, 3277);
INSERT INTO funkoPop (id_product, number_pop) VALUES (76, 1302);
INSERT INTO funkoPop (id_product, number_pop) VALUES (77, 3460);
INSERT INTO funkoPop (id_product, number_pop) VALUES (78, 3328);
INSERT INTO funkoPop (id_product, number_pop) VALUES (79, 282);
INSERT INTO funkoPop (id_product, number_pop) VALUES (80, 4374);
INSERT INTO funkoPop (id_product, number_pop) VALUES (81, 1139);
INSERT INTO funkoPop (id_product, number_pop) VALUES (82, 1175);
INSERT INTO funkoPop (id_product, number_pop) VALUES (83, 1570);
INSERT INTO funkoPop (id_product, number_pop) VALUES (84, 474);
INSERT INTO funkoPop (id_product, number_pop) VALUES (85, 2119);
INSERT INTO funkoPop (id_product, number_pop) VALUES (86, 3804);
INSERT INTO funkoPop (id_product, number_pop) VALUES (87, 1967);
INSERT INTO funkoPop (id_product, number_pop) VALUES (88, 3191);
INSERT INTO funkoPop (id_product, number_pop) VALUES (89, 1572);
INSERT INTO funkoPop (id_product, number_pop) VALUES (90, 1080);
INSERT INTO funkoPop (id_product, number_pop) VALUES (91, 2599);
INSERT INTO funkoPop (id_product, number_pop) VALUES (92, 1778);
INSERT INTO funkoPop (id_product, number_pop) VALUES (93, 3247);
INSERT INTO funkoPop (id_product, number_pop) VALUES (94, 4977);
INSERT INTO funkoPop (id_product, number_pop) VALUES (95, 995);
INSERT INTO funkoPop (id_product, number_pop) VALUES (96, 2466);
INSERT INTO funkoPop (id_product, number_pop) VALUES (97, 3743);
INSERT INTO funkoPop (id_product, number_pop) VALUES (98, 388);
INSERT INTO funkoPop (id_product, number_pop) VALUES (99, 4931);
INSERT INTO funkoPop (id_product, number_pop) VALUES (100, 446);

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

INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (9, 50, 18, 11);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (10, 33, 8, 8);
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
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (21, 22, 42, 22);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (22, 9, 21, 4);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (23, 2, 45, 24);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (24, 29, 30, 3);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (25, 26, 17, 19);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (26, 32, 29, 13);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (27, 1, 33, 4);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (28, 49, 43, 2);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (29, 31, 47, 19);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (30, 12, 6, 3);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (31, 16, 46, 6);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (32, 39, 7, 10);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (33, 41, 45, 24);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (34, 39, 34, 12);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (35, 28, 47, 22);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (36, 27, 33, 8);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (37, 46, 31, 9);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (38, 4, 28, 16);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (39, 6, 25, 3);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (40, 30, 26, 13);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (41, 43, 30, 21);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (42, 41, 25, 16);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (43, 15, 39, 10);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (44, 12, 32, 13);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (45, 47, 5, 15);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (46, 49, 4, 1);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (47, 38, 10, 18);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (48, 37, 30, 2);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (49, 17, 48, 15);
INSERT INTO shoeColorSize (id_shoe, id_primaryColor, id_secondaryColor, id_size) VALUES (50, 3, 35, 4);


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
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 31, 31);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 32, 32);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 33, 33);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 34, 34);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 35, 35);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 36, 36);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 37, 37);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 38, 38);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 39, 39);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 40, 40);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 41, 41);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 42, 42);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 43, 43);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 44, 44);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 45, 45);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 46, 46);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 47, 47);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 48, 48);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 49, 49);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 50, 50);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 51, 51);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 52, 52);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 53, 53);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 54, 54);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 55, 55);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 56, 56);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 57, 57);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 58, 58);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 59, 59);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 60, 60);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 61, 61);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 62, 62);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 63, 63);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 64, 64);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 65, 65);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 66, 66);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 67, 67);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 68, 68);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 69, 69);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 70, 70);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 71, 71);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 72, 72);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 73, 73);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 74, 74);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 75, 75);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 76, 76);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 77, 77);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 78, 78);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 79, 79);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 80, 80);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 81, 81);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 82, 82);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 83, 83);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 84, 84);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 85, 85);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 86, 86);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 87, 87);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 88, 88);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 89, 89);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 90, 90);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 91, 91);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (1, 92, 92);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 93, 93);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 94, 94);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (2, 95, 95);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 96, 96);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 97, 97);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (3, 98, 98);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (5, 99, 99);
INSERT INTO productOrd (quantity, id_product, id_ord) VALUES (4, 100, 100);

INSERT INTO flagged (reason, id_review, id_comment) VALUES ('Spam',1,null);

-- IDX01  It's useful for searching products of a certain product that have the price lower than a certain value defined much faster,
CREATE INDEX product_price_idx ON product USING btree (price);

-- IDX02  Every time we need to make a query to get the address of an user, it has to be fast, because it can be executed several times
CREATE INDEX address_iduser_idx ON addressBook USING hash (id_user);

-- IDX03  Every time we need to make a query to get an order of any user, it has to be fast, because it can be executed several time
CREATE INDEX order_iduser_idx ON ord USING hash (id_user);

-- IDX04 To improve overall performance of full-text searches while searching for products by name.
CREATE INDEX search_product_name_idx ON product USING GIST (to_tsvector('english', name));


-- TRIGGER01
-- This trigger will make it so a user can only make a review on a previously purchased item. (ABR.01)

CREATE OR REPLACE FUNCTION check_user_ownership() RETURNS TRIGGER AS
    $BODY$
    BEGIN
        IF NOT EXISTS (
            SELECT *
            FROM productOrd WHERE productOrd.id_product = New.id_product AND
            productOrd.id_user = New.id_user) THEN
        RAISE EXCEPTION 'User doesn''t own this product so he can''t review it.';
       END IF;
       RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_review
        BEFORE INSERT OR UPDATE ON review
        FOR EACH ROW
        EXECUTE PROCEDURE check_user_ownership();

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




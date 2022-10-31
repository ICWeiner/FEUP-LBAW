--TX01 Commit user purchase

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZATION ANOMALY

BEGIN;

INSERT INTO ord (id_ord, total_price, tracking_number, buy_date, shipping_date, arrival_date, id_user) VALUES ($ord, 0, null, null, null, null, $user);

INSERT INTO productOrd (quantity, id_product, id_ord) VALUES ($quantity, $idProduct, $idOrd);

UPDATE product SET stock_quantity = stock_quantity - $quantity
  WHERE id_product = $idProduct;

UPDATE ord SET total_price = total_price + ($quantity * price)
  WHERE ord.id_ord = productOrd.id_ord AND productOrd.id_product = $idProduct;  

COMMIT;


--TX02  Commit user deletion
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL NON REPEATABLE READ;

UPDATE users SET 
        name = CONCAT('DELETED',id_user),
        email = CONCAT('DELETED@mail.com',id_user) ,
        password = $random_hash
        WHERE users.id_user = $id_user;

COMMIT;

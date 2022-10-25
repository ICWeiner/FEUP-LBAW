SET search_path TO lbaw2292;

-- TRIGGER06
-- This trigger will make users unable to buy more than there is available in stock.


CREATE OR REPLACE FUNCTION check_if_enough_stock() RETURNS TRIGGER AS
    $BODY$
    BEGIN
        IF EXISTS (
          SELECT productOrder.quantity
          FROM productOrder, Product, Ord WHERE productOrder.id_Product = Product.id_Product AND productOrder.id_Ord = Ord.id_Ord AND productOrder.quantity > Product.quantity) THEN
           RAISE EXCEPTION 'There isn''t enough stock of products for the order.';
        END IF;
        RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_stock
        BEFORE INSERT OR UPDATE ON productOrder
        FOR EACH ROW
        EXECUTE PROCEDURE check_if_enough_stock();

-- TRIGGER05
-- This trigger will make users unable to review items they didnt purchase.

CREATE OR REPLACE FUNCTION check_user_ownership() RETURNS TRIGGER AS
    $BODY$
    BEGIN
       IF NOT EXISTS (
         SELECT *
         FROM users, Ord, Review WHERE Ord.id_Ord = Review.id_Ord AND users.id_User = Ord.id_User) THEN
          RAISE EXCEPTION 'User doesn''t own this product so he can''t review it.';
       END IF;
       RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_review
        BEFORE INSERT OR UPDATE ON Review
        FOR EACH ROW
        EXECUTE PROCEDURE check_user_ownership();

-- TRIGGER02
-- This trigger will make users unable to make comments or reports on their own reviews.

CREATE OR REPLACE FUNCTION check_own_review() RETURNS TRIGGER AS
    $BODY$
    BEGIN
       IF EXISTS (
         SELECT *
         FROM users, Ord, Review WHERE Ord.id_Ord = Review.id_Ord AND users.id_User = Ord.id_User) THEN
          RAISE EXCEPTION 'User cannot comment on its own review.';
       END IF;
       RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_own_review
        BEFORE INSERT OR UPDATE ON Review
        FOR EACH ROW
        EXECUTE PROCEDURE check_own_review();

-- TRIGGER01 
-- This trigger will remove all user info from reviews, while mantaining the content itself, if that user is deleted from the database

CREATE OR REPLACE FUNCTION remove_user_info() RETURNS TRIGGER AS
    $BODY$
    BEGIN
           UPDATE Ord 
           SET id_User = 1 -- set this to the "anonymousUserId"
           WHERE "id_User" = Old."id_User";
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_user_info
        BEFORE DELETE ON users
        EXECUTE PROCEDURE remove_user_info();


-- TRIGGER04

-- Description
-- This trigger will make it so an order can have, at most, and amount of reviews equal to the amount of items (ABR.01)

CREATE OR REPLACE FUNCTION check_review_amount() RETURNS TRIGGER AS 
    $BODY$
    BEGIN -- can we make this better?
        IF (
            (SELECT count(*) FROM Ord WHERE id_User = reviewingUser) >= 
            (SELECT count(*) FROM Review WHERE id_ord = 
            (SELECT id_Ord FROM Ord WHERE id_User = reviewingUser))
            ) THEN
            RAISE EXCEPTION 'User cannot have more reviews than purchased items'; -- TODO: this message might need to be reviewed
        END IF;
        RETURN NEW;
    END
    $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_review_amount
    BEFORE INSERT ON Review
    FOR EACH ROW
    EXECUTE PROCEDURE check_review_amount();


        

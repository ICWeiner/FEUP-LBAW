SET search_path TO lbaw2292;

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
          FROM productOrd, product, ord WHERE productOrd.id_product = product.id_product AND productOrd.id_ord = Ord.id_ord AND productOrd.quantity > product.quantity) THEN
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

CREATE TRIGGER check_own_review
    BEFORE INSERT OR UPDATE ON review
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


        

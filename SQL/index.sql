SET search_path TO lbaw2292;

-- IDX01  It's useful for searching products of a certain product that have the price lower than a certain value defined much faster,
CREATE INDEX product_price ON product USING btree (price);  

-- IDX02  Every time we need to make a query to get the address of an user, it has to be fast, because it can be executed several times
CREATE INDEX address_iduser ON addressBook USING hash (id_user);

-- IDX03  Every time we need to make a query to get an order of any user, it has to be fast, because it can be executed several time
CREATE INDEX order_iduser ON ord USING hash (id_user); 

-- IDX11 To improve overall performance of full-text searches while searching for products by name.
CREATE INDEX search_for_product ON product USING GIST (name); -- TODO: Isto parece-me incompleto
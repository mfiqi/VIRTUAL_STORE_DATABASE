INSERT INTO PRODUCT VALUES (1030,001,'Software','Python',80);
INSERT INTO PRODUCT_IMAGES VALUES ('image1030.jpeg', 1030);
INSERT INTO BUYER VALUES (19, 'jimstew32@aol.com','111 Tree St., Spokane, WA', '645-321-9876',0);
INSERT INTO BUYER_NAME VALUES ('Jimmy', 'Stewart', 19);

DELETE FROM BUYER WHERE ID = 19;
DELETE FROM WISHLIST WHERE Buyer_ID = 19;
DELETE FROM PRODUCT WHERE ProductID = 1030;
DELETE FROM FEEDBACK WHERE Product_ID = 1030;
DELETE FROM PRODUCT_IMAGES WHERE Image = 'image1030.jpeg';
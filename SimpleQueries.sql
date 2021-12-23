-- 3.a) Create a list of IP items
-- and the stores selling those
SELECT ProductName, StoreName, ProductID, Store_ID
FROM PRODUCT AS P,
     VIRTUAL_STORE AS VS
WHERE P.StoreID = VS.Store_ID;

-- 3.b) Find the titles of all IP Items
-- that cost less than $10.
SELECT ProductName, Price, ProductID
FROM PRODUCT
WHERE Price < 10;

-- 3.c) Generate a list of IP item titles
-- and dates of purchase made by a given buyer
-- buyer.id = 1
SELECT ID, ProductName, Product_ID, year
FROM BUYER AS B,
     PRODUCT AS P,
     ORDERS AS O,
     ORDER_CONTAINS AS OC
WHERE O.BuyerID = B.ID
  AND OC.Product_ID = P.ProductID
  AND OC.Order_Number = O.OrderNumber
  AND B.ID = 1
ORDER BY ID;

-- 3.d) List all the buyers who purchased an
-- IP Item from a given store and the
-- names of the IP Items they purchased
-- storeID = 1
SELECT ID, ProductName
FROM BUYER AS B,
     VIRTUAL_STORE AS VS,
     PRODUCT AS P,
     ORDER_CONTAINS AS OC,
     ORDERS AS O
WHERE B.ID = O.BuyerID
  AND O.OrderNumber = OC.Order_Number
  AND OC.Product_ID = P.ProductID
  AND P.StoreID = VS.Store_ID
  AND VS.Store_ID = 1
ORDER BY Store_ID;

-- 3.e) Find the buyer who has purchased
-- the most IP Items and the total number
-- of IP Items they have purchased.
SELECT BuyerID, MAX(SUM) AS TOTAL
FROM (SELECT BuyerID, SUM(COUNT) AS SUM
      FROM (SELECT BuyerID, OrderNumber, COUNT
            FROM (SELECT Order_Number, COUNT(Product_ID) AS COUNT
                  FROM ORDER_CONTAINS
                  GROUP BY Order_Number) AS T,
                 ORDERS AS O
            WHERE O.OrderNumber = T.Order_Number)
      GROUP BY BuyerID);

-- 3.f) Create a list of stores who currently
-- offer 5 or less IP Items for sale
SELECT StoreID, StoreName, COUNT(StoreID) AS COUNT
FROM PRODUCT,
     VIRTUAL_STORE
WHERE VIRTUAL_STORE.Store_ID = Product.StoreID
GROUP BY StoreID
HAVING COUNT <= 5;

-- 3.g) Find the highest selling item,
-- total number of units of that item sold,
-- total dollar sales for that item,
-- and the store/seller who sells it
SELECT Product_ID, MAX(COUNT) AS COUNT, COUNT * Price AS TOTAL, StoreID
FROM (SELECT Product_ID, COUNT(*) AS COUNT
      FROM ORDER_CONTAINS
      GROUP BY Product_ID) AS Product_Count,
     PRODUCT AS P,
     VIRTUAL_STORE AS VS
WHERE Product_ID = P.ProductID
  AND VS.Store_ID = P.StoreID;

-- 3.h) Create a list of all payment types accepted,
-- number of times each of them was used,
-- and total amount charged to that type of payment.
SELECT paymentType, SUM(T2.TOTAL) AS PRICE, SUM(T2.COUNT) AS COUNT
FROM (SELECT T.paymentID, paymentType, SUM(TotalPrice) AS TOTAL, COUNT(T.paymentID) AS COUNT
      FROM (
               SELECT paymentID, TotalPrice
               FROM ORDERS AS O,
                    PAYMENT_ORDER AS PO
               WHERE O.OrderNumber = PO.orderNumber) AS T,
           PAYMENT AS P
      WHERE T.paymentID = P.paymentID
      GROUP BY T.paymentID) AS T2
GROUP BY paymentType;


-- 3.i) Retrieve the name and contact info of the customer
-- who has the highest karma point balance
SELECT Fname, Lname, Address, Phone, MAX(KarmaPoints) AS KarmaPoints
FROM BUYER AS B,
     BUYER_NAME AS BN
WHERE B.ID = BN.ID;
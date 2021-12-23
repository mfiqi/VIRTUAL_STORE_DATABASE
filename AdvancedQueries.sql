-- 5.a) Provide a list of buyer names,
-- along with the total dollar amount
-- each buyer has spent in the last year
SELECT B.ID, BN.Fname, BN.Lname, O.Year, T.sum
FROM (SELECT SUM(TotalPrice) AS sum, BuyerID FROM ORDERS group by BuyerID) AS T,
     BUYER AS B,
     ORDERS AS O,
     BUYER_NAME AS BN
WHERE O.Year = 2021
  AND B.ID = O.BuyerID
  AND T.BuyerID = B.ID
  AND B.ID = BN.ID
GROUP BY B.ID;

-- 5.b) Provide a list of buyer names
-- and e-mail addresses for buyers
-- who have spent more than the average buyer
SELECT B.ID, BN.Fname, BN.Lname, Email
FROM (SELECT BuyerID
      FROM (SELECT SUM(TotalPrice) AS sum, BuyerID FROM ORDERS group by BuyerID) AS T,
           (SELECT AVG(sum) AS a
            FROM (SELECT SUM(TotalPrice) AS sum, BuyerID
                  FROM ORDERS
                  group by BuyerID)) AS av
      WHERE T.sum > av.a
      GROUP BY BuyerID) AS T2,
     BUYER AS B,
     BUYER_NAME AS BN
WHERE T2.BuyerID = B.ID
  AND B.ID = BN.ID;

-- 5.c) Provide a list of the IP Item names
-- and associated total copies sold to all buyers,
-- sorted from the IP Item that has sold the
-- most individual copies to the IP Item that has sold the least
SELECT ProductID, ProductName, COUNT(Product_ID) AS COUNT
FROM PRODUCT AS P,
     ORDER_CONTAINS AS OC
WHERE P.ProductID = OC.Product_ID
GROUP BY P.ProductID
ORDER BY COUNT DESC;

--5.d) Provide a list of the IP Item names and
-- associated dollar totals for copies sold to all buyers,
-- sorted from the IP Item that has sold the highest dollar
-- amount to the IP Item that has sold the smallest
SELECT ProductID, ProductName, COUNT(Product_ID) * Price AS Total
FROM PRODUCT AS P,
     ORDER_CONTAINS AS OC
WHERE P.ProductID = OC.Product_ID
GROUP BY P.ProductID
ORDER BY Total DESC;

--5.e) Find the most popular seller
-- the one who has sold the most IP Items
SELECT ID
FROM (SELECT Product_ID, COUNT(*) AS MaxCount
      FROM ORDER_CONTAINS
      GROUP BY Product_ID
      ORDER BY MaxCount DESC
      LIMIT 1) AS MostPopularProduct,
     SELLER AS S,
     PRODUCT AS P,
     VIRTUAL_STORE AS VS
WHERE MostPopularProduct.Product_ID = P.ProductID
  AND P.StoreID = VS.Store_ID
  AND VS.Seller_ID = S.ID;

--5.f) Find the most profitable seller
-- (i.e. the one who has brought in the most money)
SELECT S.ID
FROM (SELECT T.Product_ID, MaxCount * Price AS MP
      FROM (SELECT Product_ID, COUNT(*) AS MaxCount, Price
            FROM ORDER_CONTAINS AS OC,
                 PRODUCT AS P
            WHERE OC.Product_ID = P.ProductID
            GROUP BY Product_ID
            ORDER BY MaxCount DESC) AS T
      ORDER BY MP DESC
      LIMIT 1) AS M,
     SELLER AS S,
     VIRTUAL_STORE AS VS,
     PRODUCT AS P
WHERE M.Product_ID = P.ProductID
  AND P.StoreID = VS.Store_ID
  AND VS.Seller_ID = S.ID;

-- 5.g) Provide a list of buyer names for buyers who purchased
-- anything listed by the most profitable seller.
SELECT B.ID, BN.Fname, BN.Lname
FROM (SELECT T.Product_ID, MaxCount * Price AS MP
      FROM (SELECT Product_ID, COUNT(*) AS MaxCount, Price
            FROM ORDER_CONTAINS AS OC,
                 PRODUCT AS P
            WHERE OC.Product_ID = P.ProductID
            GROUP BY Product_ID
            ORDER BY MaxCount DESC) AS T
      ORDER BY MP DESC
      LIMIT 1) AS M,
     BUYER AS B,
     ORDER_CONTAINS AS OC,
     BUYER_NAME AS BN,
     ORDERS AS O
WHERE M.Product_ID = OC.Product_ID
  AND OC.Order_Number = O.OrderNumber
  AND O.BuyerID = B.ID
  AND B.ID = BN.ID
GROUP BY B.ID;

-- 5.h) Provide the list of sellers who listed the IP Items
-- purchased by the buyers who have spent more than the
-- average buyer.
SELECT Id
FROM (SELECT BuyerID
      FROM (SELECT SUM(TotalPrice) AS sum, BuyerID FROM ORDERS group by BuyerID) AS T,
           (SELECT AVG(sum) AS a
            FROM (SELECT SUM(TotalPrice) AS sum, BuyerID
                  FROM ORDERS
                  group by BuyerID)) AS av
      WHERE T.sum > av.a
      GROUP BY BuyerID) AS T2,
     ORDER_CONTAINS AS OC,
     ORDERS AS O,
     VIRTUAL_STORE AS VS,
     PRODUCT AS P,
     SELLER AS S
WHERE T2.BuyerID = O.BuyerID
  AND OC.Order_Number = O.OrderNumber
  AND OC.Product_ID = P.ProductID
  AND P.StoreID = VS.Store_ID
  AND VS.Seller_ID = S.ID
GROUP BY Id;

-- 5.i) Provide sales statistics (number of items sold, highest price,
-- lowest price, and average price) for each
-- type of IP item offered by a particular store.
SELECT Type, MAX(Price) AS MAX, MIN(Price) AS MIN, AVG(Price) AS AVG, COUNT(Price) AS COUNT
FROM PRODUCT AS P
WHERE P.StoreID = 3
GROUP BY Type;
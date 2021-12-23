--a) Selects buyers and sellers who have the same email
SELECT BUYER.ID, BUYER.Email, BUYER.Address, Buyer.Phone
FROM BUYER
         LEFT OUTER JOIN SELLER
WHERE BUYER.Email = SELLER.Email;

--b) Selects the average number of karma points from all buyers.
SELECT AVG(KarmaPoints)
FROM BUYER;

--c) Number of products in a given wishlist (wishlist = 1)
SELECT COUNT(wishListID)
FROM PRODUCT_WISHLIST
WHERE wishListID = 1

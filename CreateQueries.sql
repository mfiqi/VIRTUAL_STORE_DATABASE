-- create buyer table
CREATE TABLE BUYER
(
    ID          INTEGER PRIMARY KEY,
    Email       TEXT NOT NULL,
    Address     TEXT,
    Phone       TEXT,
    KarmaPoints INTEGER
);

-- create buyer name table
CREATE TABLE BUYER_NAME
(
    Fname TEXT NOT NULL,
    Lname TEXT NOT NULL,
    ID    INTEGER,
    FOREIGN KEY (ID) REFERENCES BUYER (ID)
);

-- create seller table
CREATE TABLE SELLER
(
    ID      INTEGER PRIMARY KEY,
    Email   TEXT NOT NULL,
    Address TEXT,
    Phone   TEXT
);

-- create buyer name table
CREATE TABLE SELLER_NAME
(
    Fname TEXT NOT NULL,
    Lname TEXT NOT NULL,
    ID    INTEGER,
    FOREIGN KEY (ID) REFERENCES BUYER (ID)
);

-- create product table
CREATE TABLE PRODUCT
(
    ProductID   INTEGER PRIMARY KEY,
    StoreID     INTEGER NOT NULL,
    Type        TEXT    NOT NULL,
    ProductName TEXT,
    Price       DOUBLE,
    FOREIGN KEY (StoreID) REFERENCES VIRTUAL_STORE (Store_ID),
    FOREIGN KEY (Type) REFERENCES PRODUCT_TYPE (Name)
);

-- create product images table
CREATE TABLE PRODUCT_IMAGES
(
    image     TEXT,
    ProductID INTEGER,
    FOREIGN KEY (ProductID) REFERENCES PRODUCT (ProductID)
);

-- create order table
CREATE TABLE ORDERS
(
    OrderNumber INTEGER PRIMARY KEY,
    BuyerID     INTEGER NOT NULL,
    TotalPrice  INTEGER,
    Year        INTEGER,
    FOREIGN KEY (BuyerID) REFERENCES BUYER (ID)
);

-- create virtual store table
CREATE TABLE VIRTUAL_STORE
(
    Store_ID    INTEGER PRIMARY KEY,
    StoreName   TEXT,
    URL         TEXT,
    Seller_ID   INTEGER NOT NULL,
    SellerBio   TEXT,
    SellerPhoto TEXT,
    FOREIGN KEY (Seller_ID) REFERENCES SELLER (ID)
);

-- create product type table
CREATE TABLE PRODUCT_TYPE
(
    Name        TEXT PRIMARY KEY,
    Description TEXT
);

-- create wishlist table
CREATE TABLE WISHLIST
(
    WishList_ID INTEGER PRIMARY KEY,
    Buyer_ID    INTEGER NOT NULL,
    FOREIGN KEY (Buyer_ID) REFERENCES BUYER (ID)
);

-- create feedback table
CREATE TABLE FEEDBACK
(
    Feedback_ID INTEGER PRIMARY KEY,
    Product_ID  INTEGER NOT NULL,
    Buyer_ID    INTEGER NOT NULL,
    Comment     TEXT,
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT (ProductID),
    FOREIGN KEY (Buyer_ID) REFERENCES BUYER (ID)
);

-- create order contains table
CREATE TABLE ORDER_CONTAINS
(
    Product_ID   INTEGER NOT NULL,
    Order_Number INTEGER NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT (ProductID),
    FOREIGN KEY (Order_Number) REFERENCES ORDERS (OrderNumber)
);

--create payment table
CREATE TABLE PAYMENT
(
    paymentID   INTEGER PRIMARY KEY,
    paymentType TEXT NOT NULL
);

--create credit card table
CREATE TABLE CREDIT_CARD
(
    Card_Number INTEGER PRIMARY KEY,
    Card_EXP    TEXT NOT NULL,
    Card_Name   TEXT NOT NULL,
    paymentID   INTEGER,
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
);

--create bank account table
CREATE TABLE BANK_ACCOUNT
(
    Account_Number INTEGER PRIMARY KEY,
    paymentID      INTEGER,
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
);

--create crypto table
CREATE TABLE CRYPTO
(
    WalletNumber INTEGER PRIMARY KEY,
    Type         TEXT,
    paymentID    INTEGER,
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
);

--create karma table
CREATE TABLE KARMA
(
    KarmaPoints INTEGER,
    paymentID   INTEGER,
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
);

--create product-wishlist table
CREATE TABLE PRODUCT_WISHLIST
(
    wishListID INTEGER,
    productID  INTEGER,
    FOREIGN KEY (wishListID) REFERENCES WISHLIST (WishList_ID),
    FOREIGN KEY (productID) REFERENCES PRODUCT (ProductID)
);

--create payment-order table
CREATE TABLE PAYMENT_ORDER
(
    orderNumber INTEGER,
    paymentID   INTEGER,
    FOREIGN KEY (orderNumber) REFERENCES ORDERS (orderNumber),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
);

--create buyer-payment table
CREATE TABLE BUYER_PAYMENT
(
    buyerID   INTEGER,
    paymentID INTEGER,
    FOREIGN KEY (buyerID) REFERENCES BUYER (ID),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT (paymentID)
)
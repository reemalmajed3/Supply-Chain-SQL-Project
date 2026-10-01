-- SUPPLIERS TABLE --

CREATE TABLE Suppliers (
    SupplierID INTEGER PRIMARY KEY,
    SupplierName TEXT NOT NULL,
    Country TEXT,
    Category TEXT
);


-- SUPPLIERS TABLE DUMMY DATA --

INSERT INTO Suppliers VALUES
(104,'CATE United Catering Company Kitchen','Saudi Arabia','Catering Services'),
(105,'Zamil Steel','Saudi Arabia','Structural Steel');


-- PROJECTS TABLE --

CREATE TABLE Projects (
    ProjectID INTEGER PRIMARY KEY,
    ProjectName TEXT NOT NULL,
    Client TEXT,
    Location TEXT
);

-- PROJECTS TABLE DUMMY DATA --

INSERT INTO Projects VALUES
(1,'Jafurah Gas Development Project','Saudi Aramco','Eastern Province'),
(2,'Berri Offshore Fields','Saudi Aramco','Arabian Gulf');


-- PURCHASE REQUISITIONS TABLE --

CREATE TABLE PurchaseRequisitions (
    PR_ID INTEGER PRIMARY KEY,
    ProjectID INTEGER,
    RequestDate DATE,
    Department TEXT,
    MaterialDescription TEXT NOT NULL,
    RequestedBy TEXT,
    Status TEXT NOT NULL,

    FOREIGN KEY(ProjectID) REFERENCES Projects(ProjectID)
);

-- PURCHASE REQUISITIONS DUMMY DATA --

INSERT INTO PurchaseRequisitions VALUES
(1001,1,'2025-06-18','Procurement','Control Valves','Procurement Engineer','Approved'),
(1002,2,'2025-06-21','Procurement','Structural Steel Beams','Project Engineer','Approved'),
(1003,1,'2025-06-24','Logistics','Packing Materials','Logistics Coordinator','Pending'),
(1004,2,'2025-06-28','Procurement','Electrical Cables','Electrical Engineer','Approved');


-- PURCHASE ORDERS TABLE --

CREATE TABLE PurchaseOrders (
    PO_ID INTEGER PRIMARY KEY,
    PR_ID INTEGER,
    SupplierID INTEGER,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    Currency TEXT,
    Status TEXT,
    SABERStatus TEXT,

    FOREIGN KEY(PR_ID) REFERENCES PurchaseRequisitions(PR_ID),
    FOREIGN KEY(SupplierID) REFERENCES Suppliers(SupplierID)
);

-- PURCHASE ORDERS DUMMY DATA --

INSERT INTO PurchaseOrders VALUES
(5001,1001,104,'2025-06-19',78500,'SAR','Open','Approved'),
(5003,1003,105,'2025-06-25',18500,'SAR','In Transit','Not Required');


-- POST ORDER EXPEDITING (POSE) TABLE --

CREATE TABLE PostOrderExpediting (
    ExpeditingID INTEGER PRIMARY KEY,
    PO_ID INTEGER,
    FollowUpDate DATE,
    ExpectedDelivery DATE,
    ActualDelivery DATE,
    DeliveryStatus TEXT,
    Expeditor TEXT,
    Remarks TEXT,

    FOREIGN KEY(PO_ID) REFERENCES PurchaseOrders(PO_ID)
);

-- POST ORDER EXPEDITING (POSE) DUMMY DATA --

INSERT INTO PostOrderExpediting VALUES
(1,5001,'2025-07-02','2025-07-15',NULL,'Awaiting Shipment','POSE Team','Supplier confirmed production schedule'),
(3,5003,'2025-07-01','2025-07-12',NULL,'In Transit','POSE Team','Shipment departed origin port');


-- FREIGHT COMPANIES TABLE --

CREATE TABLE FreightCompanies (
    FreightCompanyID INTEGER PRIMARY KEY,
    CompanyName TEXT NOT NULL
);


-- FREIGHT COMPANIES DUMMY DATA --

INSERT INTO FreightCompanies VALUES
(201,'PALUMBO'),
(202,'BAGGIO'),
(203,'ISCOTRANS');


-- FREIGHT ESTIMATIONS TABLE --

CREATE TABLE FreightEstimations (
    EstimationID INTEGER PRIMARY KEY,
    ProjectID INTEGER,
    PO_ID INTEGER,
    FreightCompanyID INTEGER,
    TransportMode TEXT,
    Origin TEXT,
    Destination TEXT,
    EstimatedCost DECIMAL(10,2),
    EstimatedTransitDays INTEGER,

    FOREIGN KEY(ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY(PO_ID) REFERENCES PurchaseOrders(PO_ID),
    FOREIGN KEY(FreightCompanyID) REFERENCES FreightCompanies(FreightCompanyID)
);


-- FREIGHT ESTIMATIONS DUMMY DATA --

INSERT INTO FreightEstimations VALUES
(1,1,5001,201,'Sea','Genoa, Italy','Dammam, Saudi Arabia',18000,28),
(2,1,5003,203,'Land','Jubail, Saudi Arabia','Jafurah Project Site',4500,1);

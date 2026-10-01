-- QUERY 1 (Display all suppliers) --

SELECT *
FROM Suppliers;


-- QUERY 2 (Display all projects) --

SELECT *
FROM Projects;


-- QUERY 3 (Display all purchase requisitions) --

SELECT *
FROM PurchaseRequisitions;


-- QUERY 4 (Display all purchase orders) --

SELECT *
FROM PurchaseOrders;


-- QUERY 5 (Display all freight companies) --

SELECT *
FROM FreightCompanies;


-- QUERY 6 (Display approved purchase requisitions) --

SELECT *
FROM PurchaseRequisitions
WHERE Status = 'Approved';


-- QUERY 7 (Display purchase orders with supplier names) --

SELECT
    PO.PO_ID,
    S.SupplierName,
    PO.Amount,
    PO.Currency,
    PO.Status
FROM PurchaseOrders PO
JOIN Suppliers S
ON PO.SupplierID = S.SupplierID;


-- QUERY 8 (Display projects with their purchase requisitions) --

SELECT
    P.ProjectName,
    PR.PR_ID,
    PR.MaterialDescription,
    PR.Department,
    PR.Status
FROM Projects P
JOIN PurchaseRequisitions PR
ON P.ProjectID = PR.ProjectID;


-- QUERY 9 (Display freight information for each purchase order) --

SELECT
    FE.PO_ID,
    FC.CompanyName,
    FE.TransportMode,
    FE.Origin,
    FE.Destination,
    FE.EstimatedCost
FROM FreightEstimations FE
JOIN FreightCompanies FC
ON FE.FreightCompanyID = FC.FreightCompanyID;


-- QUERY 10 (Count the total number of purchase orders) --

SELECT
COUNT(*) AS TotalPurchaseOrders
FROM PurchaseOrders;


-- QUERY 11 (Calculate the total purchase order amount) --

SELECT
SUM(Amount) AS TotalProcurementValue
FROM PurchaseOrders;


-- QUERY 12 (Calculate the average purchase order amount) --

SELECT
AVG(Amount) AS AveragePurchaseOrderValue
FROM PurchaseOrders;


-- QUERY 13 (Display purchase orders greater than 20,000 SAR) --

SELECT
PO_ID,
Amount,
Status
FROM PurchaseOrders
WHERE Amount > 20000;


-- Query 14 (Count Purchase Requisitions by Department) --

SELECT
    Department,
    COUNT(*) AS TotalRequisitions
FROM PurchaseRequisitions
GROUP BY Department;
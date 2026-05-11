-- This script creates bronze schema tables for customer, product, and sales data if they do not already exist.
/*
=============================================================
Create Customer Table
=============================================================
Description:
    This table stores customer information for the data warehouse.
=============================================================
*/


IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'crm_cust_info' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.crm_cust_info (
        cst_id              INT,
        cst_key             VARCHAR(20),
        cst_firstname       VARCHAR(50),
        cst_lastname        VARCHAR(50),
        cst_marital_status  VARCHAR(50),
        cst_gndr            VARCHAR(50),
        cst_create_date     VARCHAR(50)
    );
END
GO

/*
=============================================================
Create Product Table
=============================================================
Description:
    This table stores product information for the data warehouse.
=============================================================
*/

IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'crm_prd_info' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.crm_prd_info (
        prd_id          INT,
        prd_key         VARCHAR(50) ,
        prd_nm          VARCHAR(100),
        prd_cost        VARCHAR(50),
        prd_line        VARCHAR(50),
        prd_start_dt    VARCHAR(50),
        prd_end_dt      VARCHAR(50)
    );
END
GO

/*
=============================================================
Create Sales Table
=============================================================
Description:
    This table stores sales transaction information
    for the data warehouse.
=============================================================
*/

IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'crm_sales_details' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.crm_sales_details (
        sls_ord_num    VARCHAR(20),
        sls_prd_key    VARCHAR(50) ,
        sls_cust_id    VARCHAR(50),
        sls_order_dt   VARCHAR(50),
        sls_ship_dt    VARCHAR(50),
        sls_due_dt     VARCHAR(50),
        sls_sales      VARCHAR(50),
        sls_quantity   VARCHAR(50),
        sls_price      VARCHAR(50)
    );
END
GO

/*
=============================================================
Create Customer Extra Info Table
=============================================================
Description:
    This table stores additional customer information
    such as birth date and gender.
=============================================================
*/

IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'erp_cust_az12' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.erp_cust_az12 (
        CID     VARCHAR(20),
        BDATE   DATE,
        GEN     VARCHAR(10)
    );
END
GO

/*
=============================================================
Create Customer Location Table
=============================================================
Description:
    This table stores customer country/location
    information for the data warehouse.
=============================================================
*/

IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'erp_loc_a101' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.erp_loc_a101 (
        CID     VARCHAR(20),
        CNTRY   VARCHAR(50)
    );
END
GO

/*
=============================================================
Create Accessories Table
=============================================================
Description:
    This table stores product accessory information including
    subcategory and maintenance requirement flag.
=============================================================
*/

IF NOT EXISTS (
    SELECT * FROM sys.tables 
    WHERE name = 'erp_px_cat_g1v2' 
    AND schema_id = SCHEMA_ID('bronze')
)
BEGIN
    CREATE TABLE bronze.erp_px_cat_g1v2 (
        ID              NVARCHAR(20),
        CATEGORY        NVARCHAR(50),
        SUBCATEGORY     NVARCHAR(100),
        MAINTENANCE     NVARCHAR(50)
    );
END
GO
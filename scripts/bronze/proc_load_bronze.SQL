/*
===============================================================================
 Bronze Layer Data Load Procedure
===============================================================================
Description:
    This stored procedure loads raw CSV data into Bronze layer tables
    for the data warehouse.

Process:
    1. Truncate existing data
    2. Load fresh data from source files
    3. Display progress messages
    4. Handle errors using TRY...CATCH
    5. Track execution time

Source Systems:
    - CRM System
    - ERP System

Usage Example:
EXEC bronze.load_bronze
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    SET NOCOUNT ON;

    -- =========================================================================
    -- Variable Declarations
    -- =========================================================================

    DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @duration_seconds INT;

    SET @start_time = GETDATE();


    BEGIN TRY

        PRINT '=====================================================';
        PRINT '           BRONZE LAYER LOAD PROCESS STARTED';
        PRINT '=====================================================';


        /*
        =======================================================================
         Load CRM Tables
        =======================================================================
        */

        PRINT ' ';
        PRINT '-------------------- CRM LOAD -----------------------';

        -- Load Customer Information
        PRINT 'Loading Customer Information...';

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\data\sql-data-warehouse\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Customer Information Loaded Successfully.';


        -- Load Product Information
        PRINT 'Loading Product Information...';

        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\data\sql-data-warehouse\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Product Information Loaded Successfully.';


        -- Load Sales Details
        PRINT 'Loading Sales Details...';

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\data\sql-data-warehouse\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Sales Details Loaded Successfully.';



        /*
        =======================================================================
         Load ERP Tables
        =======================================================================
        */

        PRINT ' ';
        PRINT '-------------------- ERP LOAD -----------------------';

        -- Load Customer Additional Information
        PRINT 'Loading Customer Additional Information...';

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\data\sql-data-warehouse\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Customer Additional Information Loaded Successfully.';


        -- Load Customer Location Information
        PRINT 'Loading Customer Location Information...';

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\data\sql-data-warehouse\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Customer Location Information Loaded Successfully.';


        -- Load Product Category Information
        PRINT 'Loading Product Category Information...';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\data\sql-data-warehouse\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Product Category Information Loaded Successfully.';


        -- =========================================================================
        -- Execution Time
        -- =========================================================================

        SET @end_time = GETDATE();

        SET @duration_seconds = DATEDIFF(SECOND, @start_time, @end_time);

        PRINT ' ';
        PRINT '=====================================================';
        PRINT '        BRONZE LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT '=====================================================';
        PRINT 'Execution Time: ' + CAST(@duration_seconds AS VARCHAR) + ' seconds';


    END TRY


    BEGIN CATCH

        PRINT ' ';
        PRINT '=====================================================';
        PRINT '               ERROR DURING DATA LOAD';
        PRINT '=====================================================';

        PRINT 'Error Number   : ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Message  : ' + ERROR_MESSAGE();
        PRINT 'Error Line     : ' + CAST(ERROR_LINE() AS VARCHAR);

    END CATCH

END;
GO
/*
====================================================================
Create Database and Schemas
====================================================================
Script Purpose:
    This script initializes the DataWarehouse database environment.

    Actions Performed:
    1. Drops the existing 'DataWarehouse' database if it exists
    2. Creates a fresh 'DataWarehouse' database
    3. Creates the following schemas:
        - bronze : Raw ingested data
        - silver : Cleaned and transformed data
        - gold   : Business-ready analytical data

WARNING:
    Executing this script will permanently delete the existing
    'DataWarehouse' database and all contained data.

    Ensure proper backups are available before execution.
====================================================================
*/

USE master;
GO

-- ============================================================
-- Drop existing database if it exists
-- ============================================================
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

-- ============================================================
-- Create database
-- ============================================================
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- ============================================================
-- Create schemas
-- ============================================================

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

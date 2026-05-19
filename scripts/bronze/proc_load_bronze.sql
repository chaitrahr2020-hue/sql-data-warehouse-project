/// need to check the inserting of data in bronze table along with logs....in office pc its not allowed...
	except that store procedure and error handling are executed successfully

/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
DELIMITER $$

CREATE PROCEDURE bronze_load_bronze()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE batch_start_time DATETIME;
    DECLARE batch_end_time DATETIME;

    -- Error Handler

-- Declare variables first
    DECLARE err_msg TEXT;

-- Declare handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 err_msg = MESSAGE_TEXT;

        SELECT '==========================================' AS msg;
        SELECT 'ERROR OCCURRED DURING LOADING BRONZE LAYER' AS msg;
        SELECT CONCAT('Error Message: ', err_msg) AS msg;
        SELECT '==========================================' AS msg;
    END;

    SET batch_start_time = NOW();

    SELECT '================================================' AS msg;
    SELECT 'Loading Bronze Layer' AS msg;
    SELECT '================================================' AS msg;

    -- ================= CRM TABLES =================
    SELECT '------------------------------------------------' AS msg;
    SELECT 'Loading CRM Tables' AS msg;
    SELECT '------------------------------------------------' AS msg;

    -- cust_info
    SET start_time = NOW();
    TRUNCATE TABLE bronze.crm_cust_info;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/cust_info.csv'
    INTO TABLE bronze.crm_cust_info
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- prd_info
    SET start_time = NOW();
    TRUNCATE TABLE bronze.crm_prd_info;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/prd_info.csv'
    INTO TABLE bronze.crm_prd_info
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- sales_details
    SET start_time = NOW();
    TRUNCATE TABLE bronze.crm_sales_details;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/sales_details.csv'
    INTO TABLE bronze.crm_sales_details
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- ================= ERP TABLES =================
    SELECT '------------------------------------------------' AS msg;
    SELECT 'Loading ERP Tables' AS msg;
    SELECT '------------------------------------------------' AS msg;

    -- loc_a101
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_loc_a101;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv'
    INTO TABLE bronze.erp_loc_a101
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- cust_az12
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_cust_az12;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv'
    INTO TABLE bronze.erp_cust_az12
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- px_cat_g1v2
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv'
    INTO TABLE bronze.erp_px_cat_g1v2
    FIELDS TERMINATED BY ','
    IGNORE 1 ROWS;

    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- ================= FINAL =================
    SET batch_end_time = NOW();

    SELECT '==========================================' AS msg;
    SELECT 'Loading Bronze Layer is Completed' AS msg;
    SELECT CONCAT('Total Load Duration: ',
           TIMESTAMPDIFF(SECOND, batch_start_time, batch_end_time),
           ' seconds') AS msg;
    SELECT '==========================================' AS msg;

END$$

DELIMITER ;

/*
=============================================================
Create Database and Schemas 
=============================================================

Script Purpose:
This script creates a new database named 'DataWarehouse'.
If it already exists, it is dropped and recreated.

Additionally, it creates three logical layers:
'bronze', 'silver', and 'gold' as separate databases.

WARNING:
Running this script will drop the entire 'DataWarehouse'
and related databases if they exist. All data will be permanently deleted.
Proceed with caution.
*/

-- Drop databases if they exist
DROP DATABASE IF EXISTS DataWarehouse;
DROP DATABASE IF EXISTS bronze;
DROP DATABASE IF EXISTS silver;
DROP DATABASE IF EXISTS gold;

-- Create main database
CREATE DATABASE DataWarehouse;

-- Create layer databases (equivalent to schemas)
CREATE DATABASE bronze;
CREATE DATABASE silver;
CREATE DATABASE gold;

-- Use main database
USE DataWarehouse;


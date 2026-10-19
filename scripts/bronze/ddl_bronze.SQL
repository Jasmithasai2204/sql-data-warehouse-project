CREATE OR ALTER PROCEDURE bronze.load_bronze AS
 BEGIN
  DECLARE @start_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME, @end_time DATETIME;
  BEGIN TRY
        SET @batch_start_time = GETDATE();
		Print '==============================';
		PRINT 'Loading the Bronze Layer';
		Print '==============================';


		Print '------------------------------'
		PRINT 'Loading CRM Tables'
		Print '------------------------------'

		SET @start_time = GETDATE();
        

		print '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		print '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.crm_cust_info;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';


		 SET @start_time = GETDATE();
        
		print '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		print '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.crm_prd_info;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';


		 SET @start_time = GETDATE();
        
		print '>> Truncating Table: bronze.crm_sales_info';
		TRUNCATE TABLE bronze.crm_sales_details;

		print '>> Inserting Data Into: bronze.crm_sales_info';
		BULK INSERT bronze.crm_sales_details
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.crm_sales_details;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';

		Print'-----------------------------';
		print'Loading the ERP Tables';
		Print'-----------------------------';

		SET @start_time = GETDATE();
        
		print '>> Truncating Table:  bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		print '>> Inserting Data Into:  bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.erp_CUST_AZ12;
		SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';

		 SET @start_time = GETDATE();
        
		print '>> Truncating Table:  bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;

		print '>> Inserting Data Into: bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.erp_LOC_A101;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';

		 SET @start_time = GETDATE();
        

		print '>> Truncating Table: bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		print '>> Inserting Data Into: bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		from 'D:\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT count(*) FROM bronze.erp_PX_CAT_G1V2;
 		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';

		  SET @batch_end_time = GETDATE();
		  PRINT '>> Total Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR(20)) + ' seconds';
  END TRY
  BEGIN CATCH 
      PRINT '=================================='
	  PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	  PRINT 'Error Message' + ERROR_MESSAGE();
	  PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	         PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	  PRINT '=================================='
  END CATCH
END

exec bronze.load_bronze

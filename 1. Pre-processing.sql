/****** Daily Energy Dataset ******/

SELECT top(5) * 
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 

/* Checking the count of all Household Ids */
SELECT (count(distinct [LCLid])) as Daily_dataset_LCLid_count
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 

/* Removing information of all Household Ids that do not start with MAC */
DELETE FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
WHERE [LCLid] NOT LIKE 'MAC%'

/* Checking the count of all Household Ids after removing false values */
SELECT (count(distinct [LCLid])) as Daily_dataset_LCLid_count
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
WHERE [LCLid] LIKE 'MAC%'

/* Checking duration in which energy consumption has been made by households */
SELECT  top(1)[day] as Duration_From
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
order by [day] asc

SELECT  top(1)[day] as Duration_To
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
order by [day] Desc

/****** Half Hourly Energy Dataset *******/

SELECT top(5) *
FROM [SmartMeter].[dbo].[Energy_HHblock-dataset]

/* Checking the count of all Household Ids */
SELECT (count(distinct [LCLid])) as Half_hourly_dataset_LCLid_count
FROM [SmartMeter].[dbo].[Energy_HHblock-dataset] 

/* Removing information of all Household Ids that do not start with MAC */
DELETE FROM [SmartMeter].[dbo].[Energy_HHblock-dataset] 
WHERE [LCLid] NOT LIKE 'MAC%'

/* Checking the count of all Household Ids after removing false values */
SELECT (count(distinct [LCLid])) as Half_hourly_dataset_LCLid_count
FROM [SmartMeter].[dbo].[Energy_HHblock-dataset] 
WHERE [LCLid] LIKE 'MAC%'

/* Finding Household Ids for which we do not have Hourly information */

select Unique_LCLid
from (select distinct [LCLid] as Unique_LCLid  from [SmartMeter].[dbo].[Energy_Daily_dataset]
union all 
select distinct [LCLid]  from [SmartMeter].[dbo].[Energy_HHblock-dataset]) foo
group by Unique_LCLid
having count(*) = 1

/* Checking if any Household Id has null/empty values for energy */
SELECT count([LCLid]) as Households_with_missing_energy_values
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
WHERE [energy_std]  = ' ' 
or energy_median = ' ' 
or energy_mean = ' '
or energy_max = ' '
or energy_count = ' '
or energy_sum = ' '
or energy_min = ' '

/* Deleting information of Households that has null/empty values for energy */
Delete FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
WHERE [energy_std]  = ' ' 
or energy_median = ' ' 
or energy_mean = ' '
or energy_max = ' '
or energy_count = ' '
or energy_sum = ' '
or energy_min = ' '

/* Veryfing if any Household Id has null/empty values for energy */
SELECT count([LCLid]) as Households_with_missing_energy_values
FROM [SmartMeter].[dbo].[Energy_Daily_dataset] 
WHERE [energy_std]  = ' ' 
or energy_median = ' ' 
or energy_mean = ' '
or energy_max = ' '
or energy_count = ' '
or energy_sum = ' '
or energy_min = ' '


/****** Households Information Dataset ******/

SELECT top(5) *
FROM [SmartMeter].[dbo].[Informations_households]

/* Finding unique Acorn categories in which each household falls */
SELECT distinct [Acorn] as Acorn_categories
FROM [SmartMeter].[dbo].[Informations_households] 
order by [Acorn] asc

/* Finding unique Acorn groups in which each household falls */
SELECT distinct [Acorn_grouped] as Acorn_groups
FROM [SmartMeter].[dbo].[Informations_households] 
order by [Acorn_grouped] asc

/* Deleting information for households that fall under inavlid acorn category and group */
DELETE
FROM [SmartMeter].[dbo].[Informations_households] 
WHERE [Acorn] not in ('ACORN-A','ACORN-B','ACORN-C','ACORN-D','ACORN-E','ACORN-F','ACORN-G','ACORN-H','ACORN-I','ACORN-J','ACORN-K','ACORN-L','ACORN-M','ACORN-N','ACORN-O','ACORN-P','ACORN-Q')

DELETE 
FROM [SmartMeter].[dbo].[Informations_households] 
WHERE [Acorn_grouped]  not in ('Affluent', 'Comfortable', 'Adversity')

/* Veryfing if no household has any tarfiff apart from Std and ToU */
SELECT distinct [stdorToU] as Tariffs
FROM [SmartMeter].[dbo].[Informations_households] 
order by [stdorToU] asc

/* Number of households with Std tariff and ToU tariff */
SELECT count([stdorToU]) as Households_with_Std_tariff
FROM [SmartMeter].[dbo].[Informations_households]
where [stdorToU] = 'std'

SELECT count([stdorToU]) as Households_with_ToU_tariff
FROM [SmartMeter].[dbo].[Informations_households]
where [stdorToU] = 'tou'


/****** UK Bank holidays Dataset ******/

SELECT  *
FROM [SmartMeter].[dbo].[UK_bank_holidays]
ORDER BY [Bank holidays] ASC

/* Finding unique UK Bank Holidays*/
SELECT [Type]  ,count([Bank holidays]) as Number_of_days 
FROM [SmartMeter].[dbo].[UK_bank_holidays] 
group by [Type] 

/****** Acorn Dataset ******/

SELECT top(5) *
FROM [SmartMeter].[dbo].[Acorn_details]

/* Finding unique categories for Acorn groups*/
SELECT DISTINCT [CATEGORIES]
FROM [SmartMeter].[dbo].[Acorn_details]

/* Finding unique Main categories for Acorn groups*/
SELECT DISTINCT [MAIN CATEGORIES]
FROM [SmartMeter].[dbo].[Acorn_details]

/****** Weather Dataset ******/

SELECT top(5) *
FROM [SmartMeter].[dbo].[Weather_daily_darksky] 

/* Finding if any column has null values and replacing it with zero / default */
SELECT *
FROM [SmartMeter].[dbo].[Weather_daily_darksky] 
WHERE temperatureMax IS NULL or temperatureMaxTime IS NULL or windBearing  IS NULL or    
icon IS NULL or dewPoint IS NULL or temperatureMinTime IS NULL or cloudCover IS NULL or windSpeed IS NULL or          
pressure IS NULL or apparentTemperatureMinTime IS NULL or apparentTemperatureHigh IS NULL or precipType IS NULL or      
visibility IS NULL or humidity IS NULL or apparentTemperatureHighTime IS NULL or 
apparentTemperatureLow IS NULL or apparentTemperatureMax IS NULL or uvIndex IS NULL or 
[time] IS NULL or sunsetTime IS NULL or temperatureLow IS NULL or temperatureMin IS NULL or temperatureHigh IS NULL or 
sunriseTime IS NULL or temperatureHighTime IS NULL or uvIndexTime IS NULL or summary IS NULL or 
temperatureLowTime IS NULL or apparentTemperatureMin IS NULL or apparentTemperatureMaxTime IS NULL or 
apparentTemperatureLowTime IS NULL or moonPhase IS NULL  


UPDATE [SmartMeter].[dbo].[Weather_daily_darksky] 
SET cloudCover = 0, uvIndex = 0, uvIndexTime = '2014-01-01 00:00:00.000'
WHERE ( temperatureMax IS NULL or temperatureMaxTime IS NULL or windBearing  IS NULL or    
icon IS NULL or dewPoint IS NULL or temperatureMinTime IS NULL or cloudCover IS NULL or windSpeed IS NULL or          
pressure IS NULL or apparentTemperatureMinTime IS NULL or apparentTemperatureHigh IS NULL or precipType IS NULL or      
visibility IS NULL or humidity IS NULL or apparentTemperatureHighTime IS NULL or 
apparentTemperatureLow IS NULL or apparentTemperatureMax IS NULL or uvIndex IS NULL or 
[time] IS NULL or sunsetTime IS NULL or temperatureLow IS NULL or temperatureMin IS NULL or temperatureHigh IS NULL or 
sunriseTime IS NULL or temperatureHighTime IS NULL or uvIndexTime IS NULL or summary IS NULL or 
temperatureLowTime IS NULL or apparentTemperatureMin IS NULL or apparentTemperatureMaxTime IS NULL or 
apparentTemperatureLowTime IS NULL or moonPhase IS NULL  )


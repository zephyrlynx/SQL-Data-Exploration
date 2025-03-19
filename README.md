Steps to use 

1. Check is the files are in csv format or not (must be in csv format)
2. Open SSMS (SQL Server Management Studio)( I, personally use this one)
3. Copy the files CovidDeaths and CovidVaccination
4. Open SSMS connect it to the Database
5. Create a new database (name of your choice)/ Or select an existing one
6. Add the Csv file in data base (if new follow the bellow steps)
7. Click on DB > Task > Import Data > Next > Data Source: Flat file source > Select CSV file(make sure you have the excel file as a csv)
> Next > Next > Destination: Microsoft OLE DB Driver for SQL Server > Click On Properties and Enter the Server name, change
to Windows Authentication, Select your Database name and test connection > Next > Next > Finish
8. You find your own insights or use mine SQl file to see the insights I found
9. Insights that I found - Country with highest no of cases
                         - Country with highest death and death ratio to their population
                         - Contitnent with highest infected
                         - Vaccination given by the countries (per day and total) etc 

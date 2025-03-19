--Select *
--From CovidDeaths
--Order by 3, 4

--Select * 
--From CovidVaccinations
--Order by 3, 4 

-- Data that i will be using
Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Order by 1,2 

-- those 2 cols were Varchar datatype and we cannot perform division on it
--ALTER TABLE CovidDeaths
--ALTER COLUMN total_deaths FLOAT;

--ALTER TABLE CovidDeaths
--ALTER COLUMN total_cases FLOAT;

-- Checking the data for India
-- Total Cases vs Total Deaths
--Select Location, date, total_cases, total_deaths, (total_deaths / NULLIF((total_cases), 0)) * 100 AS DeathRate
--From CovidDeaths
--Where location like '%India%'
--Order by 1,2 


-- countries with highest infection rate as compared to their population
SELECT 
    Location, 
    population, 
    MAX(CAST(total_cases AS BIGINT)) AS HighestInfectionCount,
    MAX(total_cases / NULLIF(CAST(population AS FLOAT), 0)) * 100 AS PopulationInfected
FROM CovidDeaths
Where continent is not null
GROUP BY Location, population
ORDER BY PopulationInfected Desc


-- Country with highest death ratio
-- we will not cosider continent as they are made up of countries
SELECT 
    Location, 
    MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
FROM CovidDeaths
-- Where continent is not Null
-- as in my data set the continent have empty space instead of null
WHERE TRIM(continent) <> ''
GROUP BY Location
ORDER BY HighestDeathCount Desc


-- Continent With highest Death
SELECT 
    location, 
    MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
FROM CovidDeaths
WHERE TRIM(continent) = ''
GROUP BY location
ORDER BY HighestDeathCount Desc


/* Using both tables for more insights */
Select *
From CovidDeaths as dea
Join CovidVaccinations as vac
	On dea.location = vac.location
	And dea.date = vac.date


-- total no of peoplevacc per day vs the population 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(Cast(vac.new_vaccinations as int)) Over (partition by dea.location Order by dea.location, dea.date)
From CovidDeaths as dea
Join CovidVaccinations as vac
	On dea.location = vac.location
	And dea.date = vac.date
Where Trim(dea.continent) <> ''
Order by 1, 2, 3


-- Using CTE 
With PopvsVac (continent, Location, Date, Population, New_Vac, PeepVac)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(Cast(vac.new_vaccinations as int)) Over (partition by dea.location Order by dea.location, dea.date) as PeepVac
From CovidDeaths as dea
Join CovidVaccinations as vac
	On dea.location = vac.location
	And dea.date = vac.date
Where Trim(dea.continent) <> ''
--Order by 1, 2, 3
)

SELECT *, 
       (PeepVac /  NULLIF(CAST(Population AS FLOAT), 0))  * 100 AS VaccinationRate
FROM PopvsVac



-- Creating View to store data for later visualization
Create view CountryWithHighestDeathRate as
SELECT 
    Location, 
    MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
FROM CovidDeaths
-- Where continent is not Null
-- as in my data set the continent have empty space instead of null
WHERE TRIM(continent) <> ''
GROUP BY Location
--ORDER BY HighestDeathCount Desc


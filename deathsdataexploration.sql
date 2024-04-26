-- Covid 19 Data Exploration

SELECT *
FROM coviddeaths;
-- where continent is null;

SELECT *
FROM covidvaccinations2;

SELECT location, report_date, total_cases, new_cases,total_deaths,population
FROM coviddeaths
-- where continent='Africa'
order by 1,2;

-- total cases vs total deaths
-- shows the death probability if one contracts covid
SELECT continent, location, SUM(total_cases) AS total_cases, SUM(total_deaths) AS total_deaths, 
(SUM(total_deaths)/SUM(total_cases))*100 AS death_rate
FROM coviddeaths
where continent is not null
GROUP BY continent, location
ORDER BY death_rate DESC;

-- what percentage of the population was infected with Covid
SELECT location, population, sum(new_cases) as total_cases,concat(sum(new_cases)/population*100,"%") AS infection_rate
FROM coviddeaths
where continent is not null
GROUP BY location, population
ORDER BY SUM(new_cases)/population desc;


-- Countries with the highest rate of infection rate compared to population
SELECT location, population,max(total_cases) as highest_infection_count, concat(max((total_cases/population)*100 ),"%")as infection_rate
FROM coviddeaths
group by location, population
order by max(total_cases/population) desc;

-- countries with the highest count

select location ,population, sum(new_deaths) as total_deaths ,
concat(round(sum(new_deaths)/population*100,2),"%") as Death_percent
from coviddeaths 
where continent != location
group by location , population 
order by Death_percent desc;

-- BREAKING THINGS DOWN BY CONTINENT
-- death count per continent
SELECT continent,sum(population) as total_population, sum(total_deaths) as total_death_count
FROM coviddeaths
group by continent
order by total_death_count desc;

-- GLOBAL NUMBERS
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
FROM coviddeaths
where continent is not null
order by 1,2;

-- Total Population vs Vaccinations

SELECT *
FROM coviddeaths AS dea
RIGHT JOIN covidvaccinations2 AS vac
ON dea.location=vac.location
order by 1,2;



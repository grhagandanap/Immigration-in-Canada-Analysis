
-- Raw Data

SELECT * FROM [Portofolio Data Analytics]..canadaCitizenship$

-- Data Preparation 

USE [Portofolio Data Analytics]

CREATE VIEW vCanada2 AS 
(SELECT Coverage, OdName , AreaName, RegName, DevName, Year, NumOfImm
FROM canadaCitizenship$
UNPIVOT
(
	NumOfImm for Year IN ([1980],[1981],[1982],[1983],[1984],[1985],[1986],[1987],[1988],[1989]
	,[1990],[1991],[1992],[1993],[1994],[1995],[1996],[1997],[1998],[1999]
	,[2000],[2001],[2002],[2003],[2004],[2005],[2006],[2007],[2008],[2009]
	,[2010],[2011],[2012],[2013])
) imm
WHERE RegName <> 'World' AND Coverage = 'Foreigners') 

SELECT * FROM vCanada

SELECT OdName, AreaName, RegName, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY OdName, AreaName, RegName
ORDER BY SUM(NumOfImm) DESC

SELECT AreaName, RegName, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY AreaName, RegName
ORDER BY SUM(NumOfImm) DESC

SELECT AreaName, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY AreaName
ORDER BY SUM(NumOfImm) DESC

-- Average Immigrant Per Year

SELECT AVG(y.TotImm) FROM (
	SELECT SUM(NumOfImm) TotImm 
	FROM vCanada
	WHERE Coverage = 'Foreigners'
	GROUP BY YEAR) y

-- Average Immigrant Per Area

SELECT AreaName, YEAR, AVG(NumOfImm) AveImm 
FROM vCanada 
WHERE AreaName <> 'World' AND Coverage = 'Foreigners'
GROUP BY AreaName, YEAR
ORDER BY YEAR, AveImm DESC

-- TOP 10 Year with Highest Immigrants

SELECT TOP 10 Year, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY YEAR
ORDER BY SUM(NumOfImm) DESC

-- TOP 10 Countries of Highest Immigrants

SELECT TOP 10 OdName, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY OdName
ORDER BY TotImm DESC

-- 10 Countries with Lowest Immigrants

SELECT TOP 10 OdName, SUM(NumOfImm) TotImm FROM vCanada
WHERE RegName <> 'World' AND Coverage = 'Foreigners'
GROUP BY OdName
ORDER BY TotImm 



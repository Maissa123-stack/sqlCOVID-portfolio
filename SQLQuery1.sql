Select * 
From  [sql portfolio]..['final_fichier logs_apr�s traite$']

/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Select *
From [sql portfolio]..['final_fichier logs_apr�s traite$']
Where [Start date] is not null 
order by 1,2


-- Select Data that we are going to be starting with

Select [entry mode] , [Start date], Actor, COVID, [End date], Task, [patient id]
From [sql portfolio]..['final_fichier logs_apr�s traite$']
Where [Start date] is not null
order by 3,4


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select [entry mode] , [Start date], [Actor], [COVID] as [total cases] , [End date], Task, [patient id]
From [sql portfolio]..['final_fichier logs_apr�s traite$']
Where [entry mode] like '%SAMU%'
and [Start date] is not null
order by 1,2

SELECT *
FROM [sql portfolio]..['final_fichier logs_apr�s traite$']
WHERE [COVID] = 'positive';

--S�lectionner les enregistrements avec une plage de dates sp�cifique
Select *
From [sql portfolio]..['final_fichier logs_apr�s traite$']
Where [Start date] >= '2020-01-01' AND [End date] <= '2020-12-31';

--S�lectionner les enregistrements avec des acteurs sp�cifiques
Select *
From [sql portfolio]..['final_fichier logs_apr�s traite$']
Where [Actor] IN ('interne' , 'resident' )  AND [Start date] is not null ;

--S�lectionner les enregistrements avec des cas COVID positifs tri�s
--par ordre d�croissant du nombre total de cas :
 Select [patient id], [COVID] as [total cases]
 From [sql portfolio]..['final_fichier logs_apr�s traite$']
 Where COVID like 'positive'
 Order by [total cases] DESC ;
 --S�lectionner les enregistrements avec des acteurs sp�cifiques et une plage de dates donn�e :
 Select * 
 From [sql portfolio]..['final_fichier logs_apr�s traite$']
 Where [Actor] like '%professeur%' And(  [Start date]>= '2020-03-03' AND [End date] <= '2020-12-31');

 Select * 
 From [sql portfolio]..['final_fichier logs_apr�s traite$']
 Where [Actor] IN ('professeur', 'interne') 
 And [Start date]>= '2020-03-03' 
 AND [End date] <= '2020-12-31';

 ---S�lectionner les enregistrements avec des cas COVID n�gatifs et un identifiant de patient unique 
  Select * 
 From [sql portfolio]..['final_fichier logs_apr�s traite$']
 Where COVID like '%negative%'
 And [patient id] is not null; 

 -- Select the top 5 actors with the highest total COVID cases:
 
SELECT TOP 5 [Actor], SUM(CAST([COVID] AS INT)) AS [Total Cases]
FROM [sql portfolio]..['final_fichier logs_apr�s traite$']
GROUP BY [Actor]
ORDER BY [Total Cases] DESC;

--Select the actors who have handled multiple tasks and their corresponding task count
SELECT [Actor], COUNT(DISTINCT [Task]) AS [Task Count]
FROM [sql portfolio]..['final_fichier logs_apr�s traite$']
GROUP BY [Actor]
HAVING COUNT(DISTINCT [Task]) > 1;

--Select the actors who have been active for a specific duration and their start and end dates:
--this query groups the actors, retrieves their earliest start date and latest end date,
--and selects only those actors who have been active for a duration of 30 days or more.
SELECT [Actor], MIN([Start date]) AS [Earliest Start Date], MAX([End date]) AS [Latest End Date]
FROM [sql portfolio]..['final_fichier logs_apr�s traite$']
GROUP BY [Actor]
HAVING DATEDIFF(DAY, MIN([Start date]), MAX([End date])) >= 30;

---Select the entry modes along with the percentage of positive COVID cases for each mode:
SELECT [entry mode],
  (COUNT(CASE WHEN [COVID] = 'positive' THEN 1 END) * 100.0 / COUNT(*)) AS [Positive Percentage]
FROM [sql portfolio]..['final_fichier logs_apr�s traite$']
GROUP BY [entry mode];









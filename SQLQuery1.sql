Select * 
From  [sql portfolio]..['final_fichier logs_aprés traite$']

/*
Covid 19 Data Exploration 



*/

Select *
From [sql portfolio]..['final_fichier logs_aprés traite$']
Where [Start date] is not null 
order by 1,2




Select [entry mode] , [Start date], Actor, COVID, [End date], Task, [patient id]
From [sql portfolio]..['final_fichier logs_aprés traite$']
Where [Start date] is not null
order by 3,4




Select [entry mode] , [Start date], [Actor], [COVID] as [total cases] , [End date], Task, [patient id]
From [sql portfolio]..['final_fichier logs_aprés traite$']
Where [entry mode] like '%SAMU%'
and [Start date] is not null
order by 1,2

SELECT *
FROM [sql portfolio]..['final_fichier logs_aprés traite$']
WHERE [COVID] = 'positive';

--Sélectionner les enregistrements avec une plage de dates spécifique
Select *
From [sql portfolio]..['final_fichier logs_aprés traite$']
Where [Start date] >= '2020-01-01' AND [End date] <= '2020-12-31';

--Sélectionner les enregistrements avec des acteurs spécifiques
Select *
From [sql portfolio]..['final_fichier logs_aprés traite$']
Where [Actor] IN ('interne' , 'resident' )  AND [Start date] is not null ;

--Sélectionner les enregistrements avec des cas COVID positifs triés
--par ordre décroissant du nombre total de cas :
 Select [patient id], [COVID] as [total cases]
 From [sql portfolio]..['final_fichier logs_aprés traite$']
 Where COVID like 'positive'
 Order by [total cases] DESC ;
 --Sélectionner les enregistrements avec des acteurs spécifiques et une plage de dates donnée :
 Select * 
 From [sql portfolio]..['final_fichier logs_aprés traite$']
 Where [Actor] like '%professeur%' And(  [Start date]>= '2020-03-03' AND [End date] <= '2020-12-31');

 Select * 
 From [sql portfolio]..['final_fichier logs_aprés traite$']
 Where [Actor] IN ('professeur', 'interne') 
 And [Start date]>= '2020-03-03' 
 AND [End date] <= '2020-12-31';

 ---Sélectionner les enregistrements avec des cas COVID négatifs et un identifiant de patient unique 
  Select * 
 From [sql portfolio]..['final_fichier logs_aprés traite$']
 Where COVID like '%negative%'
 And [patient id] is not null; 

 -- Select the top 5 actors with the highest total COVID cases:
 
SELECT TOP 5 [Actor], SUM(CAST([COVID] AS INT)) AS [Total Cases]
FROM [sql portfolio]..['final_fichier logs_aprés traite$']
GROUP BY [Actor]
ORDER BY [Total Cases] DESC;

--Select the actors who have handled multiple tasks and their corresponding task count
SELECT [Actor], COUNT(DISTINCT [Task]) AS [Task Count]
FROM [sql portfolio]..['final_fichier logs_aprés traite$']
GROUP BY [Actor]
HAVING COUNT(DISTINCT [Task]) > 1;

--Select the actors who have been active for a specific duration and their start and end dates:
--this query groups the actors, retrieves their earliest start date and latest end date,
--and selects only those actors who have been active for a duration of 30 days or more.
SELECT [Actor], MIN([Start date]) AS [Earliest Start Date], MAX([End date]) AS [Latest End Date]
FROM [sql portfolio]..['final_fichier logs_aprés traite$']
GROUP BY [Actor]
HAVING DATEDIFF(DAY, MIN([Start date]), MAX([End date])) >= 30;

---Select the entry modes along with the percentage of positive COVID cases for each mode:
SELECT [entry mode],
  (COUNT(CASE WHEN [COVID] = 'positive' THEN 1 END) * 100.0 / COUNT(*)) AS [Positive Percentage]
FROM [sql portfolio]..['final_fichier logs_aprés traite$']
GROUP BY [entry mode];









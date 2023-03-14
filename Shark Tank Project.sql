SELECT * FROM [Shark Tank dataset]
ORDER BY [Pitch Number]

/*NO.OF SEASONS*/

SELECT COUNT(DISTINCT([Season Number])) FROM [Shark Tank dataset]

/* NO. OF CONTESTANTS*/

SELECT COUNT(DISTINCT([Startup Name])) FROM [Shark Tank dataset]

/*POPULATION OF EACH GENDER*/

SELECT
	COUNT(case when [Pitchers Gender]='Male' then 1 end) as Males,
	COUNT(case when [Pitchers Gender]='Female' then 1 end) as Females
FROM [Shark Tank dataset]

/*GENDER RATIO*/????????????????????????????????????????????????????????????????????????????????????????//

SELECT 
[Gender Ratio] = (SELECT SUM(CAST([Pitchers Gender]) AS FLOAT) FROM [Shark Tank dataset]
WHERE [Pitchers Gender] = 'Female')/(SELECT CAST(SUM([Pitchers Gender]) AS FLOAT) FROM [Shark Tank dataset]
WHERE [Pitchers Gender] = 'Male')
FROM [Shark Tank dataset]

/*NO. OF CONTESTANTS THAT GOT THE DEAL*/

SELECT 
	COUNT(case when [Pitchers Gender] = 'female' then 1 end) AS [Female Deals],
	COUNT(case when [Pitchers Gender] = 'male' then 1 end) AS [Male Deals],
	COUNT(case when [Pitchers Gender] = 'Mixed Team' then 1 end) AS [Mixed Deals],
	COUNT (*) AS [Total Deals]
FROM [Shark Tank dataset]
WHERE [Shark Tank dataset].[Got Deal] = 1 

/* SUCCESS RATE OF GETTING THE DEAL*/

SELECT 
    COUNT(case when [Got Deal] = 1 then 1 end) AS Got_Grant,
    COUNT([Startup Name]) AS Total_Contestants,
    COUNT(case when [Got Deal] = 1 then 1 end)* 100.0 / COUNT([Startup Name]) AS Success_Rate_Percentage
FROM 
    [Shark Tank dataset]


/*TYPES OF INDUSTRIES*/

SELECT DISTINCT(Industry) AS [Type Of Industry]
FROM [Shark Tank dataset]

SELECT 
Industry, 
SUM([Got Deal]) AS [No.Of Deals] 
FROM [Shark Tank dataset]
WHERE [Got Deal] = 1
GROUP BY Industry 
ORDER BY [No.Of Deals]

/*SEASON WITH THE MOST GOT DEALS*/

SELECT 
[Season Number], 
SUM([Got Deal]) AS [No.Of Deals] 
FROM [Shark Tank dataset]
WHERE [Got Deal] = 1
GROUP BY [Season Number]
ORDER BY [No.Of Deals] desc

/*SEASON WITH THE MOST NUMBER OF NO DEALS*/

SELECT 
[Season Number],
SUM(b.no_count) AS no_count
FROM
(
	SELECT 
	CASE WHEN [got deal] <1 then 1 else 0 end as no_count,
	a.* 
		FROM
		(
			(SELECT
				* 
			FROM [Shark Tank dataset]
			WHERE [Got Deal] < 1
			)
		)a
)b
GROUP BY [Season Number] 
ORDER BY no_count desc


/*MAX AND MIN ASK AMOUNT*/

SELECT 
MAX([Original Ask Amount]) AS [MAX AMOUNT],
MIN([Original Ask Amount]) AS [MIN AMOUNT]
FROM [Shark Tank dataset]


/* EPISODES WHERE THERE WERE GUEST JUDGES*/

SELECT 
COUNT([Pitch Number])
FROM [Shark Tank dataset] 
WHERE [Guest Name] IS NOT NULL

SELECT 
[Guest Name],
SUM(CAST([Guest Investment Amount] AS FLOAT))
FROM [Shark Tank dataset] 
WHERE [Guest Name] IS NOT NULL AND [Guest Investment Amount] IS NOT NULL 
GROUP BY [Guest Investment Amount], [Guest Name]
ORDER BY [Guest Name]



/* TOTAL AMOUNT INVESTED BY SHARKS*/

SELECT
Invested_Amt = SUM([Investment Amount Per Shark]*[Number of sharks in deal])
FROM [Shark Tank dataset]


SELECT
[Season Number],
[Startup Name],
Invested_Amt = SUM([Investment Amount Per Shark]*[Number of sharks in deal])
FROM [Shark Tank dataset]
WHERE [Got Deal] = 1
GROUP BY 
[Season Number],
[Startup Name]
ORDER BY [Season Number]

/*NO.OF ROYALTY DEALS*/

SELECT * FROM [Shark Tank dataset]
WHERE [Royalty Deal] = 1

/*NO. THAT HAD ALL SHARKS IN THE DEAL*/

SELECT * FROM [Shark Tank dataset]
WHERE [Number of sharks in deal] = 5

/* AVG ASK AMOUNT */

SELECT 
Average_ask_amount = AVG([Original Ask Amount])
FROM [Shark Tank dataset]

/* AVG INVESTED AMOUNT*/

SELECT
Average_Invested_Amount = AVG([Total Deal Amount])
FROM [Shark Tank dataset]
WHERE ([Got Deal]) = 1

/* LOCATION WITH MOST NO. OF CONTESTANTS*/

SELECT
DISTINCT([Pitchers State]),
COUNT([Pitchers State]) AS State_Count
FROM [Shark Tank dataset]
GROUP BY [Pitchers State]
ORDER BY State_Count


/* DEALS TAKEN BY EACH SHARK*/

SELECT
a.Shark,
a.[Deals Present],
b.[Deals Taken],
c.[Total Investment],
d.[Average Investment Equity]
FROM
(
SELECT
'Barbara Corcoran' AS Shark,
COUNT([Barbara Corcoran Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Barbara Corcoran Present] = 1
)a
INNER JOIN
(
SELECT
'Barbara Corcoran' AS Shark,
COUNT([Barbara Corcoran Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Barbara Corcoran Investment Amount] IS NOT NULL
)b

ON a.Shark = b.Shark

INNER JOIN
(
SELECT
'Barbara Corcoran' AS Shark,
SUM([Barbara Corcoran Investment Amount]) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Barbara Corcoran Investment Amount] IS NOT NULL
) c

ON a.Shark = c.Shark

INNER JOIN
(
SELECT 
'Barbara Corcoran' AS Shark,
AVG([Barbara Corcoran Investment Equity]) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Barbara Corcoran Investment Equity] IS NOT NULL
)d

ON a.Shark = d.Shark

UNION ALL
SELECT
e.Shark,
e.[Deals Present],
f.[Deals Taken],
g.[Total Investment],
h.[Average Investment Equity]
FROM
(
SELECT
'Mark Cuban' AS Shark,
COUNT([Mark Cuban Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Mark Cuban Present] = 1
)e
INNER JOIN
(
SELECT
'Mark Cuban' AS Shark,
COUNT([Mark Cuban Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Mark Cuban Investment Amount] IS NOT NULL
)f

ON e.Shark = f.Shark

INNER JOIN
(
SELECT
'Mark Cuban' AS Shark,
SUM([Mark Cuban Investment Amount]) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Mark Cuban Investment Amount] IS NOT NULL
) g

ON e.Shark = g.Shark

INNER JOIN
(
SELECT 
'Mark Cuban' AS Shark,
AVG([Mark Cuban Investment Equity]) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Mark Cuban Investment Equity] IS NOT NULL
)h

ON e.Shark = h.Shark

UNION ALL

SELECT
i.Shark,
i.[Deals Present],
j.[Deals Taken],
k.[Total Investment],
l.[Average Investment Equity]
FROM
(
SELECT
'Lori Greiner' AS Shark,
COUNT([Lori Greiner Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Lori Greiner Present] = 1
)i
INNER JOIN
(
SELECT
'Lori Greiner' AS Shark,
COUNT([Lori Greiner Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Lori Greiner Investment Amount] IS NOT NULL
)j

ON i.Shark = j.Shark

INNER JOIN
(
SELECT
'Lori Greiner' AS Shark,
SUM(CAST([Lori Greiner Investment Amount]AS FLOAT) ) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Lori Greiner Investment Amount] IS NOT NULL
) k

ON i.Shark = k.Shark

INNER JOIN
(
SELECT 
'Lori Greiner' AS Shark,
AVG(CAST([Lori Greiner Investment Equity] AS FLOAT)) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Lori Greiner Investment Equity] IS NOT NULL
)l

ON i.Shark = l.Shark

UNION ALL

SELECT
m.Shark,
m.[Deals Present],
n.[Deals Taken],
o.[Total Investment],
p.[Average Investment Equity]
FROM
(
SELECT
'Robert Herjavec' AS Shark,
COUNT([Robert Herjavec Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Robert Herjavec Present] = 1
)m
INNER JOIN
(
SELECT
'Robert Herjavec' AS Shark,
COUNT([Robert Herjavec Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Robert Herjavec Investment Amount] IS NOT NULL
)n

ON m.Shark = n.Shark

INNER JOIN
(
SELECT
'Robert Herjavec' AS Shark,
SUM(CAST([Robert Herjavec Investment Amount]AS FLOAT) ) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Robert Herjavec Investment Amount] IS NOT NULL
) o

ON m.Shark = o.Shark

INNER JOIN
(
SELECT 
'Robert Herjavec' AS Shark,
AVG(CAST([Robert Herjavec Investment Equity] AS FLOAT)) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Robert Herjavec Investment Equity] IS NOT NULL
)p

ON m.Shark = p.Shark

UNION ALL

SELECT
q.Shark,
q.[Deals Present],
r.[Deals Taken],
s.[Total Investment],
t.[Average Investment Equity]
FROM
(
SELECT
'Daymond John' AS Shark,
COUNT([Daymond John Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Daymond John Present] = 1
)q
INNER JOIN
(
SELECT
'Daymond John' AS Shark,
COUNT([Daymond John Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Daymond John Investment Amount] IS NOT NULL
)r

ON q.Shark = r.Shark

INNER JOIN
(
SELECT
'Daymond John' AS Shark,
SUM(CAST([Daymond John Investment Amount]AS FLOAT) ) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Daymond John Investment Amount] IS NOT NULL
)s

ON q.Shark = s.Shark

INNER JOIN
(
SELECT 
'Daymond John' AS Shark,
AVG(CAST([Daymond John Investment Equity] AS FLOAT)) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Daymond John Investment Equity] IS NOT NULL
)t

ON q.Shark = t.Shark

UNION ALL

SELECT
u.Shark,
u.[Deals Present],
v.[Deals Taken],
w.[Total Investment],
x.[Average Investment Equity]
FROM
(
SELECT
'Kevin O Leary' AS Shark,
COUNT([Kevin O Leary Present]) AS [Deals Present]
FROM [Shark Tank dataset]
WHERE [Kevin O Leary Present] = 1
)u
INNER JOIN
(
SELECT
'Kevin O Leary' AS Shark,
COUNT([Kevin O Leary Investment Amount]) AS [Deals Taken]
FROM [Shark Tank dataset]
WHERE [Kevin O Leary Investment Amount] IS NOT NULL
)v

ON u.Shark = v.Shark

INNER JOIN
(
SELECT
'Kevin O Leary' AS Shark,
SUM(CAST([Kevin O Leary Investment Amount]AS FLOAT) ) AS [Total Investment]
FROM [Shark Tank dataset]
WHERE [Kevin O Leary Investment Amount] IS NOT NULL
)w

ON u.Shark = w.Shark

INNER JOIN
(
SELECT 
'Kevin O Leary' AS Shark,
AVG(CAST([Kevin O Leary Investment Equity] AS FLOAT)) AS [Average Investment Equity]
FROM [Shark Tank dataset]
WHERE [Kevin O Leary Investment Equity] IS NOT NULL
)x

ON u.Shark = x.Shark
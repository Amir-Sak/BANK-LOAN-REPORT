select * from [bank-data]


--Total Loan Applications: 
select count(id) as totalloanApplication from dbo.[bank-data]

select count(id) as MTD_Total_Loan_Application  from dbo.[bank-data]
WHERE MONTH(issue_date) = 12 
AND YEAR(issue_date) = 2021


select count(id) as PMTD_Total_Loan_Application  from dbo.[bank-data]
WHERE MONTH(issue_date) = 11 
AND YEAR(issue_date) = 2021


--Total Funded Amount:
--YTM
SELECT SUM(loan_amount) AS YTDTotal_Funded_Amount from [bank-data]
--MTD
SELECT SUM(loan_amount) AS MTDTotal_Funded_Amount from [bank-data]
WHERE MONTH(issue_date) = 12
AND YEAR(issue_date) = 2021
--PMTD
SELECT SUM(loan_amount) AS PMTDTotal_Funded_Amount from [bank-data]
WHERE MONTH(issue_date) = 11
AND YEAR(issue_date) = 2021

--Total Amount Received

--YTM
SELECT SUM(total_payment) AS Total_Amount_Received FROM [bank-data]
--MTD
SELECT SUM(total_payment) AS MTDTotal_Amount_Received FROM [bank-data]
WHERE MONTH(issue_date) = 12 
AND YEAR(issue_date) = 2021
--PMTD
SELECT SUM(total_payment) AS PMTDTotal_Amount_Received FROM [bank-data]
WHERE MONTH(issue_date) = 11 
AND YEAR(issue_date) = 2021

--AVG Interest Rate
--YTM
select AVG(int_rate)/10000 AS AVG_Interset_Rate from [bank-data]
select Round(AVG(int_rate), 2)/10000 AS AVG_Interset_Rate from [bank-data]
--MTD
select Round(AVG(int_rate), 2)/10000 AS MAVG_Interset_Rate from [bank-data]
WHERE MONTH(issue_date) = 12 
AND YEAR(issue_date) = 2021
--PMTD
select Round(AVG(int_rate), 2)/10000 AS PMAVG_Interset_Rate from [bank-data]
WHERE MONTH(issue_date) = 11 
AND YEAR(issue_date) = 2021

--Average Debt-to-Income Ratio (DTI)
--YTM
select ROUND(dti/ 10000, 4) as DTI from [bank-data]

select ROUND(avg(dti)/ 10000, 4) as DTI from [bank-data]
--MTD
select ROUND(avg(dti)/ 10000, 4) as MtDDTI from [bank-data]
WHERE MONTH(issue_date) = 12 
AND YEAR(issue_date) = 2021
--PMTM
select ROUND(avg(dti)/ 10000, 4) as PMtDDTI from [bank-data]
WHERE MONTH(issue_date) = 11 
AND YEAR(issue_date) = 2021

--dashboard loan 
--Good loan vs bad loan 

select * from [bank-database].dbo.[bank-data]

select loan_status from [bank-database].dbo.[bank-data]
--Good Loan Percentage
select 
	(count(case when loan_status ='Fully Paid' or loan_status = 'Current' then id end))
	/
	count(id) as good_loan_percentage 
	from [bank-database].dbo.[bank-data]
	--percentege of good loan
	SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)* 100) / 
	COUNT(id) AS Good_Loan_Percentage
FROM [bank-database].dbo.[bank-data]
--number of good loan

SELECT COUNT(id) AS Good_Loan_Applications from [bank-database].dbo.[bank-data]
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--good loan funded amount
SELECT sum(loan_amount) AS Good_Loan_funded_amount from [bank-database].dbo.[bank-data]
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Amount Received
SELECT sum(total_payment) AS Good_Loan_receved_amount from [bank-database].dbo.[bank-data]
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


--bad loan percentege


SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM [bank-database].dbo.[bank-data]

--bad loan
select count(id) as bad_loan_app
 FROM [bank-database].dbo.[bank-data]
WHERE loan_status = 'charged off'
--bad loan amount

select sum(loan_amount) as bad_loan_amount
 FROM [bank-database].dbo.[bank-data]
WHERE loan_status = 'charged off'

--bad loan amount receve 
select sum(total_payment) as bad_loan_amount_receviedd
 FROM [bank-database].dbo.[bank-data]
WHERE loan_status = 'charged off'

--loan status
--select * from [bank-database].dbo.[bank-data] 

select
loan_status,
Count(id) AS Loanacount,
Sum(total_payment) as Total_Amount_received,
SUM(loan_amount) AS Total_Amount_Founded,
AVG(int_rate) / 10000 as inetrest_rate,
AVG(dti) / 10000 as DTI
FROM 
[bank-database].dbo.[bank-data]
group by
loan_status
order by Loanacount desc

--loan status DTM
SELECT
loan_status,
Count(id) AS Loanacount,
Sum(total_payment) as DTM_Total_Amount_received,
SUM(loan_amount) AS DTM_Total_Amount_Founded,
AVG(int_rate) / 10000 as DTM_inetrest_rate,
AVG(dti) / 10000 as DTM_DTI
FROM 
[bank-database].dbo.[bank-data]
WHERE MONTH(issue_date) = 12
group by
loan_status
order by Loanacount desc

--BANK LOAN REPORT | OVERVIEW sharts
--MONTH
select
MONTH(issue_date) AS Month_Number,
Datename(MONTH, issue_date) as Month_Name,
COUNT(id) as Total_Loan_app,
SUM(loan_amount) as Toatal_Amount_Funded,
SUM(total_payment) as Total_Amount_Recived
from [bank-database].dbo.[bank-data]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--Regional Analysis
select 
address_state,
COUNT(id) as Total_Loan_app,
SUM(loan_amount) as Toatal_Amount_Funded,
SUM(total_payment) as Total_Amount_Recived
from [bank-database].dbo.[bank-data]
GROUP BY address_state
order by address_state

--term
SELECT
term,
COUNT(id) as Total_Loan_app,
SUM(loan_amount) as Toatal_Amount_Funded,
SUM(total_payment) as Total_Amount_Recived
from [bank-database].dbo.[bank-data]
GROUP BY term
order by term

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
	from [bank-database].dbo.[bank-data]
	WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose

SELECT 
	emp_length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [bank-database].dbo.[bank-data]
where emp_length > '3 years'
GROUP BY emp_length
ORDER BY emp_length

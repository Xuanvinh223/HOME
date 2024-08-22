USE UOF

SELECT * FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT CURRENT_DOC FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT LNO, Name, Name_ID, Purpose, FLocation, BTime, ETime, USERID, USERDATE, TASK_ID 
                           FROM LYN_BusinessTrip LEFT JOIN TB_WKF_TASK on LYN_BusinessTrip.LNO=TB_WKF_TASK.DOC_NBR 
                           WHERE isnull(Days,2)>=2 and flowflag='Z' and LNO not in (select BLNO as LNO from LYN_BusinessTripReport where isnull(Cancel,0)<>1)
SELECT * FROM dbo.LYN_BusinessTripExpert                           
SELECT * FROM dbo.LYN_BusinessTrip_Templ


SELECT *FROM dbo.LYN_BusinessTripReport


CREATE TABLE LYN_BusinessTripReport (
    LNO           NVARCHAR(100) PRIMARY KEY,         -- Assuming LNO is a primary key and an integer
    Department    NVARCHAR(100),           -- Adjust length as needed for department name
    [Date]        DATE,                    -- Assuming this column stores a date
    Date1         DATE,                    -- Assuming this column stores another date
    Name          NVARCHAR(100),           -- Adjust length as needed for the person's name
    Destination   NVARCHAR(255),           -- Adjust length as needed for destination description
    Description   NVARCHAR(MAX),           -- Adjust length as needed for trip description
    BLNO          NVARCHAR(255),
	Cancel INT ,
	CancelReason NVARCHAR(255),
	CFMID NVARCHAR(255),
	-- Assuming BLNO is an integer (if it's a reference to another table, consider using a foreign key)
    USERID        NVARCHAR(50),            -- Adjust length as needed for user identifier
    USERDATE      DATETIME,                -- Assuming this column stores a datetime value
    flowflag      VARCHAR(2)                  -- Assuming flowflag is a small integer indicating a status or flag
);
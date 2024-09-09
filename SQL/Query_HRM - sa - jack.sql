USE HRM


SELECT * 
                            FROM ST_NHANVIEN 
                            WHERE NV_Ma NOT IN(SELECT NV_Ma FROM ST_NHANVIENTHOIVIEC)
                            ORDER BY NV_Ma


SELECT * FROM dbo.ST_NHANVIEN 
WHERE NV_Ten LIKE 'N$THO$'


SELECT 
    ISNULL(SUM(CASE WHEN NP_Ma = 'P' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS MonthLeaveDay, 
    ISNULL(SUM(CASE WHEN NP_Ma = 'RO' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS RO, 
    ISNULL(SUM(CASE WHEN NP_Ma = 'OM' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS OM, 
    ISNULL(SUM(CASE WHEN NP_Ma = 'CO' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS CO 
FROM (
    SELECT 
        NP_Ma,
        CASE 
            WHEN MONTH(NP_TUNGAY) = MONTH(GETDATE()) AND YEAR(NP_TUNGAY) = YEAR(GETDATE()) THEN NP_TUNGAY
            ELSE DATEADD(DAY, 1 - DAY(GETDATE()), GETDATE())
        END AS StartDate,
        CASE 
            WHEN MONTH(NP_DENNGAY) = MONTH(GETDATE()) AND YEAR(NP_DENNGAY) = YEAR(GETDATE()) THEN NP_DENNGAY
            ELSE DATEADD(DAY, -DAY(DATEADD(MONTH, 1, GETDATE())), DATEADD(MONTH, 1, GETDATE()))
        END AS EndDate
    FROM ST_NHANVIENNGHIPHEP
    WHERE NV_Ma = '80114'
    AND (
        (YEAR(NP_TuNgay) = YEAR(GETDATE()) AND MONTH(NP_TuNgay) = MONTH(GETDATE())) OR 
        (YEAR(NP_DenNgay) = YEAR(GETDATE()) AND MONTH(NP_DenNgay) = MONTH(GETDATE())) 
    )
) Result;


SELECT 
                                ISNULL(SUM(CASE WHEN NP_Ma = 'P' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS MonthLeaveDay, 
                                ISNULL(SUM(CASE WHEN NP_Ma = 'RO' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS RO, 
                                ISNULL(SUM(CASE WHEN NP_Ma = 'OM' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS OM, 
                                ISNULL(SUM(CASE WHEN NP_Ma = 'CO' THEN DATEDIFF(DAY, StartDate, EndDate) + 1 - DATEDIFF(WEEK, StartDate, EndDate) END), 0) AS CO 
                            FROM (
                                SELECT 
                                    NP_Ma,
                                    CASE 
                                        WHEN MONTH(NP_TUNGAY) = MONTH(GETDATE()) AND YEAR(NP_TUNGAY) = YEAR(GETDATE()) THEN NP_TUNGAY
                                        ELSE DATEADD(DAY, 1 - DAY(GETDATE()), GETDATE())
                                    END AS StartDate,
                                    CASE 
                                        WHEN MONTH(NP_DENNGAY) = MONTH(GETDATE()) AND YEAR(NP_DENNGAY) = YEAR(GETDATE()) THEN NP_DENNGAY
                                        ELSE DATEADD(DAY, -DAY(DATEADD(MONTH, 1, GETDATE())), DATEADD(MONTH, 1, GETDATE()))
                                    END AS EndDate
                                FROM ST_NHANVIENNGHIPHEP
                                WHERE NV_Ma = '@ID'
                                AND (
                                    (YEAR(NP_TuNgay) = YEAR(GETDATE()) AND MONTH(NP_TuNgay) = MONTH(GETDATE())) OR 
                                    (YEAR(NP_DenNgay) = YEAR(GETDATE()) AND MONTH(NP_DenNgay) = MONTH(GETDATE())) 
                                )
                            ) Result;


SELECT ST_NHANVIEN.NV_Ma, ST_NHANVIEN.NV_Ten, ST_NHANVIEN.DV_MA_, ISNULL(ST_NHANVIENTHOIVIEC.NV_Ma, 'Employee') AS Flag, ST_DONVI.KHU 
FROM ST_NHANVIEN 
LEFT JOIN ST_NHANVIENTHOIVIEC ON ST_NHANVIENTHOIVIEC.NV_Ma = ST_NHANVIEN.NV_Ma 
LEFT JOIN ST_DONVI ON ST_DONVI.DV_MA = ST_NHANVIEN.DV_MA 
WHERE ST_NHANVIEN.NV_Ma = '012323'


SELECT ST_NHANVIEN.DV_MA,DV_TEN
FROM ST_DONVI left JOIN dbo.ST_NHANVIEN ON ST_NHANVIEN.DV_MA = ST_DONVI.DV_MA
WHERE NV_Ma = '012323' 



SELECT ST_NHANVIEN.NV_Ma, ST_NHANVIEN.NV_Ten, ST_NHANVIEN.DV_MA_, QT_MA,ISNULL(ST_NHANVIENTHOIVIEC.NV_Ma, 'Employee') AS Flag FROM ST_NHANVIEN
                              LEFT JOIN ST_NHANVIENTHOIVIEC ON ST_NHANVIENTHOIVIEC.NV_Ma = ST_NHANVIEN.NV_Ma 
                              LEFT JOIN ST_DONVI ON ST_DONVI.DV_MA = ST_NHANVIEN.DV_MA 
                              WHERE ST_NHANVIEN.NV_Ma = '012323' 

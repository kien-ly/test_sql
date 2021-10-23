--1. Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 
(select MAGV
from GIAOVIEN 
where LUONG > 2000 and HOTEN like N'Nguyễn%')
union
(select gv.magv
from giaovien gv join bomon bm on gv.magv = bm.truongbm
where year(bm.NGAYNHANCHUC)> 1995 )

--2: Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
SELECT * 
from GIAOVIEN gv left join BOMON bm on gv.MABM = bm.MABM


--3. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
SELECT HOTEN
  FROM GIAOVIEN GV, BOMON BM
  WHERE BM.TENBM = N'Hệ thống thông tin' AND GV.MABM = BM.MABM
      AND YEAR(GV.NGSINH) = (SELECT MIN(YEAR(GV1.NGSINH))
                FROM GIAOVIEN GV1, BOMON BM1
                WHERE BM1.TENBM = N'Hệ thống thông tin' AND GV1.MABM = BM1.MABM)

--4. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
SELECT HOTEN
  FROM GIAOVIEN GV
  WHERE GV.MAGV IN (SELECT MAGV
            FROM GIAOVIEN GV1, DETAI DT1
            WHERE GV1.MAGV = DT1.GVCNDT 
            GROUP BY GV1.MAGV
            HAVING COUNT(*) >= ALL (SELECT GV.MAGV
                        FROM GIAOVIEN GV2, DETAI DT2
                        WHERE GV2.MAGV = DT2.GVCNDT 
                        GROUP BY GV2.MAGV))

--5. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
SELECT HOTEN, TENBM
  FROM GIAOVIEN GV, BOMON BM
  WHERE GV.MABM = BM.MABM AND EXISTS      (SELECT GV2.MAGV
                      FROM GIAOVIEN GV2, THAMGIADT TG
                      WHERE GV2.MAGV = TG.MAGV  AND GV.MAGV = GV2.MAGV
                      GROUP BY GV2.MAGV
                      HAVING COUNT(*) >=ALL (SELECT (COUNT(*))
                                  FROM GIAOVIEN GV3, THAMGIADT TG3
                                  WHERE GV3.MAGV = TG3.MAGV
                                  GROUP BY GV3.MAGV))

--6. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
        FROM DETAI DT
        WHERE NOT EXISTS (SELECT GV.MAGV
                  FROM GIAOVIEN GV
                  WHERE GV.MABM = 'HTTT'
                  EXCEPT
                  SELECT TG.MAGV
                  FROM THAMGIADT TG
                  WHERE DT.MADT = TG.MADT  
                  )
                  )  

--7. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
SELECT HOTEN
FROM  GIAOVIEN GV
WHERE GV.MAGV IN(SELECT GV.MAGV
        FROM THAMGIADT TG, DETAI DT
        WHERE NOT EXISTS (SELECT DT.MADT
                  FROM GIAOVIEN GV JOIN DETAI DT ON DT.GVCNDT=GV.MAGV
                  WHERE  GV.HOTEN = N'Trần Trà Hương'
                  EXCEPT
                  SELECT TG.MADT
                  FROM THAMGIADT TG
                  WHERE GV.MAGV = TG.MAGV 
                  )
)  

--8. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia.
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
        FROM DETAI DT
        WHERE NOT EXISTS (SELECT GV.MAGV
                  FROM GIAOVIEN GV, BOMON BM
                  WHERE GV.MABM = BM.MABM AND BM.MAKHOA = 'CNTT'
                  EXCEPT
                  SELECT TG.MAGV
                  FROM THAMGIADT TG
                  WHERE DT.MADT = TG.MADT
                    )
                  )

--9. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
        FROM DETAI DT
        WHERE NOT EXISTS(SELECT GV.MAGV
                  FROM GIAOVIEN GV, BOMON BM
                  WHERE GV.MABM = BM.MABM AND BM.MAKHOA = 'SH'
                  EXCEPT
                  SELECT TG.MAGV
                  FROM THAMGIADT TG
                  WHERE DT.MADT = TG.MADT
                    )
                  )

--10. Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.

SELECT GV.MAGV, GV.HOTEN, BM.TENBM, GV.GVQLCM
FROM  GIAOVIEN GV
JOIN  THAMGIADT TG  ON GV.MAGV = TG.MAGV
JOIN BOMON BM ON GV.MABM = BM.MABM
WHERE TG.MAGV IN(SELECT DISTINCT TG.MAGV
					FROM THAMGIADT TG, DETAI DT
				WHERE NOT EXISTS (SELECT distinct  DT.MADT
                  FROM CHUDE CD ,DETAI DT 
                  WHERE CD.MACD = DT.MACD and CD.TENCD = N'Nghiên cứu phát triển'
                  EXCEPT
                  SELECT DISTINCT  TG.MADT
                  FROM THAMGIADT TG ,DETAI DT 
                  WHERE TG.MADT = DT.MADT
                  )
)  

------------------------

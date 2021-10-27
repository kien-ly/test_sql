# test_sql

### Phần C

Sau khi tạo bảng ([script](https://github.com/ke666/test_sql/blob/main/tao_bang.sql)), ta có kết quả bảng:
<p align="center"> <img src="img/luocdo.png" width=""> </p>

Và nhập data, được kết quả. 

<p align="center"> <img src="img/CV.png" width=""> </p>
<p align="center"> <img src="img/dt.png" width=""> </p>
<p align="center"> <img src="img/BM.png" width=""> </p>
<p align="center"> <img src="img/Chude.png" width=""> </p>
<p align="center"> <img src="img/khoa.png" width=""> </p>
<p align="center"> <img src="img/thamgia.png" width=""> </p>
<p align="center"> <img src="img/ngthan.png" width=""> </p>
<p align="center"> <img src="img/gv_dt.png" width=""> </p>







### Phần D 
([script](https://github.com/ke666/test_sql/blob/main/tao_bang.sql))

Câu 1: 
```SQL
--1. Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 
(select MAGV
from GIAOVIEN 
where LUONG > 2000 and HOTEN like N'Nguyễn%')
union
(select gv.magv
from giaovien gv join bomon bm on gv.magv = bm.truongbm
where year(bm.NGAYNHANCHUC)> 1995 )
```
<p align="center"> <img src="img/1.png" width=""> </p>

Câu 2:
```SQL
--2: Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
SELECT  gv.HOTEN, bm.* 
from GIAOVIEN gv left join BOMON bm on gv.MABM = bm.MABM
```
<p align="center"> <img src="img/2.png" width=""> </p>

Câu 3:
```SQL
--3. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
SELECT HOTEN
  FROM GIAOVIEN GV, BOMON BM
  WHERE BM.TENBM = N'Hệ thống thông tin' AND GV.MABM = BM.MABM
      AND YEAR(GV.NGSINH) = (SELECT MIN(YEAR(GV1.NGSINH))
                FROM GIAOVIEN GV1, BOMON BM1
                WHERE BM1.TENBM = N'Hệ thống thông tin' AND GV1.MABM = BM1.MABM)
```
<p align="center"> <img src="img/3.png" width=""> </p>

Câu 4:
```SQL
--4. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
SELECT HOTEN
  FROM GIAOVIEN GV
  WHERE GV.MAGV IN (SELECT GV1.MAGV
            FROM GIAOVIEN GV1, DETAI DT1
            WHERE GV1.MAGV = DT1.GVCNDT 
            GROUP BY GV1.MAGV
            HAVING COUNT(*) >= ALL (SELECT (COUNT(*))
                        FROM GIAOVIEN GV2, DETAI DT2
                        WHERE GV2.MAGV = DT2.GVCNDT 
                        GROUP BY GV2.MAGV)
)
```

<p align="center"> <img src="img/4.png" width=""> </p>

Câu 5:
```SQL
--5. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
SELECT HOTEN, TENBM
  FROM GIAOVIEN GV, BOMON BM
  WHERE GV.MABM = BM.MABM AND EXISTS (SELECT GV2.MAGV
                      FROM GIAOVIEN GV2, THAMGIADT TG
                      WHERE GV2.MAGV = TG.MAGV  AND GV.MAGV = GV2.MAGV
                      GROUP BY GV2.MAGV
                      HAVING COUNT(*) >=ALL (SELECT (COUNT(*))
                                  FROM GIAOVIEN GV3, THAMGIADT TG3
                                  WHERE GV3.MAGV = TG3.MAGV
                                  GROUP BY GV3.MAGV))
```
<p align="center"> <img src="img/5.png" width=""> </p>

Câu 6:
```SQL
--6. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
        FROM DETAI DT
        WHERE NOT EXISTS (SELECT GV.MAGV
                  FROM GIAOVIEN GV, BOMON BM
                  WHERE GV.MABM = BM.MABM and BM.TENBM=N'Hệ thống thông tin'                               
                  EXCEPT
                  SELECT TG.MAGV
                  FROM THAMGIADT TG
                  WHERE DT.MADT = TG.MADT  
                  )
)  
```
<p align="center"> <img src="img/6.png" width=""> </p>

Câu 7:
```SQL
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
```
<p align="center"> <img src="img/7.png" width=""> </p>

Câu 8:
```SQL
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
```
<p align="center"> <img src="img/8.png" width=""> </p>

Câu 9:
```SQL
--9. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
        FROM DETAI DT
        WHERE NOT EXISTS(SELECT GV.MAGV
                  FROM GIAOVIEN GV , BOMON BM, KHOA K
                  WHERE GV.MABM = BM.MABM AND BM.MAKHOA = K.MAKHOA AND K.TENKHOA=N'Sinh học'
                  EXCEPT
                  SELECT TG.MAGV
                  FROM THAMGIADT TG
                  WHERE DT.MADT = TG.MADT
                    )
)
```
<p align="center"> <img src="img/9.png" width=""> </p>

Câu 10:
```SQL
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

```
<p align="center"> <img src="img/10.png" width=""> </p>

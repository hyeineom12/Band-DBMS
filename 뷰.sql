
-- 임원진들과　세션장들　

-- 뷰　생성　
CREATE VIEW 임원_세션장_전체뷰 AS
SELECT 
    부원.학번,
    부원.이름,
    부원.기수,
    부원.세션,
    임원진.직급 AS 역할,
    '임원진' AS 구분
FROM 부원
JOIN 임원진 ON 부원.학번 = 임원진.학번 AND 부원.기수 = 임원진.기수
UNION
SELECT 
    부원.학번,
    부원.이름,
    부원.기수,
    부원.세션,
    세션장.세션 AS 역할,
    '세션장' AS 구분
FROM 부원
JOIN 세션장 ON 부원.학번 = 세션장.학번 AND 부원.기수 = 세션장.기수;
SELECT * FROM 임원_세션장_전체뷰 ;


-- 뷰　검색　
SELECT 학번, 이름, 기수, 세션
FROM 임원_세션장_전체뷰
GROUP BY 학번, 이름, 기수, 세션
HAVING COUNT(DISTINCT 구분) = 2;

-- 뷰 삭제
DROP VIEW 임원_세션장_전체뷰;
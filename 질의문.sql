use band ;

-- 일반질의
-- 팀이 참여한 공연의 행사명과 날짜
SELECT 팀.곡이름, 공연.행사명, 공연.날짜
FROM 팀, 공연_팀, 공연
WHERE 팀.팀번호 = 공연_팀.팀번호
  AND 공연.공연번호 = 공연_팀.공연번호;

-- 34기 이름과 학번 출력 
SELECT 이름, 학번
FROM 부원
WHERE 기수 = 34;

-- 임원진이면서 세션장인사람
SELECT 부원.이름, 부원.학번, 부원.기수
FROM 부원
JOIN 세션장 ON 부원.학번 = 세션장.학번
JOIN 임원진 ON 부원.학번 = 임원진.학번;



-- 복합질의 
-- 20번 이상 다른 부원들과 팀을 함께한 부원들의 이름과 횟수
SELECT 부원.이름,
    (
        SELECT COUNT(*)
        FROM 팀_부원 TB1, 팀_부원 TB2
        WHERE TB1.학번 = 부원.학번
          AND TB1.팀번호 = TB2.팀번호
          AND TB1.학번 != TB2.학번
    ) AS 함께한_횟수
FROM 부원
WHERE (
    SELECT COUNT(*)
    FROM 팀_부원 TB1, 팀_부원 TB2
    WHERE TB1.학번 = 부원.학번
      AND TB1.팀번호 = TB2.팀번호
      AND TB1.학번 != TB2.학번
) > 20;

-- 각 부원이 가장 최근에 참여한 공연 날짜
SELECT 부원.이름, 최근공연.최근공연날짜
FROM 부원
JOIN (
    SELECT 팀_부원.학번, MAX(공연.날짜) AS 최근공연날짜
    FROM 팀_부원
    JOIN 공연_팀 ON 팀_부원.팀번호 = 공연_팀.팀번호
    JOIN 공연 ON 공연_팀.공연번호 = 공연.공연번호
    GROUP BY 팀_부원.학번
) AS 최근공연 ON 부원.학번 = 최근공연.학번;


-- 34기 부원 중 자신이 한 조언이 받은 조언보다 많은 사람 
SELECT 부원.이름
FROM 부원
WHERE 부원.기수 = 34
  AND (
    SELECT COUNT(*)
    FROM 조언 J1
    WHERE J1.조언자_학번 = 부원.학번
  ) > (
    SELECT COUNT(*)
    FROM 조언 J2
    WHERE J2.조언받는_학번 = 부원.학번
  ) ;
  
  
  
--  Aggregation (집계, group by/having 포함) 예시 (3개 이상)
-- 공연별 총 지출액과 팀 수 구하기
SELECT 공연.행사명, 공연.지출, COUNT(공연_팀.팀번호) 참여팀
FROM 공연
JOIN 공연_팀 ON 공연.공연번호 = 공연_팀.공연번호
GROUP BY 공연.공연번호, 공연.행사명, 공연.지출;


-- 33, 34, 35기 기수들의 평균 부원 수보다 많은 기수 목록
SELECT 기수, COUNT(*) AS 인원수
FROM 부원
GROUP BY 기수
HAVING COUNT(*) > (
    SELECT AVG(기수별_인원수)
    FROM (
        SELECT 기수, COUNT(*) AS 기수별_인원수
        FROM 부원
        WHERE 기수 IN (33, 34, 35)
        GROUP BY 기수
    ) AS 서브쿼리
);

-- 3개 이상의 팀에 속해 있는 부원 목록과 그 팀 수
SELECT 팀_부원.학번, COUNT(*) AS 팀수
FROM 팀_부원
GROUP BY 팀_부원.학번
HAVING COUNT(*) >= 3;



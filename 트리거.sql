use band ;

DELIMITER //
CREATE PROCEDURE 부원_조회 (
	기준기수 INT)
BEGIN
	SELECT * FROM 부원
    WHERE 기수 >= 기준기수 ;
END //
DELIMITER ;

call 부원_조회(34)


DELIMITER //
CREATE FUNCTION 기수찾기(
	입력학번 CHAR(8))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE 결과 INT;
    SELECT 기수 INTO 결과
    FROM 부원
    WHERE 학번 = 입력학번;
    RETURN 결과;
END //
DELIMITER ;

SELECT 기수찾기('20230280');


CREATE TABLE 부원로그 (
    학번 CHAR(8),
    이름 VARCHAR(20),
    등록일시 DATETIME
);

DELIMITER //
CREATE TRIGGER 부원등록로그
AFTER INSERT ON 부원
FOR EACH ROW
BEGIN
    INSERT INTO 부원로그(학번, 이름, 등록일시)
    VALUES (NEW.학번, NEW.이름, NOW());
END //
DELIMITER ;

INSERT INTO 부원 (학번, 이름, 학과, 기수, 세션)
VALUES ('20251111', '예시인물', '국문학과', 36, '보컬');

select * from 부원로그 ;










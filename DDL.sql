create schema band ;
use band ;

CREATE TABLE 부원 (
    학번 VARCHAR(10) PRIMARY KEY,
    이름 VARCHAR(50) NOT NULL,
    학과 VARCHAR(50) NOT NULL,
    기수 INT NOT NULL,
    세션 VARCHAR(50) NOT NULL);

CREATE TABLE 임원진 (
    학번 VARCHAR(10) PRIMARY KEY,
    기수 INT NOT NULL,
    직급 VARCHAR(50) NOT NULL,
    FOREIGN KEY (학번) REFERENCES 부원(학번));
    

CREATE TABLE 세션장 (
    학번 VARCHAR(10) PRIMARY KEY,
    기수 INT NOT NULL,
    세션 VARCHAR(50) NOT NULL,
    FOREIGN KEY (학번) REFERENCES 부원(학번));


CREATE TABLE 팀 (
    팀번호 INT PRIMARY KEY,
    곡이름 VARCHAR(100) NOT NULL,
    가수 VARCHAR(50) NOT NULL);


CREATE TABLE 공연 (
    공연번호 INT PRIMARY KEY,
    행사명 VARCHAR(100) NOT NULL,
    날짜 DATE NOT NULL,
    지출 INT DEFAULT 0);
    

CREATE TABLE 지원서 (
    학번 VARCHAR(10),
    지원순서 INT,
    지원동기 TEXT,
    지원세션 VARCHAR(50),
    PRIMARY KEY (학번, 지원순서),
    FOREIGN KEY (학번) REFERENCES 부원(학번));
    
    
CREATE TABLE 조언 (
    조언자_학번 VARCHAR(10),
    조언받는_학번 VARCHAR(10),
    PRIMARY KEY (조언자_학번, 조언받는_학번),
    FOREIGN KEY (조언자_학번) REFERENCES 부원(학번),
    FOREIGN KEY (조언받는_학번) REFERENCES 부원(학번));


CREATE TABLE 팀_부원 (
    팀번호 INT,
    학번 VARCHAR(10),
    PRIMARY KEY (팀번호, 학번),
    FOREIGN KEY (팀번호) REFERENCES 팀(팀번호),
    FOREIGN KEY (학번) REFERENCES 부원(학번));
	

CREATE TABLE 공연_팀 (
    공연번호 INT,
    팀번호 INT,
    PRIMARY KEY (공연번호, 팀번호),
    FOREIGN KEY (공연번호) REFERENCES 공연(공연번호),
    FOREIGN KEY (팀번호) REFERENCES 팀(팀번호));
    
    
    
    
    
    
    
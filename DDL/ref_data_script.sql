-- 기준 정보 스크립트

-- 등급테이블
INSERT INTO rank
VALUES
    (null,'BlackList', 0 , 1),
    (null,'CargoClass', 50 , 1),
    (null,'EconomyClass', 100 , 1),
    (null,'PremiumEconomyClass',150, 1),
    (null,'BusinessClass', 250 , 1.05),
    (null,'FirstClass', 400 , 1.1),
    (null,'CoPilotClass', 600 , 1.15),
    (null,'CaptainClass',  1000, 1.2);

-- 블랙리스트 기준
INSERT INTO blacklist_rule
VALUES
    (null ,'성폭행'),
    (null ,'성희롱'),
    (null ,'강도/도둑질'),
    (null ,'회원점수 0점(영구제명)'),
    (null ,'명의도용/개인정보누출'),
    (null ,'해킹'),
    (null ,'누적 정지 및 신고 10건 이상');

-- 정지 기준
INSERT INTO ban_rule
VALUES
    (NULL, '인신공격', 7),
    (NULL, '욕설/비방', 6),
    (NULL, '폭력적/혐오', 5),
    (NULL, '명의도용/개인정보 노출', 5),
    (NULL, '광고/스팸', 3),
    (NULL, '거짓 정보', 2),
    (NULL, '게시글/댓글 도배', 1);

-- 블랙리스트 기준
INSERT INTO Report
VALUES
    (1, '인신공격'),
    (2, '욕설/비방'),
    (3, '폭력적/혐오'),
    (4, '명의도용/개인정보 노출'),
    (5, '광고/스팸'),
    (6, '거짓 정보'),
    (7, '게시글/댓글 도배');

-- 취향 코드
insert into preference
values
    (1, 'MBTI',null),
    (2, '음식취향',null),
    (3, '여행취향',null),
    (4, '나이대',null);

insert into preference
values
    (101, 'ISTJ',1),
    (102, 'ISFJ',1),
    (103, 'INFJ',1),
    (104, 'INTJ',1),
    (105, 'ISTP',1),
    (106, 'ISFP',1),
    (107, 'INFP',1),
    (108, 'INTP',1),
    (109, 'ESTP',1),
    (110, 'ESFP',1),
    (111, 'ENFP',1),
    (112, 'ENTP',1),
    (113, 'ESTJ',1),
    (114, 'ESFJ',1),
    (115, 'ENFJ',1),
    (116, 'ENTJ',1),
    (201, '한식',2),
    (202, '중식',2),
    (203, '일식',2),
    (204, '양식',2),
    (301, '산책', 3),
    (302, '식도락(맛집탐방)', 3),
    (303, '관광지', 3),
    (304, '힐링/휴식', 3),
    (305, '액티비티', 3),
    (306, '배낭여행', 3),
    (307, '하루 5끼 이상', 3),
    (308, '하루 1끼', 3),
    (401, '10', 4),
    (402, '20', 4),
    (403, '30', 4),
    (404, '40', 4),
    (405, '50', 4),
    (406, '60', 4),
    (407, '70', 4),
    (408, '80', 4),
    (409, '90', 4)

-- 언어
INSERT INTO languages
VALUES
    (NULL, '영어', 'en'),
    (NULL, '중국어', 'zh'),
    (NULL, '스페인어', 'es'),
    (NULL, '아랍어', 'ar'),
    (NULL, '힌디어', 'hi'),
    (NULL, '프랑스어', 'fr'),
    (NULL, '뱅골어', 'bn'),
    (NULL, '포르투갈어', 'pt'),
    (NULL, '러시아어', 'ru'),
    (NULL, '일본어', 'ja'),
    (NULL, '한국어', 'ko'),
    (NULL, '독일어', 'de'),
    (NULL, '터키어', 'tr'),
    (NULL, '우르두어', 'ur'),
    (NULL, '베트남어', 'vi'),
    (NULL, '이탈리어', 'it'),
    (NULL, '페르시아어', 'fa'),
    (NULL, '타이어', 'th'),
    (NULL, '인도네시아어', 'id');

-- 회원 상태
insert into member_status
values
    (null ,'정상'),
    (null ,'휴먼'),
    (null ,'정지'),
    (null ,'탈퇴'),
    (null ,'블랙리스트');

-- 게시판
insert into board
values
    (null ,'자유'),
    (null ,'동행'),
    (null ,'여행지 추천');
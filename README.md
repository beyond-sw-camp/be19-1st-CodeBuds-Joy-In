
# Joy-In🚤
<img width="600" height="380" alt="Image" src="https://github.com/user-attachments/assets/0a37d6b1-7b43-4073-8c5c-39fd128eb43a" />

## 프로젝트 소개
### 프로젝트 개요
현대인들은 혼자서도 자유롭게 여행하거나 취미 활동을 즐기지만,  
때로는 “지금 이 순간, 함께할 사람”을 필요로 합니다.

하지만 기존 번개 모임 앱들은

- **참여 인원이 너무 많거나**
    
- **정해진 시간/장소에만 참여해야 하며**
    
- **나와 맞는 사람을 찾는 데 많은 시간과 노력이 필요합니다.**
    

**Joy-in은 이런 불편함을 해결하기 위해 탄생했습니다.**  
내가 원하는 순간, 나와 취향이 맞는 사람과 즉시 연결되는 “실시간 번개 매칭 서비스”입니다.


## 팀원
|<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/4da0c5f9-3d48-44d2-ae21-860a027a4e1c" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/3200b60c-20c6-495d-87b8-a4fadff9827a" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/ef2e5d74-09ed-4d47-b1b7-34ae8a607d19" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/10fa156a-1f3f-4d71-a2d7-944723c7c26d" /> | <img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/3e31cd21-699c-43db-8f73-72f5354a3a8a" />|
|:---:|:---:|:---:|:---:|:---:|
|강지륜|강형규|민수현|윤서진|이승건|

## 1. 개발 환경
|<img width="100" height="95" alt="Image" src="https://github.com/user-attachments/assets/ec56bfb4-ebfe-4601-a1d5-20a51082937b" />|<img width="100" height="100" alt="Image" src="https://github.com/user-attachments/assets/5caf3ad3-da2b-459f-8b9b-b8ca260f5f96" />|<img width="80" height="80" alt="Image" src="https://github.com/user-attachments/assets/07eb1139-3dfb-4a60-a16f-2764d82daa7e" />|<img width="100" height="95" alt="Image" src="https://github.com/user-attachments/assets/73071594-2716-4222-a226-2a0b680a089e" />|<img width="100" height="100" alt="Image" src="https://github.com/user-attachments/assets/953266e3-7da6-4344-af1a-796468762ba0" />|
| :------: | :------: | :------: | :------: | :------: |
|MariaDB|Notion|Ubuntu|VirtualBox|GitHub|


## 2. 주요 기능
- **일대일 매칭** : 나이대, MBTI, 선호 여행 방식 등 다양한 기준으로 근처의 유저와 자동 매칭

- **자유/여행지 추천 게시판** : 여행자들끼리 서로 소통하고 정보를 공유

- **동행 게시판** : 여행 중 다수의 인원을 자유롭게 만날 수 있도록 모집 및 참여 가능

- **후기** : 만남 이후 서로에게 후기와 평점 남기기

- **등급** : 평점을 토대로 점수를 책정해 등급 상승 및 하락



## 3. 요구사항 명세서

<a href="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbzFSfMc7xw5tNd2A0PAL6z-a-O3o-sPAqGgODT9_A_0e6yksYnKfb_XYyZvTIJG3IviuHjZW66t6y/pubhtml?gid=441658633&single=true" target="_blank"> 🪝요구사항 명세서 </a>

## 4. WBS
<img width="1194" height="593" alt="Image" src="https://github.com/user-attachments/assets/f1522bbe-2943-4e47-9114-fdde67de5882" />

## 5. DB 모델링
### 논리 모델링
<img width="2893" height="2208" alt="Image" src="https://github.com/user-attachments/assets/739ca6de-c53b-4796-838e-92823d622fae" />

### 물리 모델링
<img width="3054" height="1671" alt="Image" src="https://github.com/user-attachments/assets/9621785f-9daf-4159-b9bd-1355d615fef8" />

## 6. DDL
<details>
  <summary>member 관련 테이블</summary>
  
  ```SQL
CREATE TABLE member (
	 id 	integer	PRIMARY KEY AUTO_INCREMENT,
	 name 	varchar(255)	NOT NULL,
	 gender  char NOT NULL check(gender IN ('F', 'M')),
	 birth 	date	NOT NULL,
	 phone 	varchar(255)	NOT NULL,
	 email 	varchar(255)	NOT NULL,
	 nickname 	varchar(255)	NOT NULL,
	 password 	varchar(255)	NOT NULL,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 last_login_at 	datetime	NULL,
	 score 	integer	NOT NULL	DEFAULT 100,
	 profile_rename 	varchar(255)	NULL,
	 profile_path 	varchar(255)	NULL,
	 is_matching_active 	tinyint(1)	NOT NULL,
	 auth_status 	tinyint(1)	NOT NULL,
	 status_id 	integer	NOT NULL,
	 rank_id 	integer	NOT NULL,
	 CONSTRAINT uk_member_email UNIQUE (email),
	 CONSTRAINT uk_member_nickname UNIQUE (nickname),
	 CONSTRAINT uk_member_phone UNIQUE (phone)
);

CREATE TABLE member_info (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 member_id 	integer	NOT NULL,
	 preference_id integer	NOT NULL
);

CREATE TABLE  member_preference  (
	 id 	integer	PRIMARY KEY AUTO_INCREMENT,
	 member_id 	integer	NULL,
	 preference_id 	integer	NOT NULL
);

CREATE TABLE  rank  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 name 	varchar(255)	NOT NULL,
	 scope 	integer	NOT NULL,
	 weight   double NOT NULL,
	 CONSTRAINT uk_rank_name UNIQUE (name)
); 

CREATE TABLE  member_status  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 name 	VARCHAR(255)	NOT NULL,
	 CONSTRAINT uk_member_status_name UNIQUE (name)
);

CREATE TABLE  member_report  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 reason 	varchar(255)	NOT NULL,
	 admin_status 	char	NOT NULL check(admin_status IN ('Y', 'N', 'U')),
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 updated_by 	datetime	NULL,
	 report_id 	integer	NOT NULL,
	 member_id 	integer	NULL,
	 target_member_id 	integer	NULL
);

CREATE TABLE  login_history  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 login_at 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 type 	tinyint(1)	NOT NULL,
	 device 	VARCHAR(255)	NULL,
	 ip 	VARCHAR(255)	NULL,
	 member_id 	integer	NULL
);

CREATE TABLE  languages  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT, 
	 name 	varchar(255)	NOT NULL,
	 national varchar(255) NOT NULL,
	 CONSTRAINT uk_language UNIQUE (name)
);

CREATE TABLE  member_language  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 language_id 	integer	NOT NULL,
	 member_id 	integer	NULL
);

CREATE TABLE  preference  (
	 id 	integer	PRIMARY KEY	,
	 name 	varchar(255) NOT NULL,
	 parent_id 	integer	NULL,
	 CONSTRAINT uk_preference_name UNIQUE (name)
);

CREATE TABLE  password_history  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 updated_by 	datetime	NOT NULL,
	 member_id 	integer	NULL
);

CREATE TABLE  member_status_history  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 reason 	VARCHAR(255)	NULL,
	 member_id 	integer	NULL,
	 admin_id 	integer	NULL,
	 previous_status_id 	integer	NOT NULL,
	 new_status_id 	integer	NOT NULL
);

CREATE TABLE  report  (
	 id 	integer	PRIMARY KEY,
	 name 	varchar(255)	NOT NULL
);
```
</details>


<details>
  <summary>관리자 관련 테이블</summary>
  
  ```SQL
  CREATE TABLE  admin  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 name 	varchar(255)	NOT NULL,
	 email 	varchar(255)	NOT NULL,
	 nickname 	varchar(255)	NOT NULL,
	 password 	varchar(255)	NOT NULL,
	 CONSTRAINT uk_admin_email UNIQUE (email),
	 CONSTRAINT uk_admin_nickname UNIQUE (nickname)
);

CREATE TABLE  member_ban  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 reason 	varchar(255)	NULL,
	 start_date 	datetime	NOT NULL,
	 end_date 	datetime	NOT NULL,
	 ban_rule_id 	integer	NOT NULL,
	 member_id 	integer	NULL,
	 admin_id 	integer	NULL
);

CREATE TABLE  ban_rule  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 name 	varchar(255)	NOT NULL,
	 days 	integer	NOT NULL
);

CREATE TABLE  blacklist  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 name 	varchar(255)	NOT NULL,
	 birth 	date	NOT NULL,
	 phone 	varchar(255)	NOT NULL,
	 admin_id 	integer	NULL,
	 blacklist_rule_id 	integer	NOT NULL
);

CREATE TABLE  blacklist_rule  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 name 	VARCHAR(255)	NOT NULL
);

CREATE TABLE  notice  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 title 	varchar(255)	NOT NULL,
	 content 	text	NOT NULL,
	 created_by datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 admin_id 	integer	NOT NULL
);
```
</details>

<details>
  <summary>커뮤니티 관련 테이블</summary>

```SQL
CREATE TABLE IF NOT EXISTS board
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS post 
(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 title VARCHAR(255) NOT NULL,
	 content TEXT NOT NULL,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 updated_by DATETIME NULL,  
	 is_deleted tinyint(1) NOT NULL DEFAULT 0 COMMENT '게시글 삭제 여부',  
	 start_date DATETIME NULL COMMENT '모임 시작일',
	 end_date DATETIME NULL COMMENT '모임 종료일' ,
	 views INTEGER NOT NULL	DEFAULT 0 COMMENT '조회수',
	 recruitment_capacity INTEGER NULL COMMENT '모집 인원 수',
	 recruitment_status INTEGER NULL COMMENT '모집 상태',
	 recruitment_deadline DATETIME NULL COMMENT '모집 마감일',
	 current_count INTEGER NULL COMMENT '모집 확정 인원 수',  
	 member_id INTEGER NULL,
	 board_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS likes  
(
	 id INTEGER PRIMARY  KEY  AUTO_INCREMENT ,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 post_id INTEGER NOT NULL,
	 member_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS bookmark  
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 post_id INTEGER NOT NULL,
	 member_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS post_image 
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 origin_name VARCHAR(255) NOT NULL COMMENT '원본 파일명',
	 renaming VARCHAR(255) NOT NULL COMMENT '리네임명',
	 thumbnail INTEGER NOT NULL COMMENT '썸네일 이미지 ID',
	 path VARCHAR(255) NOT NULL COMMENT '이미지 저장 경로',
	 post_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS reply  
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT ,
	 content VARCHAR (600) NOT NULL,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 updated_by DATETIME NULL ,
	 parent_id INTEGER NULL COMMENT '부모 댓글 ID',
	 post_id INTEGER NOT NULL,
	 member_id INTEGER NULL
);

CREATE TABLE IF NOT EXISTS reply_image
(
	 id INTEGER	PRIMARY KEY AUTO_INCREMENT,
	 origin_name VARCHAR(255) NOT NULL,
	 renaming VARCHAR(255) NOT NULL,
	 path VARCHAR(255) NOT NULL,
	 reply_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS board_report
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 reason VARCHAR(2000) NOT NULL ,
	 created_by datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 post_id INTEGER NULL,
	 reply_id INTEGER NULL,
	 report_id INTEGER NOT NULL,
	 member_id INTEGER NULL,
	 admin_status CHAR NOT NULL DEFAULT 'U' CHECK(admin_status IN ('Y', 'N', 'U')),
   CONSTRAINT ch_board_report_member_member_id CHECK(CHAR_LENGTH(reason) >= 40)
);

ALTER TABLE board_report 
ADD CONSTRAINT fk_board_report_post_post_id FOREIGN KEY(post_id) REFERENCES post(id);

ALTER TABLE board_report 
ADD CONSTRAINT fk_board_report_reply_reply_id FOREIGN KEY(reply_id) REFERENCES reply(id);

ALTER TABLE board_report 
ADD CONSTRAINT fk_board_report_report_report_id FOREIGN KEY(report_id) REFERENCES report(id);

ALTER TABLE board_report 
ADD CONSTRAINT fk_board_report_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);


ALTER TABLE reply_image 
ADD CONSTRAINT fk_reply_image_reply_reply_id FOREIGN KEY(reply_id) REFERENCES reply(id);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_post_post_id FOREIGN KEY (post_id) REFERENCES post(id);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_member_member_id FOREIGN KEY (member_id) REFERENCES member(id);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_reply_parent_id FOREIGN KEY (parent_id) REFERENCES reply(id) ON DELETE CASCADE;

ALTER TABLE post_image 
ADD CONSTRAINT fk_post_image_post_post_id FOREIGN KEY (post_id) REFERENCES post(id);

ALTER TABLE bookmark 
ADD CONSTRAINT fk_bookmark_post_post_id FOREIGN KEY(post_id) REFERENCES post(id);

ALTER TABLE bookmark 
ADD CONSTRAINT  fk_bookmark_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);

ALTER TABLE likes 
ADD CONSTRAINT fk_likes_post_post_id FOREIGN KEY (post_id) REFERENCES post(id);

ALTER TABLE likes 
ADD CONSTRAINT fk_likes_member_member_id FOREIGN KEY (member_id) REFERENCES member(id);

ALTER TABLE post 
ADD CONSTRAINT fk_post_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);

ALTER TABLE post 
ADD CONSTRAINT fk_post_member_board_id FOREIGN KEY(board_id) REFERENCES board(id);
```
</details>

<details>
	<summary>매칭 관련 테이블</summary>

 ```SQL
CREATE TABLE  matching  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 status 	tinyint(1)	NOT NULL,
	 start_date datetime NOT NULL
);

CREATE TABLE  member_matching  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 status 	char	NOT NULL,
	 certification 	tinyint(1)	NOT NULL,
	 member_id 	integer	NULL,
	 matching_id 	integer	NOT NULL,
	 CONSTRAINT ch_member_matching_status check(status IN ('Y', 'N'))
);

CREATE TABLE  group_review  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 score 	integer	NOT NULL,
	 review 	varchar(2000)	NULL,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 target_member_id 	integer	NULL,
	 join_request_id integer NOT NULL
);

CREATE TABLE  join_request  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 status 	char	NOT NULL ,
	 certification 	tinyint(1)	NOT NULL,
	 post_id 	integer	NOT NULL,
	 member_id 	integer	NULL,
	 CONSTRAINT ch_join_request_status check(status IN ('Y', 'N', 'U'))
);

CREATE TABLE  matching_review  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 score 	integer	NOT NULL,
	 review 	varchar(2000)	NULL,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 target_member_id 	integer	NULL
);
```
</details>

<details>
	<summary>제약조건</summary>

 ```SQL

ALTER TABLE member
	ADD CONSTRAINT fk_member_rank_rank_id FOREIGN KEY (rank_id) REFERENCES rank (id),
	ADD CONSTRAINT fk_member_member_status_status_id FOREIGN KEY (status_id) REFERENCES member_status (id);

ALTER TABLE member_info
	ADD CONSTRAINT fk_member_info_member_member_id FOREIGN KEY (member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_info_preference_preference_id FOREIGN KEY (preference_id) REFERENCES preference (id);

ALTER TABLE member_preference
	ADD CONSTRAINT fk_member_preference_member_member_id FOREIGN KEY (member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_preference_member_preference_id FOREIGN KEY (preference_id) REFERENCES preference (id);

ALTER TABLE member_report
	ADD CONSTRAINT fk_member_report_member_member_id FOREIGN KEY (member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_report_member_target_member_id FOREIGN KEY (target_member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_report_report_report_id FOREIGN KEY (report_id) REFERENCES report (id);

ALTER TABLE login_history
	ADD CONSTRAINT fk_login_history_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);

ALTER TABLE member_language
	ADD CONSTRAINT fk_member_language_member_member_id FOREIGN KEY (member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_language_languages_lang_id FOREIGN KEY (language_id) REFERENCES languages (id);

ALTER TABLE preference
	ADD CONSTRAINT fk_preference_preference_parent_id FOREIGN KEY (parent_id) REFERENCES preference (id);

ALTER TABLE password_history
	ADD CONSTRAINT fk_password_history_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);

ALTER TABLE member_status_history
	ADD CONSTRAINT fk_member_status_history_member_member_id FOREIGN KEY (member_id) REFERENCES member (id),
	ADD CONSTRAINT fk_member_status_history_admin_admin_id FOREIGN KEY (admin_id) REFERENCES admin (id),
	ADD CONSTRAINT fk_member_status_history_previous_status_id FOREIGN KEY (previous_status_id) REFERENCES member_status (id),
	ADD CONSTRAINT fk_member_status_history_new_status_id FOREIGN KEY (new_status_id) REFERENCES member_status (id);
	
ALTER TABLE member_ban
	ADD CONSTRAINT fk_member_ban_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);

ALTER TABLE member_ban
	ADD CONSTRAINT fk_member_ban_admin_admin_id FOREIGN KEY (admin_id) REFERENCES admin (id);

ALTER TABLE member_ban
	ADD CONSTRAINT fk_member_ban_ban_rule_ban_rule_id FOREIGN KEY (ban_rule_id) REFERENCES ban_rule (id);

ALTER TABLE blacklist
	ADD CONSTRAINT fk_blacklist_blacklist_rule_blacklist_rule_id FOREIGN KEY (blacklist_rule_id) REFERENCES blacklist_rule (id);

ALTER TABLE blacklist
	ADD CONSTRAINT fk_blacklist_admin_admin_id FOREIGN KEY (admin_id) REFERENCES admin (id);

ALTER TABLE notice
	ADD CONSTRAINT fk_notice_admin_admin_id FOREIGN KEY (admin_id) REFERENCES admin (id);

 ALTER TABLE member_matching ADD CONSTRAINT fk_member_matching_member_member_id FOREIGN KEY (member_id) REFERENCES member (id)
 ALTER TABLE member_matching ADD CONSTRAINT fk_member_matching_matching_matching_id FOREIGN KEY (matching_id) REFERENCES matching (id)
 
 ALTER TABLE group_review ADD CONSTRAINT fk_group_review_member_matching_id FOREIGN KEY (join_request_id ) REFERENCES join_request(id)
 
 ALTER TABLE join_request ADD CONSTRAINT fk_join_request_member_member_id FOREIGN KEY (member_id) REFERENCES member (id)
 ALTER TABLE join_request ADD CONSTRAINT fk_join_request_post_post_id FOREIGN KEY (post_id) REFERENCES post (id)
 
 ALTER TABLE matching_review ADD CONSTRAINT fk_matching_review_join_request_id FOREIGN KEY (id) REFERENCES member_matching(id)
```
</details>


## 7. DML
- 회원

- 매칭 & 커뮤니티

- 관리자


## 8. Test Case
<details>
	<summary>회원</summary>
</details>

<details>
	<summary>게시판</summary>
	<details>
		<summary>동행 게시판</summary>
		<br><p>- 등록된 게시글 확인</p>
		<img width="3158" height="1178" alt="Image" src="https://github.com/user-attachments/assets/0045bed9-f8c8-46f1-b51d-e0c5e00a1919" />
		<br><br><p>- 해당 게시글의 동행 요청자 조회</p>
		<img width="3076" height="1138" alt="Image" src="https://github.com/user-attachments/assets/5717cc72-f45a-46b8-a2cc-050afb19aa74" />
		<br><br><p>- 동행 요청</p>
		<img width="2774" height="1222" alt="Image" src="https://github.com/user-attachments/assets/f5c8b92d-6b8f-46f2-8c29-f602febb1112" />
		<br><br><p>- 동행 요청 수락/거절</p>
		<img width="2912" height="1134" alt="Image" src="https://github.com/user-attachments/assets/a3df6287-0610-4c4f-8e06-2ac580cef5af" />
		<br><br><p>- 동행 확정인원수 갱신 트리거</p>
		<img width="826" height="655" alt="Image" src="https://github.com/user-attachments/assets/e3552ffe-a156-470e-b3c6-350db62d3098" />
		<br><br><p>- 강퇴 시 작동 트리거</p>
		<img width="692" height="755" alt="Image" src="https://github.com/user-attachments/assets/0a8fce72-13df-4835-9544-b443510ee329" />
		<br><br><p>- 동행 게시글의 모집 확정된 인원수 확인</p>
		<img width="1229" height="626" alt="Image" src="https://github.com/user-attachments/assets/5f979aee-2f2c-4501-bd9a-ed1e3a9b837b" />
		<br><br><p>- 모집인원수를 채우면 자동 마감</p>
		<img width="2824" height="1160" alt="Image" src="https://github.com/user-attachments/assets/8dfb4f46-4fee-4af5-8a29-debc516e905c" />
		<br><br><p>- 자동마감 프로시저</p>
		<img width="2512" height="1190" alt="Image" src="https://github.com/user-attachments/assets/19d9d81b-f990-414e-9eed-6b9e9a9508ec" />
	</details>
	<details>
		<summary>신고</summary>
		<br><p>- 게시글 및 댓글 신고</p>
		<img width="3420" height="1080" alt="Image" src="https://github.com/user-attachments/assets/0863fdef-59b3-4412-9db0-1a1666771faf" />
		<br><br><p>- 게시글 및 댓글 신고 관리자 승인 및 거절</p>
		<img width="2158" height="1288" alt="Image" src="https://github.com/user-attachments/assets/e99a2b47-cbbd-4576-bd5e-e3b9b4b91614" />
		<br><br><p>- 누적된 게시글/댓글 신고 수 확인 트리거</p>
		<img width="1494" height="1374" alt="Image" src="https://github.com/user-attachments/assets/0ebdb0a4-363c-45f3-bde1-dbe167174882" />
		<img width="1512" height="1374" alt="Image" src="https://github.com/user-attachments/assets/81ad4881-13b0-4849-9d22-2ef01a45cd02" />
		<br><br><p>- 같은 회원이 10번 이상 신고당할 시 블랙리스트</p>
		<img width="2888" height="1036" alt="Image" src="https://github.com/user-attachments/assets/12b5e2b7-a0f9-4645-9606-eb028ea2ba14" />
	</details>
</details>

<details>
	<summary>매칭</summary>
	<br><p>- 매칭 제안 및 응답 </p>
	<img width="1232" height="553" alt="Image" src="https://github.com/user-attachments/assets/5b4e7dea-816b-419e-994d-b19468d1d088" />
	<br><p>- 매칭 5회 연속 거절로 인한 매칭 제재 </p>
	<img width="1232" height="553" alt="Image" src="https://github.com/user-attachments/assets/5b29178e-f4fc-4e60-aa98-01c9ab01f832" />
	<br><p>- 매칭 제안 및 응답 </p>
	<img width="1232" height="553" alt="Image" src="https://github.com/user-attachments/assets/147cb424-a83d-4b2e-9e41-2fa830359081" />

  
</details>

<details>
	<summary>관리자</summary>
	<details>
		<summary>1:1 매칭 성사 조회</summary>
		<br><p>- member_matching 테이블 조회</p>
		<img width="1232" height="553" alt="Image" src="https://github.com/user-attachments/assets/7bc631c0-4309-46b3-9d27-93e45bd867b9" />
		<br><br><p>- 매칭 아이디가 같고 certification이 1인 행만 조회</p>
		<img width="866" height="637" alt="Image" src="https://github.com/user-attachments/assets/7539995f-3d47-473a-b263-e07bff11396c" />
	</details>
	<details>
		<summary>게시글 모임 성사 조회</summary>
		<br><p>- join_request 테이블 조회</p>
  		<img width="1162" height="446" alt="Image" src="https://github.com/user-attachments/assets/b825f37f-044e-4b7a-b7db-18b19fb312b5" />
		<br><br><p>- 게시글 아이디가 같고 certification이 1인 행의 멤버ID, 이름, 성별, 게시글ID, 제목 조회</p>
		<img width="1052" height="533" alt="Image" src="https://github.com/user-attachments/assets/25000dcb-2d69-42c6-84c6-3d4c698cd765" />
		<br><br><p>- 조회한 것과 게시글ID의 제목이 같은지 확인</p>
		<img width="775" height="272" alt="Image" src="https://github.com/user-attachments/assets/77e37001-70ee-42fe-9156-8cdadf471209" />
		<br><br><p>- 조회한 것과 회원ID의 정보가 같은지 확인</p>
		<img width="655" height="281" alt="Image" src="https://github.com/user-attachments/assets/bab114ce-a89d-4c3f-b233-dd5be6de3cdd" />
	</details>
	<details>
		<summary>정지 등록 & 해제</summary>
		<br><p>- member_ban 테이블에 어떤 행도 없음을 확인</p>
		<img width="1506" height="277" alt="Image" src="https://github.com/user-attachments/assets/c054c01f-49fb-485f-9c53-ab30bbe32583" />
		<br><br><p>- 회원을 정지시키고 member_ban 테이블 조회</p>
		<img width="1452" height="297" alt="Image" src="https://github.com/user-attachments/assets/5f07b880-95a7-476f-be49-6e4fde9bc961" />
		<br><br><p>- 시스템 시간이 end_date가 되도록 end_date값을 같은 날 18시 45분으로 업데이트</p>
		<img width="807" height="303" alt="Image" src="https://github.com/user-attachments/assets/0fa7423b-c746-43e1-a886-afa2092479ab" />
		<br><br><p>- member 테이블을 조회하여 회원번호가 2번이 아직 상태가 3(정지)인 것을 확인</p>
		<img width="1452" height="340" alt="Image" src="https://github.com/user-attachments/assets/a4f6b781-a1fa-4a56-b6cc-ba64aeb4fe0f" />
		<br><br><p>- 1분마다 end_date가 시스템 시간을 넘는지 확인하고 넘으면 다시 상태를 1(정상)으로 update하는 trigger를 설정</p>
		<img width="806" height="253" alt="Image" src="https://github.com/user-attachments/assets/388e146e-b515-4a69-99ee-72a876851f6b" />
		<br><br><p>- 시스템 시간이 18시 45분이 되어 member테이블을 조회하여 회원번호 2번의 상태가 1(정상)으로 돌아온 것을 확인</p>
		<img width="1557" height="707" alt="Image" src="https://github.com/user-attachments/assets/82619ff4-6ca7-4fcd-bb7a-7fb7f6bdccd0" />
	</details>
</details>

## 9. 회고록

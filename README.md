
# Joy-In🚤
<img width="600" height="380" alt="Image" src="https://github.com/user-attachments/assets/0a37d6b1-7b43-4073-8c5c-39fd128eb43a" />

## 프로젝트 소개

## 팀원
|<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/4da0c5f9-3d48-44d2-ae21-860a027a4e1c" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/3200b60c-20c6-495d-87b8-a4fadff9827a" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/ef2e5d74-09ed-4d47-b1b7-34ae8a607d19" /> |<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/10fa156a-1f3f-4d71-a2d7-944723c7c26d" /> | |
|:---:|:---:|:---:|:---:|:---:|
|강지륜|강형규|민수현|윤서진|이승건|

## 1. 개발 환경

## 2. 주요 기능

## 3. 요구사항 명세서
<img width="1826" height="1804" alt="Image" src="https://github.com/user-attachments/assets/e0f04d94-cead-4a10-aeb3-3f6ad48796bf" />

## 4. WBS
<img width="3140" height="1458" alt="Image" src="https://github.com/user-attachments/assets/d7a6d22b-4e5d-4fd4-8132-b37a8c688962" />

## 5. DB 모델링
### 논리 모델링
<img width="1447" height="1532" alt="Image" src="https://github.com/user-attachments/assets/ab583b0d-a8d1-46cb-8067-b96c1548b026" />

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


## 7. DML

## 8. Test Case

## 9. 회고록

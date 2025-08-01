-- Member 관련 테이블 

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
	 score 	integer	NOT NULL	DEFAULT 1000,
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
	 updated_by 	datetime	NOT NULL,
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
	 member_id 	VARCHAR(255)	NULL
);

CREATE TABLE  languages  (
	 id 	varchar(255) PRIMARY KEY,
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
	 member_id 	VARCHAR(255)	NULL,
	 admin_id 	VARCHAR(255)	NULL,
	 previous_status_id 	VARCHAR(255)	NOT NULL,
	 new_status_id 	VARCHAR(255)	NOT NULL
);

CREATE TABLE  report  (
	 id 	integer	PRIMARY KEY,
	 name 	varchar(255)	NOT NULL
);

-- 관리자 관련
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
	 admin_id 	integer	NOT NULL,
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
	 created_by datetime NOT NULL,
	 admin_id 	integer	NOT NULL
);

-- 커뮤니티 관련

CREATE TABLE  post  (
	 id 	integer	PRIMARY KEY	AUTO_INCREMENT,
	 title 	varchar(255)	NOT NULL,
	 content 	mediumtext	NOT NULL,
	 created_by 	datetime	NOT NULL	DEFAULT now(),
	 updated_by 	datetime	NOT NULL,
	 start_date 	datetime	NULL,
	 end_date 	datetime	NULL,
	 views 	integer	NOT NULL	DEFAULT 0,
	 status 	integer	NULL	DEFAULT 0,
	 recruit_status 	integer	NULL,
	 recruit_end_date 	datetime	NULL,
	 member_id 	integer	NULL,
	 board_id 	integer	NOT NULL
);

CREATE TABLE  post_image  (
	 id 	integer	NOT NULL	primary key auto_increment,
	 origin_name 	varchar(255) NOT NULL,
	 renaming 	varchar(255)	NOT NULL,
	 thumbnail 	integer nOT NULL,
	 path 	varchar(255)	NOT NULL,
	 post_id 	integer	NOT NULL
);

CREATE TABLE  bookmark  (
	 id 	integer	primary key auto_increment,
	 created_by 	datetime NOT NULL DEFAULT now(),
	 post_id 	integer	NOT NULL,
	 member_id 	integer	NOT NULL
);

CREATE TABLE  board_report  (
	 id 	integer	primary key auto_increment,
	 reason VARCHAR(2000) NOT NULL ,
	 created_by 	datetime	NOT NULL,
	 post_id 	integer	NULL,
	 reply_id 	integer	NULL,
	 report_id 	integer	NOT NULL,
	 member_id 	integer	NULL,
     CONSTRAINT ch_board_report_member_member_id check(CHAR_LENGTH(reason) >= 40)
);

CREATE TABLE  board  (
	 id 	integer	NOT NULL	primary key auto_increment,
	 name 	varchar(255)	NOT NULL
);

CREATE TABLE  reply  (
	 id 	integer	primary key auto_increment,
	 content 	varchar(255)	NOT NULL,
	 created_by 	datetime	NOT NULL,
	 updated_by 	datetime	NOT NULL,
	 parent_id 	integer	NULL,
	 post_id 	integer	NOT NULL,
	 member_id integer NULL
);

CREATE TABLE  reply_image  (
	 id 	integer	primary key auto_increment,
	 origin_name 	varchar(255)	NOT NULL,
	 renaming 	varchar(255)	NOT NULL,
	 path 	varchar(255)	NOT NULL,
	 reply_id 	integer	NOT NULL
);

CREATE TABLE  likes  (
	 id 	integer	primary key auto_increment,
	 created_by 	datetime	NOT NULL,
	 post_id 	integer	NOT NULL,
	 member_id 	integer	NOT NULL
);

-- 매칭 관련
CREATE TABLE  matching  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 status 	tinyint(1)	NOT NULL
);

CREATE TABLE  member_matching  (
	 id integer PRIMARY KEY AUTO_INCREMENT,
	 status 	char	NOT NULL ,
	 certification 	tinyint(1)	NOT NULL,
	 member_id 	integer	NULL,
	 matching_id 	integer	NOT NULL,
	 CONSTRAINT ch_member_matching_status check(status IN ('Y', 'N'))
);

CREATE TABLE  group_review  (
	 id integer PRIMARY KEY,
	 score 	integer	NOT NULL,
	 review 	varchar(2000)	NULL,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 target_member_id 	integer	NULL
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
	 id integer PRIMARY KEY,
	 score 	integer	NULL,
	 review 	varchar(2000)	NULL,
	 created_by 	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 target_member_id 	integer	NULL
);

-- fk 제약조건

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
	ADD CONSTRAINT fk_login_history_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);

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
	ADD CONSTRAINT fk_member_status_history_previous_status_id FOREIGN KEY (previous_status_id) REFERENCES member_status_history (id),
	ADD CONSTRAINT fk_member_status_history_new_status_id FOREIGN KEY (new_status_id) REFERENCES member_status_history (id);
	

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

ALTER TABLE post_image ADD CONSTRAINT fk_post_image_post_post_id FOREIGN KEY (post_id) REFERENCES post (id) ;
ALTER TABLE bookmark ADD CONSTRAINT fk_bookmark_post_post_id FOREIGN KEY(post_id) REFERENCES post(id);
ALTER TABLE bookmark ADD CONSTRAINT  fk_bookmark_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);
ALTER TABLE board_report ADD CONSTRAINT fk_board_report_post_post_id FOREIGN KEY(post_id) REFERENCES post(id);
ALTER TABLE board_report ADD CONSTRAINT fk_board_report_reply_reply_id FOREIGN KEY(reply_id) REFERENCES reply(id);
ALTER TABLE board_report ADD CONSTRAINT fk_board_report_report_report_id FOREIGN KEY(report_id) REFERENCES report(id);
ALTER TABLE board_report ADD CONSTRAINT fk_board_report_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);
ALTER TABLE reply ADD CONSTRAINT fk_reply_post_post_id FOREIGN KEY (post_id) REFERENCES post (id);
ALTER TABLE reply ADD CONSTRAINT fk_reply_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);
ALTER TABLE reply ADD CONSTRAINT fk_reply_reply_reply_id FOREIGN KEY (parent_id) REFERENCES reply (id);
ALTER TABLE reply_image ADD CONSTRAINT fk_reply_image_reply_reply_id FOREIGN KEY(reply_id) REFERENCES reply (id);
ALTER TABLE post ADD CONSTRAINT fk_post_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);
ALTER TABLE post ADD CONSTRAINT fk_post_member_board_id FOREIGN KEY(board_id) REFERENCES board(id);
ALTER TABLE likes ADD CONSTRAINT fk_likes_post_id_post_post_id FOREIGN KEY (post_id) REFERENCES post (id);
ALTER TABLE likes ADD CONSTRAINT fk_likes_member_member_id  FOREIGN KEY (member_id) REFERENCES member (id);

ALTER TABLE member_matching ADD CONSTRAINT fk_member_matching_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);
ALTER TABLE member_matching ADD CONSTRAINT fk_member_matching_matching_matching_id FOREIGN KEY (matching_id) REFERENCES matching (id);
ALTER TABLE group_review ADD CONSTRAINT fk_group_review_member_matching_id FOREIGN KEY (id) REFERENCES member_matching (id);
ALTER TABLE join_request ADD CONSTRAINT fk_join_request_member_member_id FOREIGN KEY (member_id) REFERENCES member (id);
ALTER TABLE join_request ADD CONSTRAINT fk_join_request_post_post_id FOREIGN KEY (post_id) REFERENCES post (id);
ALTER TABLE matching_review ADD CONSTRAINT fk_matching_review_join_request_id FOREIGN KEY (id) REFERENCES join_request (id);
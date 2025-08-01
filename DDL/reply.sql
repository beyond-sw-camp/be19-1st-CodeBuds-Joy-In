CREATE TABLE IF NOT EXISTS reply  
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT ,
	 content VARCHAR (600) NOT NULL,
	 created_by DATETIME NOT NULL,
	 updated_by DATETIME NULL ,
	 parent_id INTEGER NULL COMMENT '부모 댓글 ID',
	 post_id INTEGER NOT NULL,
	 member_id INTEGER NULL
);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_post_post_id FOREIGN KEY (post_id) REFERENCES post(id);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_member_member_id FOREIGN KEY (member_id) REFERENCES member(id);

ALTER TABLE reply 
ADD CONSTRAINT fk_reply_reply_parent_id FOREIGN KEY (parent_id) REFERENCES reply(id) ON DELETE CASCADE;
CREATE TABLE IF NOT EXISTS bookmark  
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 post_id INTEGER NOT NULL,
	 member_id INTEGER NOT NULL
);

ALTER TABLE bookmark 
ADD CONSTRAINT fk_bookmark_post_post_id FOREIGN KEY(post_id) REFERENCES post(id);

ALTER TABLE bookmark 
ADD CONSTRAINT  fk_bookmark_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);
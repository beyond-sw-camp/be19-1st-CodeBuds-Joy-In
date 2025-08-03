CREATE TABLE IF NOT EXISTS reply_image
(
	 id INTEGER	PRIMARY KEY AUTO_INCREMENT,
	 origin_name VARCHAR(255) NOT NULL,
	 renaming VARCHAR(255) NOT NULL,
	 path VARCHAR(255) NOT NULL,
	 reply_id INTEGER NOT NULL
);

ALTER TABLE reply_image 
ADD CONSTRAINT fk_reply_image_reply_reply_id FOREIGN KEY(reply_id) REFERENCES reply(id);
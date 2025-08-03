CREATE TABLE IF NOT EXISTS post_image 
(
	 id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 origin_name VARCHAR(255) NOT NULL COMMENT '원본 파일명',
	 renaming VARCHAR(255) NOT NULL COMMENT '리네임명',
	 thumbnail INTEGER NOT NULL COMMENT '썸네일 이미지 ID',
	 path VARCHAR(255) NOT NULL COMMENT '이미지 저장 경로',
	 post_id INTEGER NOT NULL
);

ALTER TABLE post_image 
ADD CONSTRAINT fk_post_image_post_post_id FOREIGN KEY (post_id) REFERENCES post(id);
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
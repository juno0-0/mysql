create table review_reply(
	rno int(10),
	bno int(10) not null,
	reply varchar(2000) not null,
	replyer varchar(200) not null,
	replydate timestamp default current_timestamp,
	updatedate timestamp
);
alter table review_reply add constraint reply_pk primary key(rno);
alter table review_reply add constraint reply_fk foreign key(bno) references review_board(bno) on delete cascade;

select * from review_reply;

CREATE TABLE seq_mysql(
	id INT NOT NULL, 
	seq_name VARCHAR(50) NOT NULL
);

DROP FUNCTION IF EXISTS get_seq;
DROP FUNCTION IF EXISTS reply_seq;
 
/* Auto_increment 적용 */
DELIMITER $$
 
CREATE FUNCTION reply_seq (p_reply_seq VARCHAR(45))
 
RETURNS INT READS SQL DATA
 
BEGIN
 
DECLARE RESULT_ID INT;
 
UPDATE seq_mysql SET id = LAST_INSERT_ID(id+1) 
 
 WHERE seq_name = p_reply_seq;
 
SET RESULT_ID = (SELECT LAST_INSERT_ID());
 
RETURN RESULT_ID;
 
END $$
 
DELIMITER ;

show function status where db = 'review_db';

INSERT INTO seq_mysql VALUES (0, 'review_reply');
select get_seq('review_reply');
select get_seq('review_board');
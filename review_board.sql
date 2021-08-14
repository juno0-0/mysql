create database review_db default character set utf8;
show databases;
use review_db;

CREATE TABLE seq_mysql(
	id INT NOT NULL, 
	seq_name VARCHAR(50) NOT NULL
);

DROP FUNCTION IF EXISTS get_seq;
 
/* Auto_increment 적용 */
DELIMITER $$
 
CREATE FUNCTION get_seq (p_seq_name VARCHAR(45))
 
RETURNS INT READS SQL DATA
 
BEGIN
 
DECLARE RESULT_ID INT;
 
UPDATE seq_mysql SET id = LAST_INSERT_ID(id+1) 
 
 WHERE seq_name = p_seq_name;
 
SET RESULT_ID = (SELECT LAST_INSERT_ID());
 
RETURN RESULT_ID;
 
END $$
 
DELIMITER ;

show function status where db = 'review_db';

INSERT INTO seq_mysql VALUES (0, 'review_board');
select get_seq('review_board');

create table review_board(
	bno int(10) primary key,
	title varchar(200) not null,
	content varchar(2000) not null,
	writer varchar(200) not null,
	regdate timestamp default current_timestamp,
	updatedate timestamp
);

select * from review_board;
desc review_board;
delete from review_board;

insert into review_board(bno, title, content, writer) values (1, 'test', 'test', 'test');
insert into review_board(bno, title, content, writer, updatedate) values (get_seq('review_board'), 'test', 'test', 'test', sysdate());

show indexes in review_board;
alter table review_board drop primary key;
alter table review_board add constraint board_pk primary key(bno);
alter table review_board add replycnt int(10) default 0;

delete from review_board where bno = 21;

SELECT BNO, TITLE, CONTENT, WRITER, REGDATE, UPDATEDATE
		FROM
			(SELECT @ROWNUM := @ROWNUM+1 AS ROWNUM, R.BNO, R.TITLE, R.CONTENT, R.WRITER, R.REGDATE, R.UPDATEDATE
				FROM REVIEW_BOARD R, (SELECT @ROWNUM := 0) temp
				ORDER BY REGDATE DESC) A
				where title like '%a%'
				LIMIT 10 OFFSET 1;

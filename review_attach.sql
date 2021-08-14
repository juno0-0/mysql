create table review_attach(
	uuid varchar(200) not null,
	uploadpath varchar(200) not null,
	filename varchar(200) not null,
	filetype char(1) check(filetype in(0, 1)),
	bno int(10)
);

alter table review_attach add constraint attach_pk primary key(uuid);
alter table review_attach add constraint attach_fk foreign key(bno) references review_board(bno) on delete cascade;

select * from review_attach;

insert into review_attach values('test0', '20210813', 'test', '1', 21);

SELECT * FROM REVIEW_ATTACH WHERE UPLOADPATH = TO_CHAR(SYSDATE() - 1, 'YYYY\MM\DD');
SELECT * FROM REVIEW_ATTACH WHERE UPLOADPATH = date_format((curdate() - interval 1 day), '%Y%m%d');
select date_format((curdate() - interval 1 day), '%Y%m%d');

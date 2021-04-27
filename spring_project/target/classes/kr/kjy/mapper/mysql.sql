select sysdate();

drop table tbl_board

create table tbl_board(
	bno int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title varchar(200) not null,
	content varchar(2000) not null,
	writer varchar(50) not null,
	regdate datetime DEFAULT CURRENT_TIMESTAMP not null,
	updatedate datetime DEFAULT CURRENT_TIMESTAMP not null
	);

insert into tbl_board(title,content,writer)
values('테스트 제목','테스트 내용','테스트 유저');

/* AUTO_INCREMENT 다음 숫자 가져오기 */
SELECT AUTO_INCREMENT
FROM information_schema.tables
WHERE table_name = 'tbl_board'
AND table_schema = DATABASE();

update tbl_board
set title= '1', content = '2', writer = '3', updatedate = NOW()
where bno = 2;

select rownum ,bno from tbl_board order by bno desc

/* 페이징 처리를 위한  Limit 구문*/
SELECT *
FROM tbl_board
ORDER BY bno
LIMIT 0, 10;

select count(bno) from tbl_board
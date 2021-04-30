select sysdate();

drop table tbl_board
drop table tbl_reply

create table tbl_board(
	bno int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title varchar(200) not null,
	content varchar(2000) not null,
	writer varchar(50) not null,
	regdate datetime DEFAULT CURRENT_TIMESTAMP not null,
	updatedate datetime DEFAULT CURRENT_TIMESTAMP not null
	);

	
create table tbl_reply(
	rno int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bno int(10) not null,
	reply varchar(1000) not null,
	replyer varchar(50) not null,
	replydate datetime DEFAULT CURRENT_TIMESTAMP not null,
	replyupdatedate datetime DEFAULT CURRENT_TIMESTAMP not null,
	FOREIGN KEY (bno) REFERENCES tbl_board (bno)
);	
	
select * from tbl_reply
	
	
insert into tbl_board(title,content,writer)
values('테스트 제목','테스트 내용','테스트 유저');

insert into tbl_reply (bno,reply,replyer)
values(#{bno},#{reply},#{replyer})


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

/* 동적 SQL로 검색 처리를 하기 위한  구문*/
select *
from tbl_board
where title like "%"'등록'"%"
order by bno
LIMIT 0,10;

select *
		from tbl_board
		where bno > 0
		<trim prefix="AND">
		<foreach collection="typeArr" item ="type">
			<if test = "type == 't'.toString()">
				title like #{keyword}				
			</if>
			<if test = "type == 'c'.toString()">
				content like #{keyword}				
			</if>
			<if test = "type == 'w'.toString()">
				writer like #{keyword}	
			</if>
		</foreach>
		</trim>
		order by bno desc
		limit #{startNum}, #{amount};


select * from tbl_reply where bno = #{}
		
select count(bno) from tbl_board
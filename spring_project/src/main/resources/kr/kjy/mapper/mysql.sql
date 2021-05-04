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

create table tbl_attach(
	uuid varchar(100) not null,
	uploadpath varchar(200) not null,
	filename varchar(100) not null,
	filetype char(1) default 'I',
	bno int(10)
);

alter table tbl_board add (replycnt int default 0);
alter table tbl_attach add constraint pk_attach primary key(uuid);
alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);




update tbl_board 
set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

select * from tbl_board where bno = 2500;


-- 인덱스 
CREATE INDEX idx_reply ON tbl_reply (bno desc, rno asc);
show index from tbl_reply

select /*+INDEX(tbl_reply idx_reply)*/
	bno,rno,reply,replyer,replydate,replyupdatedate
	from tbl_reply
	where bno = 2500
	and rno > 0
--
	


/* AUTO_INCREMENT 다음 숫자 가져오기 */
SELECT AUTO_INCREMENT
FROM information_schema.tables
WHERE table_name = 'tbl_board'
AND table_schema = DATABASE();

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

-- 트랜잭션 예제 테이블
create table tbl_sample1( col1 varchar(500));
create table tbl_sample2( col2 varchar(50));
drop table tbl_sample2
--

select * from tbl_attach
select * from tbl_attach where uploadpath = DATE_FORMAT(date_add(now(), interval -1 day), '%Y\%m\%d')
select * from tbl_attach where uploadpath = DATE_FORMAT(now(), '%Y\%m\%d')

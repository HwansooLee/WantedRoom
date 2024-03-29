create user final identified  by 1111;
grant dba to final;

create table member(
    id varchar2(30) primary key,
    nickname varchar2(12) not null unique,
    pwd varchar2(20) not null,
    realtorNo varchar2(16) unique
);
-- 이메일 인증과 공인중개사 등록번호의 변별력을 위해
-- member table에 이름항목 추가

alter table member add name varchar2(20);
alter table member modify name not null;

create table item(
itemNo number primary key,
id varchar2(30) not null,
foreign key(id) references member (id) on delete cascade,
addr varchar2(100) not null,
deposit number default 0,
rent number default 0,
detail varchar2(100),
inDate date default sysdate,
status varchar2(8) not null check(status in ('계약가능','계약완료')));

alter table item modify deposit not null;
alter table item modify rent not null;
alter table item modify status default '계약가능';
alter table item add bcode varchar2(15) not null;

create sequence itemNoSeq;

create table itemAttach(
itemNo number not null,
foreign key(itemNo) references item(itemNo) on delete cascade,
fileName varchar2(45) not null);

create table itemTags(
itemNo number not null,
foreign key(itemNo) references item(itemNo) on delete cascade,
parking varchar2(6) check(parking in ('가능','불가능')),
elevator varchar2(4) check(elevator in ('있음','없음')),
buildingType varchar2(6) check(buildingType in ('아파트','빌라','원룸')));
alter table itemTags modify parking not null;
alter table itemTags modify elevator not null;
alter table itemTags modify buildingType not null;

create table store(
    addr varchar2(100) primary key,
    name varchar2(45) not null,
    coordX number not null,
    coordY number not null
);
-- 단 시간에 쿼리를 많이 요청하는 경우 최대 커서가 초과되는 에러가 발생할 수 있으므로 최대 커서 수를 늘려줌
ALTER SYSTEM SET open_cursors=4000 SCOPE=BOTH;
-- DB에 주소 입력 후 컬럼 추가해야 에러 안남
alter table store add lat number;
alter table store add lon number;

create table board(
boardNo number primary key,
id varchar2(30) not null,
foreign key (id) references member(id) on delete cascade,
addr varchar2(100) not null,
title varchar2(40) not null,
content varchar2(300) not null,
inDate date default sysdate,
views number default 0);
alter table board add sentiment varchar2(8) not null;
alter table board add bcode varchar2(15) not null;

create sequence boardNoSeq;

create table reply(
replyNo number primary key,
id varchar2(30) not null,
foreign key(id) references member(id) on delete cascade,
boardNo number not null,
foreign key(boardNo) references board(boardNo) on delete cascade, -- 테이블 수정
content varchar2(300) not null,
inDate date default sysdate,
likes number default 0);

create sequence replyNoSeq;

create table favorite(
id varchar2(30) not null,
foreign key(id) references member(id) on delete cascade,
itemNo number not null,
foreign key (itemNo) references item(itemNo) on delete cascade
);

-- 디버깅을 위한 임의의 회원 생성
insert into member values ('testid','testnickname','testpwd','testrealorNo');
insert into member values ('atestid','aaa','atestpwd','atestrealorNo');

-- 좋아요 기능 구현을 위해 테이블 생성
-- 좋아요 누른 사람을 저장해야한다.
create table likes(
    replyNo number,
    foreign key(replyNo) references reply(replyNo) on delete cascade, -- 테이블 수정
    id varchar2(30),
    foreign key(id) references member(id) on delete cascade
);

-- 테이블 수정을 위한 드랖
drop table likes;
drop table reply;

-- 대강 이런식으로 가져와야 할듯
select *
from (select rownum as rn, sub.*
from (select r.* , m.nickname , 
(select id from likes where id = 'qqq@qqqq'
and replyNo = l.replyNo) as nowUser -- nowUser가 null이면 false null이 아니면 해당 번호의 likesflag = true
from reply r
join member m
on m.id = r.id
left join likes l
on r.replyNo = l.replyNo
order by r.inDate desc) sub)
where rn between 1 and 5;

-- nickname(member) / content(reply) / inDate(reply) / likes(reply) for boardNo(board)
-- step 1 get replys on this board
select r.* from board b, reply r where b.boardNo=23 and r.boardNo=23;
-- step 2 add nicknames to this board
select rr.*, m.nickname
    from (select r.* from board b, reply r where b.boardNo=23 and r.boardNo=23) rr, member m
    where rr.id = m.id;
-- step 3 add who liked for each reply
select * from(
    select rrr.*, l.id as likeId, ROW_NUMBER() over(PARTITION by rrr.replyNo order by rrr.id) as rn 
        from ( select rr.*, m.nickname
            from (select r.* from board b, reply r where b.boardNo=23 and r.boardNo=23) rr, member m
            where rr.id = m.id ) rrr left join likes l on rrr.replyNo=l.replyNo
        order by rrr.replyNo desc)
    where rn<=1;


-- 항목 추가하려면 기존 테이블 정보 전부 지워주어야 한다.
delete from member;
delete from board;
delete from reply;
delete from likes;

-- 테스트용 계정 1
insert into member values ('kkk@kkkk','kkk','Kkk1234!',null,'kkk');
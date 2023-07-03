create user final identified  by 1111;
grant dba to final;

create table member(
id varchar2(30)  primary key on delete cascade,
nickname varchar2(12) not null unique,
pwd varchar2(20) not null,
realtorNo varchar2(16) unique);

create table item(
itemNo number primary key,
id varchar2(30) not null,
foreign key(id) references member (id),
addr varchar2(100) not null,
deposit number default 0,
rent number default 0,
detail varchar2(100),
inDate date default sysdate,
status varchar2(8) not null check(status in ('계약가능','계약완료')));

alter table item modify deposit not null;
alter table item modify rent not null;

create sequence itemNoSeq;

create table itemAttach(
itemNo number not null,
foreign key(itemNo) references item(itemNo),
fileName varchar2(45) not null);


create table itemTags(
itemNo number not null,
foreign key(itemNo) references item(itemNo),
parking varchar2(6) check(parking in ('가능','불가능')),
elevator varchar2(4) check(elevator in ('있음','없음')),
buildingType varchar2(6) check(buildingType in ('아파트','빌라','원룸')));

alter table itemTags modify parking not null;

alter table itemTags modify elevator not null;

alter table itemTags modify buildingType not null;

create table store(
addr varchar2(100) primary key,
name varchar2(45) not null);

create table board(
boardNo number primary key,
id varchar2(30) not null,
foreign key (id) references member(id),
addr varchar2(100) not null,
title varchar2(40) not null,
content varchar2(300) not null,
inDate date default sysdate,
views number default 0);

create sequence boardNoSeq;

create table reply(
replyNo number primary key,
id varchar2(30) not null,
foreign key(id) references member(id),
boardNo number not null,
foreign key(boardNo) references board(boardNo),
content varchar2(300) not null,
inDate date default sysdate,
likes number default 0);

create sequence replyNoSeq;

create table favorite(
id varchar2(30) not null,
foreign key(id) references member(id),
itemNo number not null,
foreign key (itemNo) references item(itemNo));

commit;


-- 디버깅을 위한 임의의 회원 생성
insert into member values ('testid','testnickname','testpwd','testrealorNo');
insert into member values ('atestid','aaa','atestpwd','atestrealorNo');

-- 좋아요 기능 구현을 위해 테이블 생성
-- 좋아요 누른 사람을 저장해야한다.
create table likes(
    replyNo number,
    foreign key(replyNo) references reply(replyNo),
    id varchar2(30),
    foreign key(id) references member(id)
);


-- 대강 이런식으로 가져와야 할듯
select *
from (select rownum as rn, sub.*
from (select r.* , m.nickname , l.replyNo as likesNo -- rno가 null이면 false null이 아니면 해당 번호의 likesflag = true
from reply r
join member m
on m.id = r.id
left join likes l
on r.replyNo = l.replyNo
order by r.inDate desc) sub)
where rn between 1 and 5;
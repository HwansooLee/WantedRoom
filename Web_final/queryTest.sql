select * from item;
select * from ITEMATTACH;
select * from ITEMTAGS;

select i.*, a.FILENAME, t.PARKING, t.ELEVATOR, t.BUILDINGTYPE 
    from item i, ITEMATTACH a, ITEMTAGS t;
        -- where addr like '%매탄동%';

-- get the first row in each itemNo partition
-- row_number must have partion by and order by in over()
select * from 
    (select i.*, a.FILENAME, t.PARKING, t.ELEVATOR, t.BUILDINGTYPE, 
    ROW_NUMBER() over(PARTITION by i.itemNo order by a.fileName) as rn
        from item i, ITEMATTACH a, ITEMTAGS t
        where i.addr like '%상계동%' and id='dde@naver.com' and i.ITEMNO = a.ITEMNO and a.ITEMNO = t.ITEMNO
        )
    where rn <= 1;

-- query for paging
select * from (
    select s.*, rownum as newRn from (
        select * from
            (select i.*, a.FILENAME, t.PARKING, t.ELEVATOR, t.BUILDINGTYPE, 
            ROW_NUMBER() over(PARTITION by i.itemNo order by a.fileName) as rn
                from item i, ITEMATTACH a, ITEMTAGS t
                where i.addr like '%상계동%' and i.ITEMNO = a.ITEMNO and a.ITEMNO = t.ITEMNO
                )
            where rn <= 1) s
    )
    where newRn > 10 and newRn <= 20;

-- combine above queries
select * from (
    select s.*, rownum as rn from (
        select * from item where ADDR like '%인계동%' order by itemNo asc) s)
    where rn>10 and rn<20;

select i.*, t.PARKING, t.ELEVATOR, t.BUILDINGTYPE from item i, itemTags t
    where i.itemNo = 5 and i.itemNo = t.itemNo;

select * from itemTags;
delete from itemTags where itemNo=19;
delete from itemAttach where itemNo=19;
delete from item where itemNo=19;

select * from member;

update item set inDate=sysdate where itemNo=22;

-- 찜하기에도 사용할듯
select *
from
(select sub2.*,
ROW_NUMBER() over(partition by sub2.replyNo order by likeId) as rn
from
(select m.nickname ,r.*,
case when l.id = 'qqq@qqqq' then 'yes'
else null
end as likeId
from reply r
join member m
on m.id = r.id
left join likes l
on r.replyNo = l.replyNo
where boardNo = 23) sub2)
where rn <= 1
;

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

-- data for test paging
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '인계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
commit;

insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
insert into item values (ITEMNOSEQ.NEXTVAL, 'dde@naver.com', '상계동', 10000000, 100000, ITEMNOSEQ.CURRVAL, default, default);
insert into itemTags values (ITEMNOSEQ.CURRVAL, '불가능', '없음', '원룸');
insert into ITEMATTACH values (ITEMNOSEQ.CURRVAL, 'test.jpg');
commit;
    
select count(*) from item where addr like '상계동';
select count(*) from item where addr like '';

select * from item where id='dde@naver.com';
select * from item where id='bbb@bbb.com';

select count(*) from store;
commit;

insert into member values ('aaa@aaa.com', '김승조', '1234', null, '김승조');

select * from STORE where COORDX >= 36.5 and COORDX <= 37.0;
select * from Store;

select * from store where lat=null or lon=null;
update store set lat=null, lon=null where addr='대구광역시 동구 봉무동 1545번지';

select * from store where lat>=37.6 and lat<=37.7 and lon>=127.0 and lon<=127.1;
select * from store where lat=37.39705795292739 and lon=127.1131606157361;

select * from store where lat>=37.39345913981367 and lat<=37.39705795292739
    and lon>=127.10750873998325 and lon<=127.1131606157361;

select * from store where lat>=37.370510696026436 and lat<=37.41810165481947
    and lon>=127.05714271916423 and lon<=127.13756168591655;

select * from board;
select * from item, itemAttach a where item.ITEMNO = a.ITEMNO;

select b.sentiment, count(b.sentiment) sentimentCnt
		from board b , item i
		where b.bcode = i.bcode
		and itemNo = 383
		GROUP by b.sentiment;
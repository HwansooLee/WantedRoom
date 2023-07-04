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
        where i.addr like '%상계동%' and i.ITEMNO = a.ITEMNO and a.ITEMNO = t.ITEMNO
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
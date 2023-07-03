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
        where i.addr like '%매탄동%' and i.ITEMNO = a.ITEMNO and a.ITEMNO = t.ITEMNO
        );
-- where rn <= 1;

select i.*, t.PARKING, t.ELEVATOR, t.BUILDINGTYPE from item i, itemTags t
    where i.itemNo = 5 and i.itemNo = t.itemNo;

select * from itemTags;
delete from itemTags where itemNo=0;
delete from itemAttach where itemNo=0;
delete from item where itemNo=0;
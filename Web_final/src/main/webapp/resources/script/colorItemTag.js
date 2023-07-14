const POSITIVE_COLOR_CLASS = 'positiveTag';
const NEGATIVE_COLOR_CLASS = 'negativeTag';
$('.parking').each((i, obj)=>{
    let tag = $(obj).val() == '주차가능' ? POSITIVE_COLOR_CLASS : NEGATIVE_COLOR_CLASS;
    $(obj).addClass(tag);
});
$('.elevator').each((i, obj)=>{
    let tag = $(obj).val() == '엘리베이터있음' ? POSITIVE_COLOR_CLASS : NEGATIVE_COLOR_CLASS;
    $(obj).addClass(tag);
});
$('.statusBtn').each((i, obj)=>{
    if( $(obj).val() == '계약완료' )
        $(obj).addClass('soldBtn');
});
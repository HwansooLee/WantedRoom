$('#addItem').on('click', () => {
    var authenticated = '${authenticated}';
    if(authenticated == 'false'){
        alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다.');
    }else{
        $('#addItem').attr('href','addItemForm');
    }
});
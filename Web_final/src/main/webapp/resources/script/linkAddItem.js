$('#addItem').on('click', () => {
    $.ajax({     
        url: 'checkAuthen',
        type: 'GET',
        success: (authen)=>{
            if( !authen )
                alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다');
            else
                location.href = 'addItemForm';        
        }		
    });
});
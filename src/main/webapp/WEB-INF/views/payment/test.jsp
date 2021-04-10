<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<script>
payment()
function payment() {
IMP.init('imp08010397'); // 'iamport' ��� �ο����� "������ �ĺ��ڵ�"�� ���


var data = {
		impUid : '���ݰ��ϴ�'
}

IMP.request_pay({
    pg : 'inicis',
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '�ֹ���:�����׽�Ʈ',
    amount : 100,
    buyer_email : 'iamport@siot.do',
    buyer_name : '�������̸�',
    buyer_tel : '010-1234-5678',
    buyer_addr : '����Ư���� ������ �Ｚ��',
    buyer_postcode : '123-456'
    
}, function(rsp) {
    if ( rsp.success ) {
    	//[1] �����ܿ��� �������� ��ȸ�� ���� jQuery ajax�� imp_uid �����ϱ�
    	jQuery.ajax({
    		url: "/payment/complete", //cross-domain error�� �߻����� �ʵ��� ������ ���������� ����
    		type: 'POST',
    		dataType: 'json',
    		contentType: 'application/json',
    		data: JSON.stringify(data)
    	}).done(function(data) {
    		//[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
    		if ( everythings_fine ) {
    			var msg = '������ �Ϸ�Ǿ����ϴ�.';
    			msg += '\n����ID : ' + rsp.imp_uid;
    			msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
    			msg += '\���� �ݾ� : ' + rsp.paid_amount;
    			msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;

    			alert(msg);
    		} else {
    			//[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
    			//[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
    		}
    	});
    } else {
        var msg = '������ �����Ͽ����ϴ�.';
        msg += '�������� : ' + rsp.error_msg;

        alert(msg);
    }
});
}

</script>
</body>
</html>
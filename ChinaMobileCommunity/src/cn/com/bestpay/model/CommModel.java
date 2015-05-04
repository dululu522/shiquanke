package cn.com.bestpay.model;

import cn.com.bestpay.util.CryptTool;

public class CommModel {
	
	private  String MerchantID="0018888888";   //�̻�����
	
	private  String CommKey="G7AXS7874305BV59";   //�̻�key
	
    private  String CommPwd="123321"; //�̻�����	
    
    private  String MerchantUrl="http://webpay.bestpay.com.cn/pageTest.do"; //ǰ̨֪ͨ��ַ
    
    private  String BackMerchantUrl="http://webpay.bestpay.com.cn/test.do"; //��̨֪ͨ��ַ
    
    /*private  String OrderID="20120620132345";       //������(��ǰʱ��)(��ʽ�磺yyyymmddhhmmss)
    
    private  String OrderReqTranSeq="20120620132345000001";  //������ˮ��(��ǰʱ��+000001)(��ʽ�磺yyyymmddhhmmss000001)
    
    private  String OrderDate="20120620";   //��������
    */
    private  String OrderID=CryptTool.getCurrentDate();       //������(��ǰʱ��)(��ʽ�磺yyyymmddhhmmss)
    
    private  String OrderReqTranSeq=CryptTool.getCurrentDate()+"000001";  //������ˮ��(��ǰʱ��+000001)(��ʽ�磺yyyymmddhhmmss000001)
    
    private  String OrderDate=CryptTool.getTodayDate2();   //��������
    
    private  String ActionUrlSelectBank="https://wappaywg.bestpay.com.cn/payWap.do";  //��������ƽ̨��ַ(ѡ�������ٽ��н���)
    
    private  String ActionUrlBank="https://wappaywg.bestpay.com.cn/payWapDirect.do";  //��������ƽ̨��ַ(ֱ�ӽ��н���)
    
    private  String ReFundUrl="https://ivrpaywg.bestpay.com.cn/services/refundV2?wsdl";      //�˿��ַ
    
    //private  String ReqTime = "20120620143550";	//�˿�����ʱ�䣬��ʽyyyyMMddHHmmss
    private String ReqTime=CryptTool.getCurrentDate();     //�˿�����ʱ�䣬��ʽyyyyMMddHHmmss
    
    private  String OrderRefundID = "REFUNDID" + System.currentTimeMillis();	//�˿�������ˮ��
    
    public  String getReqTime() {
		return ReqTime;
	}

	public  void setReqTime(String reqTime) {
		ReqTime = reqTime;
	}

	public  String getOrderRefundID() {
		return OrderRefundID;
	}

	public  void setOrderRefundID(String orderRefundID) {
		OrderRefundID = orderRefundID;
	}

	public  String getReFundUrl() {
		return ReFundUrl;
	}

	public  void setReFundUrl(String reFundUrl) {
		ReFundUrl = reFundUrl;
	}

	public  String getActionUrlSelectBank() {
		return ActionUrlSelectBank;
	}

	public  void setActionUrlSelectBank(String actionUrlSelectBank) {
		ActionUrlSelectBank = actionUrlSelectBank;
	}

	public  String getActionUrlBank() {
		return ActionUrlBank;
	}

	public  void setActionUrlBank(String actionUrlBank) {
		ActionUrlBank = actionUrlBank;
	}


	public  String getMerchantID() {
		return MerchantID;
	}

	public  void setMerchantID(String merchantID) {
		MerchantID = merchantID;
	}

	public  String getCommKey() {
		return CommKey;
	}

	public  void setCommKey(String commKey) {
		CommKey = commKey;
	}

	public  String getCommPwd() {
		return CommPwd;
	}

	public  void setCommPwd(String commPwd) {
		CommPwd = commPwd;
	}

	public  String getMerchantUrl() {
		return MerchantUrl;
	}

	public  void setMerchantUrl(String merchantUrl) {
		MerchantUrl = merchantUrl;
	}

	public  String getBackMerchantUrl() {
		return BackMerchantUrl;
	}

	public  void setBackMerchantUrl(String backMerchantUrl) {
		BackMerchantUrl = backMerchantUrl;
	}

	public  String getOrderID() {
		return OrderID;
	}

	public  void setOrderID(String orderID) {
		OrderID = orderID;
	}

	public  String getOrderReqTranSeq() {
		return OrderReqTranSeq;
	}

	public  void setOrderReqTranSeq(String orderReqTranSeq) {
		OrderReqTranSeq = orderReqTranSeq;
	}

	public  String getOrderDate() {
		return OrderDate;
	}

	public  void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}

	
}

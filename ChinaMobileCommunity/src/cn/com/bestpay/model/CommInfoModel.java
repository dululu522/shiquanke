package cn.com.bestpay.model;

public class CommInfoModel{
	private String MerchantID;			//SP��ݱ�ʶ��type=String 
	private String SubMerchantID;       //���̻�ID
	private String OrderSeq;            //������
  	private String OrderReqTranSeq;		//����������ˮ��
  	private String OrderDate;			//��������
  	private String OrderAmount;			//�ܽ���λΪ��
  	private String ProductAmount;		//��Ʒ����λΪ��
  	private String AttachAmount;		//���ӽ���λΪ��
	private String CurType;				//����
  	private String EncodeType;			//���ܷ�ʽ
  	private String MerchantUrl;         //ǰ̨��ַ
  	private String BackMerchantUrl;     //��̨��ַ
  	private String Attach;              //������Ϣ
  	private String BusiCode;            //ҵ�����ʹ���
  	private String ProductID;            //ҵ���ʶ
  	private String TmNum;               //�ն˺���
  	private String CustomerID;          //�ͻ���ʶ
  	private String ProductDesc;         //��Ʒ����
  	private String mac;                 //MACУ����
  	private String Divdetails;        //������ϸ
  	private String Pedcnt;     //������
  	private String ClientIP;//�ͻ���IP
  	private String BankID;   //���б���
	public String getBankID() {
		return BankID;
	}
	public void setBankID(String bankID) {
		BankID = bankID;
	}
	public String getMerchantID() {
		return MerchantID;
	}
	public void setMerchantID(String merchantID) {
		MerchantID = merchantID;
	}
	public String getSubMerchantID() {
		return SubMerchantID;
	}
	public void setSubMerchantID(String subMerchantID) {
		SubMerchantID = subMerchantID;
	}
	public String getOrderSeq() {
		return OrderSeq;
	}
	public void setOrderSeq(String orderSeq) {
		OrderSeq = orderSeq;
	}
	public String getOrderReqTranSeq() {
		return OrderReqTranSeq;
	}
	public void setOrderReqTranSeq(String orderReqTranSeq) {
		OrderReqTranSeq = orderReqTranSeq;
	}
	public String getOrderDate() {
		return OrderDate;
	}
	public void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}
	public String getOrderAmount() {
		return OrderAmount;
	}
	public void setOrderAmount(String orderAmount) {
		OrderAmount = orderAmount;
	}
	public String getProductAmount() {
		return ProductAmount;
	}
	public void setProductAmount(String productAmount) {
		ProductAmount = productAmount;
	}
	public String getAttachAmount() {
		return AttachAmount;
	}
	public void setAttachAmount(String attachAmount) {
		AttachAmount = attachAmount;
	}
	public String getCurType() {
		return CurType;
	}
	public void setCurType(String curType) {
		CurType = curType;
	}
	public String getEncodeType() {
		return EncodeType;
	}
	public void setEncodeType(String encodeType) {
		EncodeType = encodeType;
	}
	public String getMerchantUrl() {
		return MerchantUrl;
	}
	public void setMerchantUrl(String merchantUrl) {
		MerchantUrl = merchantUrl;
	}
	public String getBackMerchantUrl() {
		return BackMerchantUrl;
	}
	public void setBackMerchantUrl(String backMerchantUrl) {
		BackMerchantUrl = backMerchantUrl;
	}
	public String getAttach() {
		return Attach;
	}
	public void setAttach(String attach) {
		Attach = attach;
	}
	public String getBusiCode() {
		return BusiCode;
	}
	public void setBusiCode(String busiCode) {
		BusiCode = busiCode;
	}
	public String getProductID() {
		return ProductID;
	}
	public void setProductID(String productID) {
		ProductID = productID;
	}
	public String getTmNum() {
		return TmNum;
	}
	public void setTmNum(String tmNum) {
		TmNum = tmNum;
	}
	public String getCustomerID() {
		return CustomerID;
	}
	public void setCustomerID(String customerID) {
		CustomerID = customerID;
	}
	public String getProductDesc() {
		return ProductDesc;
	}
	public void setProductDesc(String productDesc) {
		ProductDesc = productDesc;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public String getDivdetails() {
		return Divdetails;
	}
	public void setDivdetails(String divdetails) {
		Divdetails = divdetails;
	}
	public String getPedcnt() {
		return Pedcnt;
	}
	public void setPedcnt(String pedcnt) {
		Pedcnt = pedcnt;
	}
	public String getClientIP() {
		return ClientIP;
	}
	public void setClientIP(String clientIP) {
		ClientIP = clientIP;
	}
}
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="cn.com.bestpay.util.CryptTool" %>
<%@ page import="cn.com.bestpay.model.CommModel" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%

	    String uptranSeq = request.getParameter("UPTRANSEQ");
        String trandate = request.getParameter("TRANDATE");
        String retncode = request.getParameter("RETNCODE");
		String retninfo = request.getParameter("RETNINFO");
		String orderreqtranseq = request.getParameter("ORDERREQTRANSEQ");
		String orderseq = request.getParameter("ORDERSEQ");
		String orderamount = request.getParameter("ORDERAMOUNT");
		String productamount = request.getParameter("PRODUCTAMOUNT");
		String attachamount = request.getParameter("ATTACHAMOUNT");
		String curtype = request.getParameter("CURTYPE");
		String encodetype = request.getParameter("ENCODETYPE"); 
		String attach = request.getParameter("ATTACH");
		String sign = request.getParameter("SIGN");
		String merchantId = request.getParameter("MERCHANTID");
		out.println("UPTRANSEQ============"+uptranSeq+"<br/>");
		out.println("SIGN============"+sign+"<br/>");
	    CommModel commModel=new CommModel();
	    String commkey=commModel.getCommKey();
		String checkMac = "";
		String check = "UPTRANSEQ="+uptranSeq+"&MERCHANTID="+merchantId+"&ORDERSEQ="+orderseq+"&ORDERAMOUNT="+orderamount+"&RETNCODE="+retncode+"&RETNINFO="+retninfo+"&TRANDATE="+trandate+"&KEY="+commkey;
		out.println("check加密前" + check+"<br/>");
		try {
			checkMac = CryptTool.md5Digest(check);
			out.println("checkMac加密后"+checkMac+"<br/>");
		} catch (Exception e1) {
			out.println("generator checkMac failure:"+e1+"<br/>");
		}
		if(sign!=null&&sign.length()>0){
			if(sign.equals(checkMac)){
				if(retncode!=null&&retncode.length()>0){
					if("0000".equals(retncode)){
						out.println("恭喜您，支付成功!支付金额:"+orderamount+"分");
						
					}else{
						out.println("抱歉，支付失败!");
						
					}
				}else{
					out.println("抱歉，支付结果未知");
					
				}
			}else{
				out.println( "抱歉，签名不正确");
				
			} }else{ out.println("抱歉，签名为空");
			
		}
%>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'frontTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  </body>
</html>

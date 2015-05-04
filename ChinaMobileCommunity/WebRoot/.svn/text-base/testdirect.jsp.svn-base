<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="cn.com.bestpay.util.*" %>
<%@ page import="cn.com.bestpay.model.CommModel" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    CommModel commModel=new CommModel();		
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Cache-Control" content="no-cache">
		<link href="<%=path%>/css/s_css.css" rel="stylesheet" type="text/css">
		<title>网上支付</title>
		<div id="sending"
			style="position:absolute; top:300; left:120; z-index:10; visibility:hidden">
			<TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0>
				<TR>
					<td width=30%></td>
					<TD bgcolor=#ff9900>
						<TABLE WIDTH=100% height=70 BORDER=0 CELLSPACING=2 CELLPADDING=0>
							<TR>
								<td bgcolor=#eeeeee align=center>
									支付正在进行, 请稍候...
								</td>
							</tr>
						</table>
					</td>
					<td width=30%></td>
				</tr>
			</table>
		</div>
		<script src="<%=path%>/js/softkeyboard.js"></script>
		<script src="<%=path%>/js/yh.js"></script>
		<script>
			
function dokeydown(){
  if (event.keyCode ==13)
  {
    doSubmit();
  }
}		
//必须输入的信息进行非空验证
function valitorInput()
{
	var merchantID=document.getElementById("MERCHANTID").value;
	var orderId=document.getElementById("ORDERSEQ").value;
	var orderReqTranSeq=document.getElementById("ORDERREQTRANSEQ").value;
	var orderDate=document.getElementById("ORDERDATE").value;

	var productAmount=document.getElementById("PRODUCTAMOUNT").value;
	var attachAmount=document.getElementById("ATTACHAMOUNT").value;
	var transAmount=document.getElementById("ORDERAMOUNT").value;
	
	var curType=document.getElementById("CURTYPE").value;
	var encodeType=document.getElementById("ENCODETYPE").value;
	var pageUrl=document.getElementById("MERCHANTURL").value;
	var backUrl=document.getElementById("BACKMERCHANTURL").value;
	var busiCode=document.getElementById("BUSICODE").value;
	var tmNum=document.getElementById("TMNUM").value;

	
	var customerId=document.getElementById("CUSTOMERID").value;
	var productId=document.getElementById("PRODUCTID").value;
	var productDesc=document.getElementById("PRODUCTDESC").value;
	if (merchantID == null || merchantID == "")
    {
		alert("商户号不能为空");
		return false;
	}
	else if (orderId == null || orderId == "") 
	{
		alert("订单号不能为空");
		return false;
	}
	else if (orderReqTranSeq == null || orderReqTranSeq == "")
	{
		alert("订单请求流水不能为空");
		return false;
	}
	else if (orderDate == null || orderDate == "")
	{
		alert("订单日期不能为空");
		return false;
	}
	else if (productAmount == null || productAmount == "")
	{
		alert("产品金额不能为空,格式应为保留小数点后2位 ");
		return false;
	}
	else if(attachAmount == null || attachAmount == "")
	{
		alert("附加金额不能为空,格式应为保留小数点后2位 ");
		return false;
	}
	else if (transAmount == null || transAmount == "")
	{
		alert("订单总金额不能为空,格式应为保留小数点后2位 ");
		return false;
	}
	else if (transAmount <= 0)
	{
		alert("订单总金额不能小于等于0");
		return false;
	}
	else if (transAmount > 99999999999)
	{
		alert("订单总金额不能大于9999999999");
		return false;
	}
	else if (curType == null || curType == "")
	{
		alert("币种不能为空");
		return false;
	}
	else if (encodeType == null || encodeType == "")
	{
		alert("加密方式不能为空");
		return false;
	}
	else if (pageUrl == null || pageUrl == "")
	{
		alert("交易返回的前台页面地址不能为空");
		return false;
	}
	else if (backUrl == null || backUrl == "")
	{
		alert("交易返回的后台页面地址不能为空");
		return false;
	}
	else if (busiCode == null || busiCode == "")
	{
		alert("业务类型代码不能为空");
		return false;
	}
	else if ("0001" != busiCode)
	{
		alert("业务类型代码不正确");
		return false;
	}
	else if(tmNum == null ||tmNum == "")
	{
		alert("终端号码不能为空");
		return false;
	}
	else if(customerId == null ||customerId == "")
	{
		alert("客户标识不能为空");
		return false;
	}
	else if(productId==null || productId == "")
	{
		alert("业务标识不能为空");
		return false;
	}
	else if(productDesc==null ||productDesc == "")
	{
		alert("产品描述不能为空");
		return false;
	}
	else
	{
		return true;
	}
}
//根据产品金额和附加金额计算总金额
function getTransAmount()
{
	var productAmount=document.getElementById("PRODUCTAMOUNT").value;
	var attachAmount=document.getElementById("ATTACHAMOUNT").value;
    if (productAmount == null || productAmount == "")
	{
		alert("产品金额不能为空,格式应为保留小数点后2位 ");
	}
	else if(attachAmount == null || attachAmount == "")
	{
		alert("附加金额不能为空,格式应为保留小数点后2位 ");
	}
	else
	{
	  document.getElementById("ORDERAMOUNT").value=(productAmount*1+attachAmount*1).toFixed(2);
	}
}
function doSubmit()
{
	if(valitorInput())
	{
	  sending.style.visibility="visible";
      cardform.action = "<%=path%>/PayWebServlet?index=2";
      cardform.submit();
      cardform.paymentSumbit.disabled = true;
	}
}
</script>
		<SCRIPT src="<%=path%>/js/ideal.js"></script>
		<script src="<%=path%>/js/formCheck.js"></script>
	</head>
	<body style="BACKGROUND-COLOR: transparent" onload="doLoad()">
		<form name="cardform" method="post">
			<table width="95%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="4%">
									<img src="<%=path%>/pic/qiu.gif" width="20" height="20">
								</td>
								<td width="96%" class="title">
									订单信息
								</td>
							</tr>
							<tr>
								<td colspan="2" height="1" background="<%=path%>/pic/s_line.gif"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top" style="padding-top:10px ">
						<table width="95%" border="1" align="center" cellpadding="0"
							cellspacing="0" style="border-collapse:collapse"
							bordercolor="#E7E7E7">
							
							<tr>
								<td align="right">
									商户ID：
								</td>
								<td>
									<input name="MERCHANTID" value="<%=commModel.getMerchantID()%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									商户子商户ID：
								</td>
								<td>
									<input name="SUBMERCHANTID" value="<%=commModel.getMerchantID()%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单号：
								</td>
								<td>
									<input name="ORDERSEQ" value="<%=commModel.getOrderID()%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单请求交易流水号：
								</td>
								<td>
									<input name="ORDERREQTRANSEQ" value="<%=commModel.getOrderReqTranSeq()%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单日期：
								</td>
								<td>
									<input name="ORDERDATE" value="<%=commModel.getOrderDate()%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									产品金额(分)：
								</td>
								<td>
									<input name="PRODUCTAMOUNT" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									附加金额(分)：
								</td>
								<td>
									<input name="ATTACHAMOUNT" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单总金额(分)：
								</td>
								<td>
									<input name="ORDERAMOUNT" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1' onmousedown="getTransAmount()">
								</td>
							</tr>
							<tr>
								<td align="right">
									币种：
								</td>
								<td>
								<select name="CURTYPE" class="normal_input" tabindex="1">
									<option value="RMB" selected>RMB</option>
								</select>
								</td>
							</tr>
							<tr>
								<td align="right">
									加密方式：
								</td>
								<td>
									<input name="ENCODETYPE" value='1' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									交易返回的url地址：
								</td>
								<td>
									<input name="MERCHANTURL"
										value="http://localhost:8080/webpayDemo/frontTest.jsp"
										type="text" class="normal_input" size="60" maxlength="60"
										tabIndex='1'>格式如：(http://localhost:8080/webpayDemo/frontTest.jsp)
								</td>
							</tr>
							<tr>
								<td align="right">
									交易后台返回的url地址：
								</td>
								<td>
									<input name="BACKMERCHANTURL"
										value="http://localhost:8080/webpayDemo/backTest.jsp"
										type="text" class="normal_input" size="60" maxlength="60"
										tabIndex='1'>格式如：(http://localhost:8080/webpayDemo/backTest.jsp)
								</td>
							</tr>
							<tr>
								<td align="right">
									商家附加信息：
								</td>
								<td>
									<input name="ATTACH" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									业务类型：
								</td>
								<td>
									<input name="BUSICODE" value='0001' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									业务标识：
								</td>
								<td>
								   <select name="PRODUCTID">
								     <option value="01">电信类充值</option>
								     <option value="02">电信类缴费</option>
								     <option value="03">终端代理商资金归集</option>
								     <option value="04">空充代理商资金归集</option>
								     <option value="05">外部商户资金归集</option>
								     <option value="06">订房订票</option>
								   </select>
								</td>
							</tr>
							<tr>
								<td align="right">
									终端号码：
								</td>
								<td>
									<input name="TMNUM" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>如：(您的充值号码或联系电话)
								</td>
							</tr>
							<tr>
								<td align="right">
									客户标识：
								</td>
								<td>
									<input name="CUSTOMERID" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>如：(登录名)
								</td>
							</tr>
							
							<tr>
								<td align="right">
									产品描述：
								</td>
								<td>
									<input name="PRODUCTDESC" value='' type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>如：(充话费50元)
								</td>
							</tr>
							<tr>
								<td align="right">
									选择跳转的银行：
								</td>
								<td>
									<select name="BANKID" class="normal_input" tabindex="1">
									    <option value="ICBC" selected>工商银行</option>
										<option value="ABC" >农业银行</option>
										<option value="BCOM"  >交通银行</option>
										<option value="BEA"  >东亚银行</option>
										<option value="BJRCB"  >北京农村商业银行</option>
										<option value="BOB"  >北京银行</option>
										<option value="BOC"  >中国银行</option>
										<option value="CBHB"  >渤海银行</option>
										<option value="CCB"  >建设银行</option>
										<option value="CEB"  >光大银行</option>
										<option value="CIB"  >兴业银行</option>
										<option value="CITIC"  >中信银行</option>
										<option value="CMB"  >招商银行</option>
										<option value="CMBC"  >民生银行</option>
										<option value="GDB"  >广发银行</option>
										<option value="GZCB"  >广州市商业银行</option>
										<option value="GZRCC"  >广州市农村信用合作社</option>
										<option value="HKBANK"  >汉口银行</option>
										<option value="HXB"  >华夏银行</option>
										<option value="JCB"  >晋城市商业银行</option>
										<option value="NBCB"  >宁波银行</option>
										<option value="NJCB"  >南京银行</option>
										<option value="POST"  >邮储</option>
										<option value="SDB"  >深发展银行</option>
										<option value="SDRCC"  >顺德农村信用合作社</option>
										<option value="SHRCC"  >上海农村商业银行</option>
										<option value="SPDB"  >浦发银行</option>
										<option value="WZCB"  >温州市商业银行</option>
										<option value="YDRCC"  >尧都信用合作社</option>
										<option value="ZHRCC"  >珠海市农村信用合作社</option>
										<option value="TENPAY" >财付通</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center" height="30">
									<input name='paymentSumbit' type="button"
										onClick="return doSubmit()" value=" 提交 " class="normal_input"
										tabIndex='4'>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="reset" value=" 重置 " class="normal_input"
										tabIndex='5'>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

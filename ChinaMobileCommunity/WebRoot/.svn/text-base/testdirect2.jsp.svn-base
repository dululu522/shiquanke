<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="cn.com.bestpay.util.CryptTool" %>
<%@ page import="cn.com.bestpay.model.CommModel" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String merchantID = request.getParameter("MERCHANTID");
	String orderId = request.getParameter("ORDERSEQ");
	String orderDate = request.getParameter("ORDERDATE");
	String ipRemote=(String)request.getAttribute("ipRemote"); //获取客户端IP
	String transAmount=request.getParameter("ORDERAMOUNT");
	CommModel commModel=new CommModel();
	String commkey=commModel.getCommKey();
	String sourceStr="MERCHANTID="+merchantID+"&ORDERSEQ="+orderId+"&ORDERDATE="+orderDate+"&ORDERAMOUNT="+transAmount+"&KEY="+commkey;
	String mac = CryptTool.md5Digest(sourceStr);
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Cache-Control" content="no-cache">
		<link href="<%=path%>/css/s_css.css" rel="stylesheet" type="text/css">
		<title>网上支付</title>
		<div id="sending" style="position:absolute; top:300; left:120; z-index:10; visibility:hidden">
			<table WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0>
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

function doSubmit()
{
    sending.style.visibility="visible";
    cardform.action ="<%= commModel.getActionUrlBank()%>";
    cardform.submit();
    cardform.paymentSumbit.disabled = true;
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
									<input name="MERCHANTID" type="text" readonly value ="<%=request.getParameter("MERCHANTID") %>"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									商户子商户ID：
								</td>
								<td>
									<input name="SUBMERCHANTID" readonly value ="<%=request.getParameter("SUBMERCHANTID") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单号：
								</td>
								<td>
									<input name="ORDERSEQ"  readonly value ="<%=request.getParameter("ORDERSEQ") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单请求交易流水号：
								</td>
								<td>
									<input name="ORDERREQTRANSEQ"  readonly value ="<%=request.getParameter("ORDERREQTRANSEQ") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单日期：
								</td>
								<td>
									<input name="ORDERDATE"  readonly value ="<%=request.getParameter("ORDERDATE") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									产品金额(分)：
								</td>
								<td>
									<input name="PRODUCTAMOUNT"  readonly value ="<%=request.getParameter("PRODUCTAMOUNT") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									附加金额(分)：
								</td>
								<td>
									<input name="ATTACHAMOUNT"  readonly value ="<%=request.getParameter("ATTACHAMOUNT") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									订单总金额(分)：
								</td>
								<td>
									<input name="ORDERAMOUNT"  readonly value ="<%=transAmount %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
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
									<input name="ENCODETYPE"  readonly value ="<%=request.getParameter("ENCODETYPE") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									交易返回的url地址：
								</td>
								<td>
									<input name="MERCHANTURL"
										 readonly value ="<%=request.getParameter("MERCHANTURL") %>"
										type="text" class="normal_input" size="60" maxlength="60"
										tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									交易后台返回的url地址：
								</td>
								<td>
									<input name="BACKMERCHANTURL"
										 readonly value ="<%=request.getParameter("BACKMERCHANTURL") %>"
										type="text" class="normal_input" size="60" maxlength="60"
										tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									商家附加信息：
								</td>
								<td>
									<input name="ATTACH"  readonly value ="<%=request.getParameter("ATTACH") %>" type="text"
									
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									业务类型：
								</td>
								<td>
									<input name="BUSICODE"  readonly value ="<%=request.getParameter("BUSICODE") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									业务标识：
								</td>
								<td>
									<input name="PRODUCTID"  readonly value ="<%=request.getParameter("PRODUCTID") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
														<tr>
								<td align="right">
									终端号码：
								</td>
								<td>
									<input name="TMNUM"  readonly value ="<%=request.getParameter("TMNUM") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									客户标识：
								</td>
								<td>
									<input name="CUSTOMERID"  readonly value ="<%=request.getParameter("CUSTOMERID") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									产品描述：
								</td>
								<td>
									<input name="PRODUCTDESC"  readonly value ="<%=request.getParameter("PRODUCTDESC") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									选择跳转的银行：
								</td>
								<td>
									<input name="BANKID"  readonly value ="<%=request.getParameter("BANKID") %>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
								</td>
							</tr>
							<tr>
								<td align="right">
									MAC：
								</td>
								<td>
									<input name="MAC"  readonly value ="<%=mac%>" type="text"
										class="normal_input" size="60" maxlength="60" tabIndex='1'>
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

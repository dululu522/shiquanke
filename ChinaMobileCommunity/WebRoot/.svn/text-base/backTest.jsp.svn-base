<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="cn.com.bestpay.util.CryptTool" %>
<%@ page import="cn.com.bestpay.model.CommModel" %>
<%@ page import="org.apache.log4j.Logger" %>
<%!  private static Logger log = Logger.getLogger(CommModel.class);%>
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
		log.debug("   UPTRANSEQ============"+uptranSeq);
		log.debug("   SIGN============"+sign);
		
		
		CommModel commModel=new CommModel();
		String commkey=commModel.getCommKey();
		String checkMac = "";
		String check = "UPTRANSEQ="+uptranSeq+"&MERCHANTID="+merchantId+"&ORDERSEQ="+orderseq+"&ORDERAMOUNT="+orderamount+"&RETNCODE="+retncode+"&RETNINFO="+retninfo+"&TRANDATE="+trandate+"&KEY="+commkey;
		log.debug("check=====111======="+check);
		try {
			checkMac = CryptTool.md5Digest(check);
			log.debug("reply checkMac =====111===== "+checkMac);
			if(sign!=null&&sign.length()>0){
				if(sign.equals(checkMac)){
					log.debug("sign校验成功");
					if(retncode!=null&&retncode.length()>0){
			log.debug("retncode=============="+retncode);
			if(uptranSeq!=null&&uptranSeq.trim().length()>0){
				out.println("UPTRANSEQ_" + uptranSeq);
			}
			}
					//处理自己的业务逻辑
				}else
				{
					log.debug("sign校验失败");
				}
			}else
			{
				log.debug("参数不正确，未提供sign");
			}
			
			
		} catch (Exception e1) {
			log.debug("generator checkMac failure:"+e1);
		}
		
%>
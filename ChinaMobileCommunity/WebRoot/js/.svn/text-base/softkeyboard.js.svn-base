// document.write ('  <link href=\"/personal/include/css/css.css\" rel=\"stylesheet\" type=\"text/css\">')
  //var curEditName;
   //     curEditName="frmMain.password";
//定义当前是否大写的状态
window.onload=
	function()
	{
		password1=null;	
		initCalc();
	}
var inputwihtkeyboard=false;
var CapsLockValue=0;
var aryNumber,aryChar;

	aryNumber=new Array(0,1,2,3,4,5,6,7,8,9);
	aryChar=new Array();
	aryChar[0]=new Array('q','w','e','r','t','y','u','i','o','p',':');
	aryChar[1]=new Array('a','s','d','f','g','h','j','k','l','[',']');
	aryChar[2]=new Array('z','x','c','v','b','n','m','<','>','(',')');
	aryChar[3]=new Array('!','@','#','$','%','^','*','~',',','?','|');

	shuffle(aryNumber);
//	shuffle(aryChar[0]);
//	shuffle(aryChar[1]);
//	shuffle(aryChar[2]);
//  shuffle(aryChar[3]);
var check;
function setVariables() {
tablewidth=630;  // logo width, in pixels
tableheight=20;  // logo height, in pixels
if (navigator.appName == "Netscape") {
horz=".left";
vert=".top";
docStyle="document.";
styleDoc="";
innerW="window.innerWidth";
innerH="window.innerHeight";
offsetX="window.pageXOffset";
offsetY="window.pageYOffset";
}
else {
horz=".pixelLeft";
vert=".pixelTop";
docStyle="";
styleDoc=".style";
innerW="document.body.clientWidth";
innerH="document.body.clientHeight";
offsetX="document.body.scrollLeft";
offsetY="document.body.scrollTop";
   }
}
function checkLocation() {
if (check) {
objectXY="softkeyboard";
var availableX=eval(innerW);
var availableY=eval(innerH);
var currentX=eval(offsetX);
var currentY=eval(offsetY);
x=availableX-tablewidth+currentX;
//y=availableY-tableheight+currentY;
y=currentY;

evalMove();
}
setTimeout("checkLocation()",0);
}
function evalMove() {
//eval(docStyle + objectXY + styleDoc + horz + "=" + x);
eval(docStyle + objectXY + styleDoc + vert + "=" + y);
}


        self.onError=null;
        currentX = currentY = 0;
        whichIt = null;
        lastScrollX = 0; lastScrollY = 0;
        NS = (document.layers) ? 1 : 0;
        IE = (document.all) ? 1: 0;
        function heartBeat() {
                if(IE) { diffY = document.body.scrollTop; diffX = document.body.scrollLeft; }
            if(NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
                if(diffY != lastScrollY) {
                        percent = .1 * (diffY - lastScrollY);
                        if(percent > 0) percent = Math.ceil(percent);
                        else percent = Math.floor(percent);
                                        if(IE) document.all.softkeyboard.style.pixelTop += percent;
                                        if(NS) document.softkeyboard.top += percent;
                        lastScrollY = lastScrollY + percent;}
                if(diffX != lastScrollX) {
                        percent = .1 * (diffX - lastScrollX);
                        if(percent > 0) percent = Math.ceil(percent);
                        else percent = Math.floor(percent);
                        if(IE) document.all.softkeyboard.style.pixelLeft += percent;
                        if(NS) document.softkeyboard.left += percent;
                        lastScrollX = lastScrollX + percent;        }                }
        function checkFocus(x,y) {
                stalkerx = document.softkeyboard.pageX;
                stalkery = document.softkeyboard.pageY;
                stalkerwidth = document.softkeyboard.clip.width;
                stalkerheight = document.softkeyboard.clip.height;
                if( (x > stalkerx && x < (stalkerx+stalkerwidth)) && (y > stalkery && y < (stalkery+stalkerheight))) return true;
                else return false;}
        function grabIt(e) {
            check = false;
                if(IE) {
                        whichIt = event.srcElement;
                        while (whichIt.id.indexOf("softkeyboard") == -1) {
                                whichIt = whichIt.parentElement;
                                if (whichIt == null) { return true; } }
                        whichIt.style.pixelLeft = whichIt.offsetLeft;
                    whichIt.style.pixelTop = whichIt.offsetTop;
                        currentX = (event.clientX + document.body.scrollLeft);
                           currentY = (event.clientY + document.body.scrollTop);
                } else {
                window.captureEvents(Event.MOUSEMOVE);
                if(checkFocus (e.pageX,e.pageY)) {
                        whichIt = document.softkeyboard;
                        StalkerTouchedX = e.pageX-document.softkeyboard.pageX;
                        StalkerTouchedY = e.pageY-document.softkeyboard.pageY;} }
            return true;        }
        function moveIt(e) {
                if (whichIt == null) { return false; }
                if(IE) {
                    newX = (event.clientX + document.body.scrollLeft);
                    newY = (event.clientY + document.body.scrollTop);
                    distanceX = (newX - currentX);    distanceY = (newY - currentY);
                    currentX = newX;    currentY = newY;
                    whichIt.style.pixelLeft += distanceX;
                    whichIt.style.pixelTop += distanceY;
                        if(whichIt.style.pixelTop < document.body.scrollTop) whichIt.style.pixelTop = document.body.scrollTop;
                        if(whichIt.style.pixelLeft < document.body.scrollLeft) whichIt.style.pixelLeft = document.body.scrollLeft;
                        if(whichIt.style.pixelLeft > document.body.offsetWidth - document.body.scrollLeft - whichIt.style.pixelWidth - 20) whichIt.style.pixelLeft = document.body.offsetWidth - whichIt.style.pixelWidth - 20;
                        if(whichIt.style.pixelTop > document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5) whichIt.style.pixelTop = document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5;
                        event.returnValue = false;
                } else {
                        whichIt.moveTo(e.pageX-StalkerTouchedX,e.pageY-StalkerTouchedY);
                if(whichIt.left < 0+self.pageXOffset) whichIt.left = 0+self.pageXOffset;
                if(whichIt.top < 0+self.pageYOffset) whichIt.top = 0+self.pageYOffset;
                if( (whichIt.left + whichIt.clip.width) >= (window.innerWidth+self.pageXOffset-17)) whichIt.left = ((window.innerWidth+self.pageXOffset)-whichIt.clip.width)-17;
                if( (whichIt.top + whichIt.clip.height) >= (window.innerHeight+self.pageYOffset-17)) whichIt.top = ((window.innerHeight+self.pageYOffset)-whichIt.clip.height)-17;
                return false;}
            return false;        }
        function dropIt() {whichIt = null;
            if(NS) window.releaseEvents (Event.MOUSEMOVE);
            return true;        }
        if(NS) {window.captureEvents(Event.MOUSEUP|Event.MOUSEDOWN);
                window.onmousedown = grabIt;
                 window.onmousemove = moveIt;
                window.onmouseup = dropIt;        }
        if(IE) {
                document.onmousedown = grabIt;
                 document.onmousemove = moveIt;
                document.onmouseup = dropIt;        }
        if(NS || IE) action = window.setInterval("heartBeat()",1);

 
var A,B

A=200*Math.random()
B=100*Math.random()+100
document.write ('    <DIV align=center id=\"softkeyboard\" name=\"softkeyboard\" style=\"position:absolute; left:'+0+'px; top:'+0+'px; width:140px; z-index:180;display:none\">');
document.write ('  <table width=\"145\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#739caa\">');
document.write ('    <FORM name=Calc action=\"\" method=post autocomplete=\"off\">');
document.write ('  <INPUT type=hidden value=\"\" name=password>');
document.write ('      <INPUT type=hidden value=ok name=action2>');
document.write ('      <tr> ');
document.write ('      <td align=\"center\" height=26 bgcolor=\"#cccccc\"> ');
document.write ('      <font size=3 color=#0033FF > ');
document.write ('      密码键盘');
document.write ('      </font> ');
document.write ('      </td> ');
document.write ('      </tr> ');
document.write ('      <tr> ');
document.write ('        <td align=\"center\" bgcolor=\"#FFFFFF\">');
document.write (' <table align=\"center\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">');
document.write ('            <tr> ');
var X;
for ( X=0;X<3 ;X++ )
{
		document.write ('                <td><input type=button class=keyboardcss value=\" '+aryNumber[X]+' \"></td>');
		
}




document.write ('              <td colspan=\"2\"><input name=\"button10\" class=keyboardcss2 type=button value=\"退格\" onclick=\"setpassvalue();\" ondblclick=\"setpassvalue();\" style=\"width:66px;height:30px\"> ');
document.write ('              </td>');
document.write ('            </tr>');
document.write ('            <tr>');

for ( X=3;X<6 ;X++ )
{
		document.write ('                <td><input type=button class=keyboardcss value=\" '+aryNumber[X]+' \"></td>');
		}
document.write ('              <td colspan=\"2\" rowspan=\"2\"><input name=\"button12\" type=button  class=keyboardcss2 onclick=\"OverInput();\" value=\"确定\" style=\"width:66px;height:60px\"> ');
document.write ('              </td>');
document.write ('            </tr>');
document.write ('            <tr>');
for ( X=6;X<9 ;X++ )
{
		document.write ('               <td><input type=button class=keyboardcss value=\" '+aryNumber[X]+' \"></td>');
}
document.write ('            </tr>');
document.write ('            <tr> ');
for ( X=9;X<10 ;X++ )
{
		document.write ('                <td><input type=button class=keyboardcss value=\" '+aryNumber[X]+' \"></td>');
}
document.write ('              <td colspan=\"4\"> ');
document.write ('                <input name=\"showCapsLockValue\" type=button class=keyboardcss2  value=\"使用键盘输入\" onclick=\"userkeyboard();\" style=\"width:136px;height:30px\"></td>');
document.write ('            </tr>');
document.write ('          </table></td>');
document.write ('      </tr>');
document.write ('    </FORM>');
document.write ('  </table>');
document.write ('</DIV>');

//给输入的密码框添加新值
        function addValue(newValue)
        {
        					
			var str=Calc.password.value;					
									
			if(str.length<password1.maxLength)
			{
				Calc.password.value += newValue;
			}			
			if(str.length<=password1.maxLength)
			{
				password1.value=Calc.password.value;
			}
				//}
        }
//实现BackSpace键的功能
        function setpassvalue()
        {
                //var longnum=Calc.password.value.length;
               // var num
               // num=Calc.password.value.substr(0,longnum-1);
               // Calc.password.value=num;
                
                
                var longnum=Calc.password.value.length;
		var num
		num=Calc.password.value.substr(0,longnum-1);
		Calc.password.value=num;
		var str=Calc.password.value;
			password1.value=Calc.password.value;
        }
//输入完毕
        function OverInput()
        {
                var str=Calc.password.value;
		password1.value=Calc.password.value;
			//alert(theForm.value);
		//theForm.value=m_pass.mempass.value;
		softkeyboard.style.display="none";
		Calc.password.value="";
		password1.readOnly=0;
        }
//关闭软键盘
        function userkeyboard()
        {
                inputwihtkeyboard=true
                softkeyboard.style.display="none";
                password1.readOnly=0;
                password1.focus();                
                password1.value='';
		
        }
//显示软键盘
        function showkeyboard(m_x,m_y)        {
                softkeyboard.style.display="block";
                softkeyboard.style.left=m_x+"px";
                softkeyboard.style.top=m_y+"px";
                password1.readOnly=1;
		password1.blur();
        }

//设置是否大写的值
function setCapsLock()
{
        if (CapsLockValue==0)
        {
                CapsLockValue=1
                Calc.showCapsLockValue.value="当前是大写 ";
        }
        else
        {
                CapsLockValue=0
                Calc.showCapsLockValue.value="当前是小写 ";
        }
}

function initCalc()
{
	for(var i=0;i<Calc.elements.length;i++)
	{
		var thisButtonValue=Calc.elements[i].value;
		
		if(Calc.elements[i].type=="button"&&thisButtonValue.length==3)
		{		
				Calc.elements[i].onclick=
					function ()
					{
						var thisButtonValue=this.value;
						thisButtonValue=thisButtonValue.substring(1,2);												
						addValue(thisButtonValue);						
					}
				Calc.elements[i].ondblclick=
					function ()
					{
						var thisButtonValue=this.value;
						thisButtonValue=thisButtonValue.substring(1,2);												
						addValue(thisButtonValue);						
					}
				
		}
	}	
	
	
}

//随机排列
function exchange(myObj,i,j){
  if (i != j) with (myObj[i]) {
    myObj[i] = myObj[j];
    myObj[j] = valueOf();
  }
}


 function shuffle(myObj) 
 {
	var l;
  var i = myObj.length-1;
  while (i>=0)  {
    exchange(myObj,i, Math.floor(Math.random()*(i+1)));
	i=i-1;
  } 
  return(myObj);
}
//当焦点进入密码输入框时默认弹出密码键盘
 function passwordonfocus(passwd) 
 {
	if(!inputwihtkeyboard){
	mouseLocation();
	password1=passwd;
	showkeyboard(Mouse_X,Mouse_Y);
	Calc.password.value=''
	}
	inputwihtkeyboard=!	inputwihtkeyboard;
}
//获得密码键盘图片的位置，用来确定密码键盘在什么地方显示
function getX(){
var e=document.getElementById("keyboardimg")
var l=e.offsetLeft;
while(e=e.offsetParent){
l+=e.offsetLeft;
}
//return l+28;
return l+20;
}
function getY(){
var e=document.getElementById("keyboardimg")
var t=e.offsetTop;
while(e=e.offsetParent){
t+=e.offsetTop;
}
return (t-68);
}
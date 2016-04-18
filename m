Return-Path: <rtc-linux+bncBAABBD7X2G4AKGQE5EX4OWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from emea01-db3-obe.outbound.protection.outlook.com (mail-db3on0077.outbound.protection.outlook.com. [157.55.234.77])
        by gmr-mx.google.com with ESMTPS id m129si110411ywb.0.2016.04.17.23.15.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 23:15:42 -0700 (PDT)
From: Qianyu Gong <qianyu.gong@nxp.com>
To: "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
	"alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>
CC: Mingkai Hu <mingkai.hu@nxp.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] rtc ds3232 call trace in kernel
Date: Mon, 18 Apr 2016 06:15:40 +0000
Message-ID: <AM2PR04MB09643A16272FB78B0D9FA103E76B0@AM2PR04MB0964.eurprd04.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_AM2PR04MB09643A16272FB78B0D9FA103E76B0AM2PR04MB0964eurp_"
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--_000_AM2PR04MB09643A16272FB78B0D9FA103E76B0AM2PR04MB0964eurp_
Content-Type: text/plain; charset=UTF-8

Hi Akinobu,

I got an rtc call trace when booting 4.6 kernel on our board and I found it
was caused by this patch:

commit fc1dcb0b39dbb10d3290f2fcd6e154670f699166
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon Mar 7 00:27:53 2016 +0900

    rtc: ds3232: use rtc->ops_lock to protect alarm operations

    ds3232->mutex is used to protect for alarm operations which
    need to access status and control registers.

    But we can use rtc->ops_lock instead.  rtc->ops_lock is held when most
    of rtc_class_ops methods are called, so we only need to explicitly
    acquire it from irq handler in order to protect form concurrent
    accesses.

    Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com

The problem is that rtc->ops_lock would be accessed in ds3232_irq()
without being initialized as rtc_device_register() is called too late.

As I'm not familiar with rtc things, could I just revert the patch or you already
have a solution to this problem? Thanks in advance.


Regards,
Qianyu

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--_000_AM2PR04MB09643A16272FB78B0D9FA103E76B0AM2PR04MB0964eurp_
Content-Type: text/html; charset=UTF-8

<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
<meta name="Generator" content="Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Dotum;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Dotum";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Microsoft Tai Le";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang="EN-US" link="#0563C1" vlink="#954F72">
<div class="WordSection1">
<p class="MsoNormal">Hi Akinobu,<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">I got an rtc call trace when booting 4.6 kernel on our board and I found it<o:p></o:p></p>
<p class="MsoNormal">was caused by this patch:<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">commit fc1dcb0b39dbb10d3290f2fcd6e154670f699166<o:p></o:p></p>
<p class="MsoNormal">Author: Akinobu Mita &lt;akinobu.mita@gmail.com&gt;<o:p></o:p></p>
<p class="MsoNormal">Date:&nbsp;&nbsp; Mon Mar 7 00:27:53 2016 &#43;0900<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; rtc: ds3232: use rtc-&gt;ops_lock to protect alarm operations<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; ds3232-&gt;mutex is used to protect for alarm operations which<o:p></o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; need to access status and control registers.<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; But we can use rtc-&gt;ops_lock instead.&nbsp; rtc-&gt;ops_lock is held when most<o:p></o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; of rtc_class_ops methods are called, so we only need to explicitly<o:p></o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; acquire it from irq handler in order to protect form concurrent<o:p></o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; accesses.<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Akinobu Mita &lt;akinobu.mita@gmail.com&gt;<o:p></o:p></p>
<p class="MsoNormal" style="text-indent:10.2pt">Signed-off-by: Alexandre Belloni &lt;alexandre.belloni@free-electrons.com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class="MsoNormal" style="text-indent:10.2pt"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">The problem is that rtc-&gt;ops_lock would be accessed in ds3232_irq()<o:p></o:p></p>
<p class="MsoNormal">without being initialized as rtc_device_register() is called too late.<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">As I&#8217;m not familiar with rtc things, could I just revert the patch or you already<o:p></o:p></p>
<p class="MsoNormal">have a solution to this problem? Thanks in advance.<o:p></o:p></p>
<p class="MsoNormal"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:12.0pt">Regards,<o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:12.0pt">Qianyu<o:p></o:p></span></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quot;.<br />
Membership options at <a href="http://groups.google.com/group/rtc-linux">http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href="http://groups.google.com/group/rtc-linux/web/checklist">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an email to <a href="mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href="https://groups.google.com/d/optout">https://groups.google.com/d/optout</a>.<br />

--_000_AM2PR04MB09643A16272FB78B0D9FA103E76B0AM2PR04MB0964eurp_--

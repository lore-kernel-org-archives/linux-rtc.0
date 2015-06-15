Return-Path: <rtc-linux+bncBCSIRPX5CUIMJMP4VMCRUBABUCXOC@googlegroups.com>
Date: Mon, 15 Jun 2015 11:26:11 -0700 (PDT)
From: Alexey Mednyy <swexru@gmail.com>
To: rtc-linux@googlegroups.com
Message-Id: <13a98422-3d30-4ff0-a4b9-ecf67ed0a757@googlegroups.com>
Subject: [rtc-linux] [QUESTION] rtc and regmap_irq wakeup
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_471_638912712.1434392771569"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_471_638912712.1434392771569
Content-Type: multipart/alternative;
	boundary="----=_Part_472_787715584.1434392771569"

------=_Part_472_787715584.1434392771569
Content-Type: text/plain; charset=UTF-8

Hello all!

I'm trying to add wakealarm support to rtc-mc13xxx driver. But I've faced 
some troubles.

It's using nested IRQs over mc13xxx-core driver.
What I've done:
1. Added device_init_wakeup to both mc13xxx-core (parent irq) and to 
rtc-mc13xxx
2. Added dev_pm_ops to both core and rtc
3. Added enable_irq_wake to core suspend for core irq
4. Disabled 1HZ irq in rtc-mc13xxx ( do not wakeup after 1 second)

Now I've got wakealarm file and I can write to it. But device doesn't 
wakeup.
I've added some printk's to suspend core suspend (as it goes after child 
suspend) and I can see that IRQ_TODA bit of IRQ_MASK1 register in mc13xxx 
is masked(turned off).
For some reason rtc or regmap irq, disabled TODA irq before suspend.
Can't figure why. 

If I unmask TODA irq directly over regmap machine wakes, but than hangs.

So questions are:
1. Why TODA irq turned off before suspend?
2. Is there any restrictions in IRQs, rtc can use for wakeup?

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

------=_Part_472_787715584.1434392771569
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all!<br><br>I'm trying to add wakealarm support to r=
tc-mc13xxx driver. But I've faced some troubles.<br><br>It's using nested I=
RQs over mc13xxx-core driver.<br>What I've done:<br>1. Added device_init_wa=
keup to both mc13xxx-core (parent irq) and to rtc-mc13xxx<br>2. Added dev_p=
m_ops to both core and rtc<br>3. Added enable_irq_wake to core suspend for =
core irq<br>4. Disabled 1HZ irq in rtc-mc13xxx ( do not wakeup after 1 seco=
nd)<br><br>Now I've got wakealarm file and I can write to it. But device do=
esn't wakeup.<br>I've added some printk's to suspend core suspend (as it go=
es after child suspend) and I can see that IRQ_TODA bit of IRQ_MASK1 regist=
er in mc13xxx is masked(turned off).<br>For some reason rtc or regmap irq, =
disabled TODA irq before suspend.<br>Can't figure why. <br><br>If I unmask =
TODA irq directly over regmap machine wakes, but than hangs.<br><br>So ques=
tions are:<br>1. Why TODA irq turned off before suspend?<br>2. Is there any=
 <span id=3D"result_box" class=3D"short_text" lang=3D"en"><span class=3D"hp=
s">restrictions in IRQs, rtc can use for wakeup?</span></span><br><br></div=
>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_472_787715584.1434392771569--

------=_Part_471_638912712.1434392771569--

Return-Path: <rtc-linux+bncBDP5VQPV4IBRBS5IZG4QKGQEMVYELCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id ai9si169982lbc.2.2016.05.10.14.36.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 14:36:10 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id m101so2868838lfi.1
        for <rtc-linux@googlegroups.com>; Tue, 10 May 2016 14:36:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <573201AD.7080705@wwwdotorg.org>
References: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
	<573201AD.7080705@wwwdotorg.org>
Date: Tue, 10 May 2016 23:36:10 +0200
Message-ID: <CABr+WTm2mfg5=40ONBfSac3G9NOAROz1xuu11pmPCXh0VS=3hw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: rename so the tps6586x-rtc module can be
 autoloaded at boot
From: Nicolas Chauvet <kwizart@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11401b5ab01740053283b695
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a11401b5ab01740053283b695
Content-Type: text/plain; charset=UTF-8

2016-05-10 17:43 GMT+02:00 Stephen Warren <swarren@wwwdotorg.org>:

> On 05/10/2016 04:26 AM, Nicolas Chauvet wrote:
>
>> This module is loaded by the related mfd driver which has
>> the needed MODULE_DEVICE_TABLE(i2c,...).
>>
>> This patch fix the modalias when the rtc driver is built
>> as a module, so the right name is used.
>> Everything operates correctly when this module is builtin.
>>
>
> I'm sure this used to work. Do you know when/why it broke? Perhaps a
> Fixes: tag would be useful, and perhaps a Cc: stable?
>


I don't remember autoloading of rtc-tps6586x.ko has ever worked. Then there
is still the issue of rtc modules loaded too late for the kernel (or the
kernel not capable to defer the read of hw clock), but that's another issue.

I first tried to report the issue on this bug tracker and at that time,
autoloading wasn't working (was in 2014).
https://bugzilla.redhat.com/show_bug.cgi?id=1074002

I'm sure current distros using an arm generic kernel (with all modules)
will rebase on kernel 4.4, but technically the bug is present in kernel
3.10 from the oldest current maintained branch (since the driver
introduction).

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

--001a11401b5ab01740053283b695
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2016=
-05-10 17:43 GMT+02:00 Stephen Warren <span dir=3D"ltr">&lt;<a href=3D"mail=
to:swarren@wwwdotorg.org" target=3D"_blank">swarren@wwwdotorg.org</a>&gt;</=
span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"=
">On 05/10/2016 04:26 AM, Nicolas Chauvet wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
This module is loaded by the related mfd driver which has<br>
the needed MODULE_DEVICE_TABLE(i2c,...).<br>
<br>
This patch fix the modalias when the rtc driver is built<br>
as a module, so the right name is used.<br>
Everything operates correctly when this module is builtin.<br>
</blockquote>
<br></span>
I&#39;m sure this used to work. Do you know when/why it broke? Perhaps a Fi=
xes: tag would be useful, and perhaps a Cc: stable?<br>
</blockquote></div><br><br></div><div class=3D"gmail_extra">I don&#39;t rem=
ember autoloading of rtc-tps6586x.ko has ever worked. Then there is still t=
he issue of rtc modules loaded too late for the kernel (or the kernel not c=
apable to defer the read of hw clock), but that&#39;s another issue.<br><br=
>I first tried to report the issue on this bug tracker and at that time, au=
toloading wasn&#39;t working (was in 2014).<br><a href=3D"https://bugzilla.=
redhat.com/show_bug.cgi?id=3D1074002">https://bugzilla.redhat.com/show_bug.=
cgi?id=3D1074002</a><br><br></div><div class=3D"gmail_extra">I&#39;m sure c=
urrent distros using an arm generic kernel (with all modules) will rebase o=
n kernel 4.4, but technically the bug is present in kernel 3.10 from the ol=
dest current maintained branch (since the driver introduction).<br clear=3D=
"all"><br><br><br></div></div>

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

--001a11401b5ab01740053283b695--

Return-Path: <rtc-linux+bncBD47PQ46SILBBOEU47CQKGQEKBKN2SY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com. [2607:f8b0:4002:c05::236])
        by gmr-mx.google.com with ESMTPS id x124si1523619ywb.1.2017.03.03.11.55.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 11:55:36 -0800 (PST)
Received: by mail-yw0-x236.google.com with SMTP id s15so64881712ywg.0
        for <rtc-linux@googlegroups.com>; Fri, 03 Mar 2017 11:55:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303150949.qovbx5iifyuquloe@piout.net>
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
 <20170223121426.i24ssrlwitrvb32h@piout.net> <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu> <20170303150949.qovbx5iifyuquloe@piout.net>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 3 Mar 2017 20:55:35 +0100
Message-ID: <CAHTX3d+Av+8J2YrpSbZwv2CaJufukdE1K+aABHFOmDRck=C2JQ@mail.gmail.com>
Subject: Re: [rtc-linux] RTC used as a module
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: John Stultz <john.stultz@linaro.org>, rtc-linux@googlegroups.com
Content-Type: multipart/alternative; boundary=001a113e6ee6dc5b570549d8ed23
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a113e6ee6dc5b570549d8ed23
Content-Type: text/plain; charset=UTF-8

Hi

2017-03-03 16:09 GMT+01:00 Alexandre Belloni <
alexandre.belloni@free-electrons.com>:

> On 03/03/2017 at 15:46:36 +0100, Michal Simek wrote:
> > This is the function which is making the difference.
> >
> > It was added by John Stultz:
> > "timers: Introduce in-kernel alarm-timer interface"
> > (sha1:  ff3ead96d17f47ee70c294a5cc2cce9b61e82f0f)
> >
> > Probe function has device_init_wakeup(&pdev->dev, 1);
> > That's why reference is taken (get_device() below)
> >
> > static int alarmtimer_rtc_add_device(struct device *dev,
> >                               struct class_interface *class_intf)
> > {
> >       unsigned long flags;
> >       struct rtc_device *rtc = to_rtc_device(dev);
> >
> >       if (rtcdev)
> >               return -EBUSY;
> >
> >       pr_info("%s\n", __func__);
> >
> >       if (!rtc->ops->set_alarm)
> >               return -1;
> >
> >       pr_info("%s\n", __func__);
> >
> >       if (!device_may_wakeup(rtc->dev.parent))
> >               return -1;
> >
> >       spin_lock_irqsave(&rtcdev_lock, flags);
> >       if (!rtcdev) {
> >               rtcdev = rtc;
> >               /* hold a reference so it doesn't go away */
> >               get_device(dev);
> >       }
> >       spin_unlock_irqrestore(&rtcdev_lock, flags);
> >       return 0;
> > }
> >
> > And in remove function device_init_wakeup(&pdev->dev, 0);
> > But because there is still a reference rtc_device_release() is not
> > called and ida is not freed.
> >
> > Generic question which I think should be asked if in this situation
> > driver should be modular or not.
> > If driver can be modular then somewhere should be put_device().
> >
>
> From a quick look, I'd say the issue is coming from
> 8bc0dafb5cf38a19484dfb16e2c6d29e85820046 which removed the call to
> rtc_class_open so you can actually unload the module.
>
>
This is from 2011 which is kind of surprising.

M


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a113e6ee6dc5b570549d8ed23
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">2017-03-03 16:09 GMT+01:00 Alexandre Belloni <span dir=3D"ltr">&=
lt;<a href=3D"mailto:alexandre.belloni@free-electrons.com" target=3D"_blank=
">alexandre.belloni@free-electrons.com</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 03/03/2017 at 15:4=
6:36 +0100, Michal Simek wrote:<br>
&gt; This is the function which is making the difference.<br>
&gt;<br>
&gt; It was added by John Stultz:<br>
&gt; &quot;timers: Introduce in-kernel alarm-timer interface&quot;<br>
&gt; (sha1:=C2=A0 ff3ead96d17f47ee70c294a5cc2cce<wbr>9b61e82f0f)<br>
&gt;<br>
&gt; Probe function has device_init_wakeup(&amp;pdev-&gt;dev, 1);<br>
&gt; That&#39;s why reference is taken (get_device() below)<br>
&gt;<br>
&gt; static int alarmtimer_rtc_add_device(<wbr>struct device *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct class_interface *class_intf=
)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rtc_device *rtc =3D to_rtc_device(dev=
);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rtcdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info(&quot;%s\n&quot;, __func__);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtc-&gt;ops-&gt;set_alarm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info(&quot;%s\n&quot;, __func__);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_may_wakeup(rtc-&gt;dev.<wbr>pare=
nt))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rtcdev_<wbr>lock, fla=
gs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtcdev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtcdev =3D rtc;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hold a refere=
nce so it doesn&#39;t go away */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_device(dev);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;<wbr>rtcdev_lock=
, flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; }<br>
&gt;<br>
&gt; And in remove function device_init_wakeup(&amp;pdev-&gt;dev, 0);<br>
&gt; But because there is still a reference rtc_device_release() is not<br>
&gt; called and ida is not freed.<br>
&gt;<br>
&gt; Generic question which I think should be asked if in this situation<br=
>
&gt; driver should be modular or not.<br>
&gt; If driver can be modular then somewhere should be put_device().<br>
&gt;<br>
<br>
</div></div>From a quick look, I&#39;d say the issue is coming from<br>
8bc0dafb5cf38a19484dfb16e2c6d2<wbr>9e85820046 which removed the call to<br>
rtc_class_open so you can actually unload the module.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote></div>=
<br></div><div class=3D"gmail_extra">This is from 2011 which is kind of sur=
prising. <br><br></div><div class=3D"gmail_extra">M<br></div><div class=3D"=
gmail_extra"><br clear=3D"all"><br>-- <br><div class=3D"gmail_signature" da=
ta-smartmail=3D"gmail_signature">Michal Simek, Ing. (M.Eng), OpenPGP -&gt; =
KeyID: FE3D1F91<br>w: <a href=3D"http://www.monstr.eu" target=3D"_blank">ww=
w.monstr.eu</a> p: +42-0-721842854<br>Maintainer of Linux kernel - Microbla=
ze cpu - <a href=3D"http://www.monstr.eu/fdt/" target=3D"_blank">http://www=
.monstr.eu/fdt/</a><br>Maintainer of Linux kernel - Xilinx Zynq ARM archite=
cture<br>Microblaze U-BOOT custodian and responsible for u-boot arm zynq pl=
atform</div>
</div></div></div>

<p></p>

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

--001a113e6ee6dc5b570549d8ed23--

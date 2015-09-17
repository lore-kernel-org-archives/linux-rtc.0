Return-Path: <rtc-linux+bncBDS7HNEFSALRBK7F5KXQKGQEQX2EFBY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ch7si72588wib.2.2015.09.17.05.31.39
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Sep 2015 05:31:39 -0700 (PDT)
Date: Thu, 17 Sep 2015 14:31:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Xing Zheng <zhengxing@rock-chips.com>, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 9/9] rtc: hym8563: make sure hym8563 can be
 normal work
Message-ID: <20150917123138.GG4287@piout.net>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442486368-1912-1-git-send-email-zhengxing@rock-chips.com>
 <3439697.Ymf0XB1EzX@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <3439697.Ymf0XB1EzX@diego>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 17/09/2015 at 14:07:47 +0200, Heiko St=C3=BCbner wrote :
> Am Donnerstag, 17. September 2015, 18:39:28 schrieb Xing Zheng:
> > The rtc hym8563 maybe failed to register if first startup or rtc
> > powerdown:
> > [    0.988540 ] rtc-hym8563 1-0051: no valid clock/calendar values avai=
lable
> > [    0.995642 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc=
0 [=20
> >   1.078985 ] rtc-hym8563 1-0051: no valid clock/calendar values availab=
le [
> >    1.085698 ] rtc-hym8563 1-0051: hctosys: unable to read the hardware
> > clock
> >=20
> > We can set initial time for rtc and register it:
> > [    0.995678 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc=
0
> > [    1.080313 ] rtc-hym8563 1-0051: setting system clock to 2000-01-01
> > 00:02:00 UTC (946684920)
>=20
> hmm, not setting a false date was actually intentional when I did the dri=
ver.
>=20
> In my mind it is better to shout and keep programs from using wrong value=
s=20
> than to set some arbitary date and let programs silently use this wrong v=
alue.
>=20

Indeed, I find it worse to set a wrong value instead of returning an
error. Userspace has to define its policy when reading the time fails.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

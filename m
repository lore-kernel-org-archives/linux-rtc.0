Return-Path: <rtc-linux+bncBAABBMGH5KVQKGQEFJZDF4A@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id u1si432894qck.0.2015.06.12.02.17.36
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Jun 2015 02:17:36 -0700 (PDT)
In-Reply-To: <20150612084027.GD3890@piout.net>
References: <1434074652-16054-1-git-send-email-xlpang@126.com> <20150612084027.GD3890@piout.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com,
        Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [PATCH v3 1/4] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
MIME-Version: 1.0
Message-ID: <OFFC6B610F.4108EED3-ON48257E62.0032A044-48257E62.00330C68@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Fri, 12 Jun 2015 17:17:39 +0800
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 2015-06-12=
=20
PM 04:40:27:
>=20
> Re: [PATCH v3 1/4] drivers/rtc/pcf8563: Replace deprecated=20
> rtc_time_to_tm() and rtc_tm_to_time()
>=20
> Hi Xunlei,
>=20
> Just to let you know that your series are usually classified as spam
> when coming from 126.com. This series in particular didn't make it to
> the mailing list.

Seems ok, I can see it in the mailing list now:
https://lkml.org/lkml/2015/6/11/767

Thanks,
-Xunlei

>=20
> I'll take it anyway  but you may want to check that your other patches
> are being received by the maintainers.
>=20
> On 12/06/2015 at 10:04:09 +0800, Xunlei Pang wrote :
> > From: Xunlei Pang <pang.xunlei@linaro.org>
> >=20
> > pcf8563_rtc_set_alarm() uses deprecated rtc_tm_to_time()
> > and rtc_time_to_tm(), which will overflow in year 2106
> > on 32-bit machines.
> >=20
> > This patch solves this by:
> >  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
> >  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> > ---
> > v2->v3:
> > no changes.
> >=20
> >  drivers/rtc/rtc-pcf8563.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> > index 0ba7e59..5f87f84 100644
> > --- a/drivers/rtc/rtc-pcf8563.c
> > +++ b/drivers/rtc/rtc-pcf8563.c
> > @@ -363,13 +363,13 @@ static int pcf8563_rtc_set_alarm(struct=20
> device *dev, struct rtc_wkalrm *tm)
> >     struct i2c_client *client =3D to_i2c_client(dev);
> >     unsigned char buf[4];
> >     int err;
> > -   unsigned long alarm_time;
> >=20
> >     /* The alarm has no seconds, round up to nearest minute */
> >     if (tm->time.tm_sec) {
> > -      rtc_tm_to_time(&tm->time, &alarm_time);
> > -      alarm_time +=3D 60-tm->time.tm_sec;
> > -      rtc_time_to_tm(alarm_time, &tm->time);
> > +      time64_t alarm_time =3D rtc_tm_to_time64(&tm->time);
> > +
> > +      alarm_time +=3D 60 - tm->time.tm_sec;
> > +      rtc_time64_to_tm(alarm_time, &tm->time);
> >     }
> >=20
> >     dev_dbg(dev, "%s, min=3D%d hour=3D%d wday=3D%d mday=3D%d "
> > --=20
> > 1.9.1
> >=20
> >=20
>=20
> --=20
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

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

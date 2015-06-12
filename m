Return-Path: <rtc-linux+bncBAABBUPX5CVQKGQE3WHS45A@googlegroups.com>
Received: from mx6.zte.com.cn (mx6.zte.com.cn. [95.130.199.165])
        by gmr-mx.google.com with ESMTP id t6si48526wiz.0.2015.06.11.18.54.24
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Jun 2015 18:54:25 -0700 (PDT)
Received: from zte.com.cn (unknown [192.168.168.119])
	by Websense Email Security Gateway with ESMTP id E790FDA2E2842
	for <rtc-linux@googlegroups.com>; Fri, 12 Jun 2015 09:52:35 +0800 (CST)
In-Reply-To: <20150611170619.GM5222@piout.net>
References: <1433235862-1638-1-git-send-email-xlpang@126.com> <1433235862-1638-2-git-send-email-xlpang@126.com> <20150611170619.GM5222@piout.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com,
        Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [PATCH v2 2/4] rtc/lib: Introduce rtc_tm_subtract()
 helper function
MIME-Version: 1.0
Message-ID: <OF9B56AD48.E6F20464-ON48257E62.000A21CB-48257E62.000A7C13@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Fri, 12 Jun 2015 09:54:35 +0800
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
AM 01:06:19:
> Re: [PATCH v2 2/4] rtc/lib: Introduce rtc_tm_subtract() helper function
>=20
> Hi,
>=20
> I'm fine with the whole series, I would just rename things a bit:
>=20
> On 02/06/2015 at 17:04:20 +0800, Xunlei Pang wrote :
> >  /*
> > + * rtc_tm_subtract - Return the difference in seconds.
> > + */
> > +time64_t rtc_tm_subtract(struct rtc_time *minuend, struct=20
> rtc_time *subtrahend)
> > +{
> > +   return rtc_tm_to_time64(minuend) - rtc_tm_to_time64(subtrahend);
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_tm_subtract);
> > +
> > +/*
> >   * Convert rtc_time to ktime
> >   */
> >  ktime_t rtc_tm_to_ktime(struct rtc_time tm)
> > diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> > index 8dcf682..13e4138 100644
> > --- a/include/linux/rtc.h
> > +++ b/include/linux/rtc.h
> > @@ -21,6 +21,8 @@ extern int rtc_year_days(unsigned int day,=20
> unsigned int month, unsigned int year
> >  extern int rtc_valid_tm(struct rtc_time *tm);
> >  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
> >  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
> > +extern time64_t rtc_tm_subtract(struct rtc_time *minuend,
> > +      struct rtc_time *subtrahend);
>=20
> I would use something closer to what is done for timespecs in time.h,
> like:
>=20
> static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time=
=20
*rhs)
> {
>    return rtc_tm_to_time64(lhs) - rtc_tm_to_time64(rhs);
> }
>=20
> and not modify rtc-lib.c
>=20
> Can you make that modification ?

OK, I like this as well, will do.

Thanks,
-Xunlei

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.
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

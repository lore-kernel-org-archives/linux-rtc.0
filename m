Return-Path: <rtc-linux+bncBAABBOWCWSVQKGQERHBBYMQ@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id x3si1713102pdh.2.2015.06.01.20.21.30
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Jun 2015 20:21:30 -0700 (PDT)
In-Reply-To: <3461238.S8UhmYfQDn@wuerfel>
References: <1432911877-607-1-git-send-email-xlpang@126.com> <1432911877-607-3-git-send-email-xlpang@126.com> <3461238.S8UhmYfQDn@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Carlo Caione <carlo.caione@gmail.com>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH RESEND 3/3] drivers/rtc/sunxi: Replace
 deprecated rtc_tm_to_time()
MIME-Version: 1.0
Message-ID: <OF21D1C9CA.9D69E6EA-ON48257E58.00122AC0-48257E58.00126EEE@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Tue, 2 Jun 2015 11:21:24 +0800
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

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote 2015-06-02 AM 03:53:03:
> Re: [PATCH RESEND 3/3] drivers/rtc/sunxi: Replace deprecated=20
rtc_tm_to_time()
>=20
> On Friday 29 May 2015 23:04:37 Xunlei Pang wrote:
> >         }
> >=20
> > -       rtc_tm_to_time(alrm_tm, &time_set);
> > -       rtc_tm_to_time(&tm_now, &time_now);
> > +       time_set =3D rtc_tm_to_time64(alrm_tm);
> > +       time_now =3D rtc_tm_to_time64(&tm_now);
> >         if (time_set <=3D time_now) {
> >                 dev_err(dev, "Date to set in the past\n");
> >                 return -EINVAL;
> >         }
> >=20
> > +       if (time_set > time_now + 255 * SEC_IN_DAY) {
> > +               dev_err(dev, "Day must be in the range 0 - 255\n");
> > +               return -EINVAL;
> > +       }
> > +
> >=20
>=20
> So this driver also uses the two values just to do a comparison
> and to take the difference in seconds.
>=20
> If we have a helper function that returns the difference between
> two rtc_tm values as a time64_t, we can use that for both
> this driver and isl1208.

Indeed, will do.

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

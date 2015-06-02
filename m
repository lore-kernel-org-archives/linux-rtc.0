Return-Path: <rtc-linux+bncBAABB4WAWSVQKGQEBOHDVIQ@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id ct6si328413pdb.1.2015.06.01.20.18.10
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Jun 2015 20:18:10 -0700 (PDT)
In-Reply-To: <1433147260.2361.25.camel@x220>
References: <1432910778-314-1-git-send-email-xlpang@126.com> <1433147260.2361.25.camel@x220>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        John Stultz <john.stultz@linaro.org>, linux-cris-kernel@axis.com,
        linux-kernel@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>,
        rtc-linux@googlegroups.com, sparclinux@vger.kernel.org,
        Mikael Starvik <starvik@axis.com>, Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE
 for NTP synchronization
MIME-Version: 1.0
Message-ID: <OFA83CEB22.B9F4BDE6-ON48257E58.0011E159-48257E58.00122289@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Tue, 2 Jun 2015 11:18:09 +0800
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

Hi Paul,

Paul Bolle <pebolle@tiscali.nl> wrote 2015-06-01 PM 04:27:40:
>=20
> Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP=20
> synchronization
>=20
> On Fri, 2015-05-29 at 22:46 +0800, Xunlei Pang wrote:
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
>=20
> >  config RTC_HCTOSYS_DEVICE
> >     string "RTC used to set the system time"
> > -   depends on RTC_HCTOSYS =3D y || RTC_SYSTOHC =3D y
> > +   depends on RTC_HCTOSYS =3D y
>=20
> RTC_HCTOSYS and RTC_SYSTOHC are bool symbols. The "=3D y" test is not
> needed and the common idiom is to use only
>    depends on RTC_HCTOSYS
>=20
> Since you're touching this you might as well switch to that idiom.
>=20
> >     default "rtc0"
> >     help
> >       The RTC device that will be used to (re)initialize the system
> >      minutes if userspace reports synchronized NTP status.
>=20
> > +config RTC_SYSTOHC_DEVICE
> > +   string "RTC used to synchronize NTP adjustment"
> > +   depends on RTC_SYSTOHC =3D y
>=20
> Likewise.

Yea, thanks for pointing this out.

-Xunlei

>=20
> > +   default "rtc0"
> > +   help
> > +     The RTC device used for NTP synchronization. The main difference
> > +     between RTC_HCTOSYS_DEVICE and RTC_SYSTOHC_DEVICE is that this
> > +     one can sleep when setting time, because it runs in the=20
workqueue
> > +     context.
>=20
>=20
> Paul Bolle
>=20

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

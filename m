Return-Path: <rtc-linux+bncBDS4VBOTRMFRBH7F3CVAKGQEXCFY5DI@googlegroups.com>
Received: from ni.com (skprod2.natinst.com. [130.164.80.23])
        by gmr-mx.google.com with ESMTPS id ax9si255697igc.1.2015.05.15.10.53.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 10:53:35 -0700 (PDT)
Date: Fri, 15 May 2015 12:53:30 -0500
From: Josh Cartwright <joshc@ni.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: akpm@linux-foundation.org, Alessandro Zummo <a.zummo@towertech.it>,
        Kevin Wells <wellsk40@gmail.com>, rtc-linux@googlegroups.com,
        devicetree@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        alexandre.belloni@free-electrons.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: add rtc-lpc24xx driver
Message-ID: <20150515175330.GL23600@jcartwri.amer.corp.natinst.com>
References: <1431696306-19093-1-git-send-email-manabian@gmail.com>
 <1431696306-19093-2-git-send-email-manabian@gmail.com>
 <20150515152312.GG23600@jcartwri.amer.corp.natinst.com>
 <CAGhQ9VxpN-dSgWS0tJMeik7o_DsRdRo=Mf=Ap1L3j988abcHfQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGhQ9VxpN-dSgWS0tJMeik7o_DsRdRo=Mf=Ap1L3j988abcHfQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdEQJo40s7ofW8iR"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, May 15, 2015 at 06:31:53PM +0200, Joachim Eastwood wrote:
> On 15 May 2015 at 17:23, Josh Cartwright <joshc@ni.com> wrote:
> > Hello again,
> >
> > On Fri, May 15, 2015 at 03:25:05PM +0200, Joachim Eastwood wrote:
> >> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
> >> The RTC provides calendar and clock functionality together with
> >> periodic tick and alarm interrupt support.
> >>
> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> >> ---
[..]
> >> +static int lpc24xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >> +{
> >> +     struct lpc24xx_rtc *rtc = dev_get_drvdata(dev);
> >> +     u32 ct0, ct1, ct2;
> >> +
> >> +     ct0 = rtc_readl(rtc, LPC24XX_CTIME0);
> >> +     ct1 = rtc_readl(rtc, LPC24XX_CTIME1);
> >> +     ct2 = rtc_readl(rtc, LPC24XX_CTIME2);
> >> +
> >> +     tm->tm_sec  = CT0_SECS(ct0);
> >> +     tm->tm_min  = CT0_MINS(ct0);
> >> +     tm->tm_hour = CT0_HOURS(ct0);
> >> +     tm->tm_wday = CT0_DOW(ct0);
> >> +     tm->tm_mon  = CT1_MONTH(ct1);
> >> +     tm->tm_mday = CT1_DOM(ct1);
> >> +     tm->tm_year = CT1_YEAR(ct1);
> >> +     tm->tm_yday = CT2_DOY(ct2);
> >> +
> >> +     if (rtc_valid_tm(tm) < 0) {
> >> +             dev_warn(dev, "retrieved date and time is invalid\n");
> >> +             rtc_time64_to_tm(0, tm);
> >> +             lpc24xx_rtc_set_time(dev, tm);
> >> +     }
> >> +
> >> +     return 0;
> >
> > Forcing the read time to be the epoch on failure seems like a pretty
> > poor way to handle errors, in my opinion.
> 
> When the device doesn't have battery the CTIME registers contains an
> invalid value. So if you don't set them to something valid you will
> get a warning each time you try to read the RTC. To "fix" that problem
> I set the time at epoch which make the CTIME registers to contain a
> valid value. Since the value is already useless I think setting it to
> epoch is an improvement in this case.

I see.  I think doing this setting in your read_time callback is the
wrong place to do this check.  I'm thinking a better place for it would
be in your driver's probe().

> I guess it deserves a comment in the driver.

Yes, I agree.

  Josh

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

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVVjKXAAoJEKp7ZBKwQFArldQH/iWNtf8idt6ORu8BUFk+waPi
meFS6puY8+Nkz4MJ6KAUWspmn+f7+uCKfbff1y288X0nJ83Oz455eS8OxTH2lIug
lV/LjlW0x/WUbJrQsVzd/GlVlwN87WEr8zjRLzzYA33jPdRhv+Zw52De/685u7DW
V65LqunxpGTuYPhkEMzV9kMwYhXOV+zgIJc1q1u7aAbSoAGouutDcoIcMdI+WIFF
ImUPbuVITh0wNPQ7QNH5MvBtwN97//OZWCxbHo7r5X9vCocWkXqsUlqKqV7KmrKX
cn6RFFBv1clO8YVfS39tn0hVNRIzE+gP73VENWMpfDbs2f62ZCPLf4GrqrJOryE=
=Vb0Q
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--

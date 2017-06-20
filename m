Return-Path: <rtc-linux+bncBDZKLXNI4ACBB7OEUTFAKGQEUCTQ7SY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id q191si3016731wme.2.2017.06.20.06.26.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 06:26:21 -0700 (PDT)
Date: Tue, 20 Jun 2017 15:26:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	linaro-kernel@lists.linaro.org,
	adi-buildroot-devel@lists.sourceforge.net,
	Alessandro Zummo <a.zummo@towertech.it>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ingo Molnar <mingo@redhat.com>, Jason Cooper <jason@lakedaemon.net>,
	John Stultz <john.stultz@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Baruch Siach <baruch@tkos.co.il>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	patches@opensource.wolfsonmicro.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
Message-ID: <20170620132620.GA16881@amd>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <20170620122400.sm7qqvwyj6cuzarw@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Tue 2017-06-20 14:24:00, Alexandre Belloni wrote:
> On 20/06/2017 at 14:10:11 +0200, Pavel Machek wrote:
> > On Tue 2017-06-20 12:03:48, Alexandre Belloni wrote:
> > > On 20/06/2017 at 11:35:08 +0200, Benjamin Gaignard wrote:
> > > > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > > > rely on 32bits variables and that will make rtc break in y2038/2016.
> > > 
> > > Please don't, because this hide the fact that the hardware will not
> > > handle dates in y2038 anyway and as pointed by Russell a few month ago,
> > > rtc_time_to_tm will be able to catch it but the 64 bit version will
> > > silently ignore it.
> > 
> > Reference? Because rtc on PCs stores date in binary coded decimal, so
> > it is likely to break in 2100, not 2038...
> 
> I'm not saying it should be done but clearly, that is not the correct
> thing to do for RTCs that are using a single 32 bits register to store
> the time.
> You give one example, I can give you three: armada38x, at91sam9,
> at32ap700x and that just in the beginning of the series.

I wanted reference to Russell's mail.

> And yes, on PC, they will break in 2100, other in 2106, some in 2070.
> I've delayed the tree wide patching until I manage to finish reworking
> the infrastructure needed to handle the limits of the RTCs.

Kernel does not know if it has working RTC or not, so it should use
64bit variables. Merging this -- does not hide anything. Yes, some
drivers still may have problems -- so we fix the drivers.

You said:

> > > rtc_time_to_tm will be able to catch it but the 64 bit will
> > > silently ignore it.

If that's the case, we may need 64bit version to be smarter.. but
we'll still need 64bit variables in the kernel.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllJInwACgkQMOfwapXb+vKvOACfa+kGFBRxWhkRpGKLgcPlEMXc
Xp4An1BROF4v4jttS9yXrXm9FyxGRyLs
=CY2S
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

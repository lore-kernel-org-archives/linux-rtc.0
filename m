Return-Path: <rtc-linux+bncBDXMLNOH5ANRBGEKVXCQKGQEXXX22UI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id s64si1840130pfk.0.2017.02.20.11.35.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2017 11:35:51 -0800 (PST)
Date: Mon, 20 Feb 2017 20:35:42 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: cpcap: new rtc driver
Message-ID: <20170220193542.ey5cn46vusipmrv7@earth>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170220073535.27393-2-sre@kernel.org>
 <20170220163155.GH21809@atomide.com>
 <20170220163858.4ocqnfhei67wbtl3@piout.net>
 <20170220172103.GI21809@atomide.com>
 <20170220172737.GJ21809@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cd36rqh53rb7a4ar"
In-Reply-To: <20170220172737.GJ21809@atomide.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--cd36rqh53rb7a4ar
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2017 at 09:27:37AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170220 09:21]:
> > * Alexandre Belloni <alexandre.belloni@free-electrons.com> [170220 08:40]:
> > > On 20/02/2017 at 08:31:56 -0800, Tony Lindgren wrote:
> > > > * Sebastian Reichel <sre@kernel.org> [170219 23:37]:
> > > > > This driver supports the Motorola CPCAP PMIC found on
> > > > > some of Motorola's mobile phones, such as the Droid 4.
> > > > 
> > > > Hey that's cool, works for me for reading and setting date :)
> > > > Just noticed one thing, see below.
> > > > 
> > > > > +Requires node properties:
> > > > > +- compatible: should contain "motorola,cpcap-rtc"
> > > > > +- interrupts: An interrupt specifier for alarm and 1 Hz irq
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +cpcap_rtc: rtc {
> > > > > +	compatible = "motorola,cpcap-rtc";
> > > > > +	interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
> > > > > +};
> > > > 
> > > > I tried rtcwake -s 3, but got the following:
> > > > 
> > > > rtcwake: cannot open /sys/class/rtc/rtc0/device/power/wakeup:
> > > > No such file or directory
> > > > rtcwake: /dev/rtc0 not enabled for wakeup events
> > > > 
> > > > Then tried adding "wakeup-source" to above but I think the driver
> > > > needs something, maybe probably just PM ops?
> > > > 
> > > 
> > > Probably device_init_wakeup(dev, 1) ?
> > 
> > That gets us a bit closer but now produces:
> > 
> > rtcwake: write error
> 
> Oh user error.. It needs to be done with:
> 
> # rtcwake -s 3 -m mem
> 
> And with the addition of device_init_wakeup(dev, 1) to the probe
> it works for me. So Sebastian, with that change, please feel free
> to add:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Nice. I actually forgot to mention, that its missing wakeup support
for now and now its already done :) I will resend later.

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--cd36rqh53rb7a4ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlirRQsACgkQ2O7X88g7
+pqedg/8DwDEBxV8ruyGsvuhWcZjrrKX+s4KV9PQL33G3A7YCpftwPHgBsSeyEK9
bKBdfpBcvHwwHwbSVBAln6ZFknKsxsc/RB6PT20kMOWnzC58R5PVCZRaZn4JYy/q
yQrvKJ3xgPyuZACtsBJ9bhAy+AS54L+RPNU9sHy/Unwg7tMo/xjPsBBhzeRdirJx
m4FiN9ENzVciOdrkzDuwtbMyI8roeHkHxXB2Qx2hR+zOy21+aZyEXeIwCg9ZJkML
6RxJYQvX4BQwOta5x3Rne9wD2toWu4C7JpeZbWIqL9cDROusHiKccJxfwjX0bog8
lMyxb0Pg3rlmeIEBkkdvM4AtYOjjPZcq5taIyKWSM8L6QRMdUSHa4MUMtGK9UjKA
mDoNmGqyBPl1JQK7LTVX+wntzLPD7k+dgd7kW4EU6bP+Da915ka/GOEEMjH739x6
rzLdjT44hc4fHwKPD4F/cTAqtZ26l3u9PIghaqclNBWm/u8orfTk0cSKpO41M/NG
6H7vOXKx/LYRbgqYXWA27+gJ5STyxmSv9E56vTHA74lWkv1VFFv6aYp7dpeXz9+B
QGprewVxXO11ydNAjflQRjG9OjZd32w4eApoG2jE10VqMDU4w6MwBVnFKhxW3xug
QifoeQL/l/ZLKTqUUlFdoH9t00hQyIqhdj3wsFD+FEibmg8zNa8=
=gaMO
-----END PGP SIGNATURE-----

--cd36rqh53rb7a4ar--

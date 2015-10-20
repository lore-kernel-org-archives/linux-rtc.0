Return-Path: <rtc-linux+bncBDXMLNOH5ANRBXXATKYQKGQEJDCFQMY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id fa8si647852pab.1.2015.10.20.14.21.33
        for <rtc-linux@googlegroups.com>;
        Tue, 20 Oct 2015 14:21:33 -0700 (PDT)
Date: Tue, 20 Oct 2015 23:21:27 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: where in sysfs should I put the ability to power down
 a board for a specific time?
Message-ID: <20151020212127.GA25882@earth>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
> There is a system controller [1] on a set of embedded boards I support
> that allows disabling the board's primary power supply. It can disable
> it (until a physical pushbutton event occurs) and/or disable it for a
> certain number of seconds (up to 2^16 seconds).
> 
> I've been in the process of writing a mfd driver to fully support this
> device and I'm a bit stumped on how to handle the power management
> capabilities.
> 
> What is the correct API for this type of device in sysfs? I'm thinking
> it needs a power-supply class driver, but after looking over the docs
> and code I'm not seeing examples of similar devices. Can anyone point
> me to an example or provide some suggestions?

Usually this is an RTC feature exposed as wakealarm. See for example
this article for the description of the userspace interface:

https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clock

-- Sebastian

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

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWJrBRAAoJENju1/PIO/qaCCYP/RoUJbjBTOvL+Rl9oWLlC6w+
IWgLIDpt11+aYaCZN1jKG7nWBn5h9G6E+FLgYbJ4+qojjcMD0BMqFPaKqFHVYG0R
YUqjF/dQdbi9GCF6iFQ8Yk8/oXGI8GbCsSzqBOyowRhbWuXPNc27veK6X2ANzcf3
FQgmxYhnECFc5dp9qwW79prwtO1VWTNbAyiyXTwGJXnWtPTwUGfOSTky5UddK0yJ
3UubV3qwp61Y7etibb5BNJsHKZJq5ilyFC46NZirs3IP6aYouDwfOQJAJmiN48+z
LfYJlzJ9Xcr+CbehQHPC962W775QEOeM2TxoqdmQ2bdOtZ4FPSu6TFhlmzyd5cYw
mRjtF3D4g5YpS365luxWAHwYYlFywBdrOvo6WVum73GLnSRToG3JLAKrqw9XWrrt
RsiQW5AYos/ayjehbplPsxt7GGWq7y0plBdrh3uj7POi6j3xtkUEvsegNETlg0mJ
xHtrjEh2b++Asg7+j5Zoa5IfRC7zoi9GuKb333Cl2P8aDvjg5m4WcKRb+HU1RFFn
iswqVIdJqreaRpbAE5ze+3LDCCOpElX5jKwphQ67fO25svAyjIcHZz0+7gXrg8Ij
4w5OLlqjpm1fRUApwLBRgh/R2Fr7Ycn9f1f+4lsLwuUiufCEWG9dAkQaIDgDTq+W
SJOowHmJCuk2ooXtOnki
=WJ26
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

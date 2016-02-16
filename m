Return-Path: <rtc-linux+bncBC3JZ2XR4EBBBK4PRW3AKGQEENQQ54A@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id 79si4116080pft.0.2016.02.16.08.00.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 08:00:43 -0800 (PST)
Date: Tue, 16 Feb 2016 17:00:30 +0100
From: Thierry Reding <treding@nvidia.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<swarren@nvidia.com>, <k.kozlowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH V8 0/8] Add support for MAXIM
 MAX77620/MAX20024 PMIC
Message-ID: <20160216160029.GC11400@ulmo.nvidia.com>
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Feb 11, 2016 at 05:26:26PM +0530, Laxman Dewangan wrote:
> Add SW support for MAXIM Semiconductor's Power Management
> IC (PMIC) MAX77620/MAX20024. This PMIC supports DC-DC/LDOS, GPIOs,
> RTC, watchdog, clocks etc.

Hi Laxman,

This series is starting to look pretty good. Do you have patches in the
works to add the corresponding DT content for the various boards that we
support? I think the Jetson TX1 patch would be most interesting since
that's what people can get their hands on.

Thierry

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

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWw0eZAAoJEN0jrNd/PrOhF3MQALprc3PjZZEoo34c9CwlzmeU
C6Wu6BahoOfYkxlodpfMQv4CxBj2R8kG+DIta8BWRmyEftz+B/CU9Ogc19R8U6oW
hrn2d9u0aZF2bK7j8O3F3CLNnC/PQ19V/3aYWviPE+QEZX1u7quW/L1XCeleYLLy
xcDX4fIjO3PtYziw0j4m7wCnTG+41dQNV4y59D6dJlZBAX6Xg6nATIKlwG/A0lQK
tecOYFZFVVlTBZ0n9HoXK3ZfhRrjb7xEuMenGXyUkSHCnKh6hF1GXPGSHs/GR8Vw
pslrkHwg9oeXzXYo591aj1S8tGd8DyMalntG7FkHQFVdEgIsjyQs9JnBqSv1+vWx
EQ3U090gY3crcW5iXo6HKgS0wNIMb5hxfSHnnGqtpnqQbV1aZz4Kq2Vooj/+35lS
iiu78M/OFtYR77DI6G5O8XnXVQ+s5YEGabHpTQOkTAP9feilCN1SXxe01b2ZspI+
4p+PP9wSwpzgCcdmAw4tReFpEpiaMd3Py9sdWiLKYvNpdGBe6NndpmPOmd/LuwUt
PJdE8nMXAmGHNEN3y1pI8fRG/xUPRUWfomxizMegn9UFeiux5rDnDIxucawtnD37
8j1y29u14T5EGfHUfeUvrr0lK5qDZx7bf/F7HXf6Jkz/tHkDMzFr7y26G+hZjkRa
63RXGyQxuIm0RqKWV+Tz
=7nt0
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--

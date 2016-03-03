Return-Path: <rtc-linux+bncBDXMLNOH5ANRBLG64C3AKGQENDQON4Y@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id r75si4313560pfr.0.2016.03.03.04.33.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 04:33:48 -0800 (PST)
Date: Thu, 3 Mar 2016 13:33:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Lee Jones <lee.jones@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, linux-samsun@comu.ring0.de,
	g-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-usb@vger.kernel.org
Subject: [rtc-linux] Re: [RFC 11/15] power: reset: keystone: Add missing
 MFD_SYSCON dependency on HAS_IOMEM
Message-ID: <20160303123343.GB5687@earth>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
 <5230562.E0gg2SNP0m@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
In-Reply-To: <5230562.E0gg2SNP0m@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Thu, Mar 03, 2016 at 12:00:14PM +0100, Arnd Bergmann wrote:
> On Thursday 03 March 2016 17:03:37 Krzysztof Kozlowski wrote:
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 0a6408a39c66..0f34846ae80d 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -141,6 +141,7 @@ config POWER_RESET_XGENE
> >  config POWER_RESET_KEYSTONE
> >         bool "Keystone reset driver"
> >         depends on ARCH_KEYSTONE
> > +       depends on HAS_IOMEM    # For MFD_SYSCON
> >         select MFD_SYSCON
> >         help
> >           Reboot support for the KEYSTONE SoCs.
> > 
> 
> This is platform specific, but we should probably add || COMPILE_TEST
> along with the HAS_IOMEM dependency.

Sounds sensible. Will you guys send an updated patch?

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

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2C8kAAoJENju1/PIO/qanpwP+gJywD4VE/gT2ZagnJwhE8Em
JgZwSnA2KU0yEoOurmOEgsRBCIlaPXwmYe9tO/9vQ8akB9wuNKoxMHOda16G6894
PsRCgyloYocmcC1MFVp6oioPryISIP0Ik71pAkvqL35HZupN715sCynWvQsTY9nN
gPR7sTbfDv7OT1sHdU8qOkacJgHglCYlbtoaOvVzF16A4G35wCXAH5WqQyQ6kbOv
X8SyBARnrW3P/qyUe5jlGw1DLZYi4VsMi16JE1btxFCQNXN0zu848LHAK2xvwhqK
Yy+TKxGP6l45RKin/p/zAv6ThZ29nLvo8E2PP6CX4Ed1qKWQWEt8q32sf8lDdFhB
PKF7hOEmoFRojO/YZ1sKZSMg7BEwTYliAT8fmWohi4mnKJgsywJKYgwr831Zs1RR
UepUK0XGsyF/BgymLiqAmoRjHphpXzykY4mnCo1/sNdM4kzkvnb4zwu4+QcQRSJW
CTrGxrvZ66YND4vWGHFiglNJ3SNdgVLY//iFkXWXyNYnlvk1o6A4bwWmCHXynew8
aWr6lbqqpEYD1EF2JvbXkPqvCogH6enSjy2cb17SSXT/Ua87jOfsv+/s4DP0+ZM/
izsOe6ao6pwn5ZZ5NY1k+5M9MDNbpmmr9lXfoSvm7E4TkcJzxWMDYgodmtgOpbmJ
FDmyIoussJMr/fnkKPhf
=hIFl
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

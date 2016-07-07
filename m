Return-Path: <rtc-linux+bncBDSJBYGBRIMBBWX7665QKGQELQZJD3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 65si47906wmr.3.2016.07.07.00.08.09
        for <rtc-linux@googlegroups.com>;
        Thu, 07 Jul 2016 00:08:09 -0700 (PDT)
Date: Thu, 7 Jul 2016 09:08:09 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Stephan Roslen <stephan@roslen.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
Message-ID: <20160707070809.GB5907@lukather>
References: <577CC494.8020103@roslen.de>
 <20160706202000.GC4247@lukather>
 <577DDF8C.6060404@roslen.de>
 <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
 <577DF2B9.602@roslen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
In-Reply-To: <577DF2B9.602@roslen.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jul 07, 2016 at 08:12:09AM +0200, Stephan Roslen wrote:
> > Within the current sunxi clk structure, the LOSC is registered as a fixed
> > 32.768 KHz clk. So this patch actually makes things right.
> 
> In this case it should still be addressed somewhere in drivers/clk/sunxi, not 
> in drivers/rtc, I guess? Would you prefer setting the external 32.768 KHz crystal
> as hard coded default instead of providing the muxer? It could be considered okay,
> for the data sheet seems to demand presence of the external oscillator and there
> is absolutely no use in a 32KHz +- 20% oscillator, if a 32.768KHz crystal is
> available.

Yes, poking into the registers in drivers/clk would also work.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXff/ZAAoJEBx+YmzsjxAgKk8QAKOltZhAGJe9VkbyrMURjWnT
WQR+2N1doXVoigf7v2+ZaEijpxgPxAi0SRvNcc0+Mhdc21jJQM3imWpd1CME96di
NXbpeOU1zy6Ab6QdZYDBXLyEYUsVVViRy8leNmh+zWWK03nC751B5kpZ8lOw2sYI
nBxw3hZD6FXvHundk4/eS6V/1X7V4o8xJ1/7zZkD2Z60hfhQ5rfVxobtEYzg78Xi
l9cldWv0q3slPbldKtxb4MpPJJg1k3KANHVNNtArRudpnY6HyHOYOHjz0QmFalmy
l7SOF4n/tMAOlDGZzSUfGptGtd0A2/VLXpiMSOErsQcm/NCDKVBL9BRIW/vWJRY2
CIt+d5ws87YNPI68qsO3IEtRA1QEmCBgvYSVneoxJLQI2OgSfSZQMTwGk/fjQ3Be
pxSP9RL6D7ondOyLGOztaDL7I02tkTX4EWLtiXMDdb6MLs9v9GdFuBPylO2fDFL5
eO5v3+nd1G10MSNr/T+CLNRY4+hVfjctjFhNR4rQV9XfyF0MDIMjPGDqpPEQfJy/
zRnfsxLapTxdMOYyYGbs6ffJL/wWzFbqcshnSbHSs2RC1hZLWdTfLWm0FXy7HYts
f5xubRqsVH1GeKaB0RMqPHducdNT5L7hzD0sgmBvZ01MK40NnDRY6htaEwz9zaaZ
Svp7N7r9unHCTsKPznwG
=PbgV
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

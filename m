Return-Path: <rtc-linux+bncBDU7VC56WAFBBHPHZK3AKGQE7ONUWUA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c143si392898wmd.1.2016.02.28.00.45.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 00:45:17 -0800 (PST)
Date: Sun, 28 Feb 2016 09:44:52 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228094452.132c1938@wiggum>
In-Reply-To: <20160228003139.GB2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SEvEVDD79CQCr=eKIxzwMgh"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/SEvEVDD79CQCr=eKIxzwMgh
Content-Type: text/plain; charset=UTF-8

On Sun, 28 Feb 2016 01:31:39 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> trickle charging is usually enabled using device tree, however, I'd
> really like to see more standardization on the property names.

Is there an example of an rtc driver implementing this?
For the rv3029 it's more than just enabling it. It also has a bunch of
charging resistors to choose from.

> I'm not sure yet about the temperature compensation. I've just merged
> the crystal offset modification api with a sysfs interface in rtc-next:
> http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=5f23807caab7801c3333c68417bb13c7e2439193
> 
> But this doesn't seem enough for that particular RTC.

The rv3029 does the compensation internally. It just needs to be
enabled via a bit in its EEPROM. We could probably always set that bit
though. I'm not sure whether there is a case where one would not want
that.

-- 
Michael

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

--Sig_/SEvEVDD79CQCr=eKIxzwMgh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0rOEAAoJEPUyvh2QjYsOuUoP/38ka/SgFhtvLICl8gvxpOZ4
5VB+xxzsFUPsJ387Q2nVVM91TH/cQ/smS1GcrdvgEmCtRT+MTsv4qc5+8j0s/l4S
mvUh8Z20Dc8f8yJ+U7zqdfBw7G14EHkEr4MrrYNKr/bkXiJ0GFcjAzzcu8vwrcfk
92bbgOm+vBhvIzjaSFDjZGn7hif3Zwcs8/p00UyTfrquWDELj/ppu51+YOdD+Ok4
X/6s2YYWrw91u0xJ3KLh/CmdyXFZwB9waDu/RY+8XuB56JOsqmP+IpZNR0d0q0RS
eAisQ3Kq7GF6wMCN+ca46pcJkt0dCb9NNq2kZExP4spdP4t2ulfp3t//UsZ+4+/I
u+SQiuZwBTKgsgnBS+Plhl6w7RVVMCwKdd6WDzbBVV2fTnzhNyT9w1k/e5CjpZJP
+9AkUp/XCcEXlrqkbULxA9lXcK4c4Vi56XHtxyr5lUUPMOevnA2+RDygfneaQ9rH
k3Ac8Iktb9fjagiWHkVTa3g0obAeRW5nj8MnmFGiBRg7mQ6ZyztRQUKcpHIWWWdF
a6GGnyFwzIGQQIL617BtmYvw29ZajxC29+IWZyunwpVvlzKUyzItjskkj0jMBCbG
xM8ThV0MRzozmtYl1O7e6FhNEeW0tX4/gPeg6X256X9DeNn1NAIwwdEoYxL78Rl7
QRaWlap6LM6zliifxRg/
=JhMy
-----END PGP SIGNATURE-----

--Sig_/SEvEVDD79CQCr=eKIxzwMgh--

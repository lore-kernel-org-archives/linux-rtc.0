Return-Path: <rtc-linux+bncBDU7VC56WAFBBSOWZS3AKGQEPNMDRYY@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id w197si477703wmw.3.2016.02.28.09.15.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 09:15:53 -0800 (PST)
Date: Sun, 28 Feb 2016 18:14:50 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228181450.3ba14f7f@wiggum>
In-Reply-To: <20160228123618.GD2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
	<20160228003139.GB2398@piout.net>
	<20160228094452.132c1938@wiggum>
	<20160228104110.GC2398@piout.net>
	<20160228125852.1a0b271e@wiggum>
	<20160228123618.GD2398@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1boVza646UxSRdu8oVDkktr"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/1boVza646UxSRdu8oVDkktr
Content-Type: text/plain; charset=UTF-8

On Sun, 28 Feb 2016 13:36:18 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> More simply, don't enable the trickle charger if the
> trickle-resistor-ohms property is missing.
> 
> Leave out the trickle-diode-disable property

D'oh indeed. :)

The rv3029 has a clkout pin that can be configured to various
frequencies. So I added a 'clkout-hz' property for this.

> That part is not HW related, it should not be in the device tree. I'd
> really just enable the temperature compensation else, this has to be
> done in sysfs

Ok.

Just for the record:
I started an initial implementation of this here in the rv3029 branch:
git://git.bues.ch/linux.git
http://bues.ch/gitweb?p=linux.git;a=shortlog;h=refs/heads/rv3029

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

--Sig_/1boVza646UxSRdu8oVDkktr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0ysKAAoJEPUyvh2QjYsO+kUQAItNmqRNXjSFKry1FU7BXLAc
61u0F+h55uIaUW0TtgffNiYZTH0OHb1+pQHKqo3gcZjDnwvbVcF7X6pcKcL0gSUo
5TMpcuakEeLNDI/DCAywaV9Y3n879L/UZ8ugmBj4roh9qdauFencGGr+ZPCIYQ1T
WFVrAKoCjVJBR34e/yg8qWqJxMJL9T62y6g9iTly/53jtUc+E+ip2yF7RZ/KQBtM
X6c0HOo0It+077fUJFbYDxHK/1VXWUaj/MM2gvucxGhKEJ4Jy4/sXGDQw0+aE/66
0d8J7kbR0A0/swYvktPeP8gYFbj/d3pISWpLjmXKUFo+GZFtfERKZWUDZTKw0kvy
fNOMoW9P1V8hoBckaooGU0ObNfcv+nmYYuw/Gb7WfkK33bC98GcW0GbnVfDcON+T
uriTOc1ZbsL2Fon04BDPj2q4uFgMJhh/e7tIrPTjC53ORajRi+gJYhAxzk7O1tkp
xhIvE4H5Bx0CVDpq5wiKeCghFUIyGPqOjUm/y+KEbuJusWqXbJBF9SLqEUZ8AHro
kbxP6zbKqYIpfHQyqMHkVKRmNOEpYH1MDF2yluxWxMtPtMVZfjcb62fXIYWGFQK0
AOhXGdyOgnFzstqdCZz2pmbEXAAG4WfRhFug21MpWi3WuRnsLsJNLRpe3IN3HoUD
Uo6EoToGUSBGS2FMsDIx
=xmnu
-----END PGP SIGNATURE-----

--Sig_/1boVza646UxSRdu8oVDkktr--

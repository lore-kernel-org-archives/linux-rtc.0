Return-Path: <rtc-linux+bncBDU7VC56WAFBBBWCZO3AKGQEFUXJITQ@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id w197si438402wmw.3.2016.02.28.03.59.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 03:59:02 -0800 (PST)
Date: Sun, 28 Feb 2016 12:58:52 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228125852.1a0b271e@wiggum>
In-Reply-To: <20160228104110.GC2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
 <20160228104110.GC2398@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m+jD_MTX8L571=XV2iyktp."; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/m+jD_MTX8L571=XV2iyktp.
Content-Type: text/plain; charset=UTF-8

On Sun, 28 Feb 2016 11:41:10 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> ds1339, ds1390 and bq32k are using trickle-resistor-ohms and
> trickle-diode-disable.


The rv3029 datasheet doesn't say anything about a diode (I think it
still has one though). It merely talks about resistors connected
between vdd and the battery pin.
So I'm not sure whether we should use the 'trickle-diode-disable'
property here. One other possibility would be to use
trickle-resistor-ohms=-1 or such to disable the charger.


> > The rv3029 does the compensation internally. It just needs to be
> > enabled via a bit in its EEPROM. We could probably always set that bit
> > though. I'm not sure whether there is a case where one would not want
> > that.
> >   
> 
> If you want to enable it without changing the values, just enable it
> unconditionally.


I think the internal temperature compensation should be enabled by
default and be disabled via DT property ('temp-compensation-disable'
or such).

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

--Sig_/m+jD_MTX8L571=XV2iyktp.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0uD9AAoJEPUyvh2QjYsOIbAP/0Q8bJdFI09c8epAZn5gLFvt
8HBPJFj5D/Wu17zYWRIW5E4R/QDRlwR5Ja2Csy/u0IwfElGjSm83Bz9rrMyVaeWP
mPGItUsGl2pL3pZt1/5vAkMTh9WF8EVWRM7uC4ajHNMvcBhZlBxGXLXGmqOyuged
kA7U6b/fwTfXW67PJsI6/B0x+u+M7kqN0LCXXucD5i29l4+XNNIeLGBJJHIaBMMY
UV0NioCC2ioGIwaU1j1z5/R3bQ8bGw/SjXuyEgd4wNdVAbbgRwn040U95uUckXLp
B3JRpGRvrw/RaTNu6qjjbm5PBX8MC2vlmJrbRE9V4hYxygsHHvQPESnDVo/6kcQy
KSK4ht1xEjxG+9f6gi0B8QIN4nrnWo4Zd1sShbYarP1OvKKANC55Hzm4b2KVV+Z2
v3GIPLCX99R4ikvisG5G3JQXg5Es9ERbr4gG0GoJfFbkWog7PBOa71wRGxFLm7gL
MEsUDOWkim6W0AACVE12hh2/TbWrnG3kCUaDCjvXQxA0HQ4q0ABUFJzfEkfD5w5d
CPh7vgk4r7AkKpTkfr7AjqugMqVkqQUdt5zmLI8qLnC5LDzq+aDFJlWxkVSGGTMa
I3/sTDkypuH7PRdkvzr0BMesUsF96N7OPMF5PaOrV3ef1luehTQ0u1pkI4IONtIs
CgzvQXbyfvbLF4Ips4pp
=bxl3
-----END PGP SIGNATURE-----

--Sig_/m+jD_MTX8L571=XV2iyktp.--

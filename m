Return-Path: <rtc-linux+bncBDP47C6LHEIOHU7CYQCRUBHQZ5KLK@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from pokefinder.org ([89.238.76.85])
        by gmr-mx.google.com with ESMTP id h198si617030wmg.1.2017.02.06.08.52.50
        for <rtc-linux@googlegroups.com>;
        Mon, 06 Feb 2017 08:52:50 -0800 (PST)
Date: Mon, 6 Feb 2017 17:52:48 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: rtc-linux@googlegroups.com
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Akinobu Mita <akinobu.mita@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: [rtc-linux] [BUG] problem with RTC bindings
Message-ID: <20170206165246.GA4639@tetsubishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Dear RTC hackers,

there are currently two broken bindings descriptions for RTC:

maxim,ds3231.txt
pcf8563.txt

They broke because of a improper RST documentation conversion with commit
8c27ceff3604b2 ("docs: fix locations of several documents that got moved")
and now reference to a non-existing file:

Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst

However, the original reference to i2c/trivial-devices should have never been
made in the first place. IMO, the device is either trivial or not. If
additional properties are needed, then it is not trivial anymore and the device
needs to be moved out of i2c/trivial-devices into its specific entry, with all
entries. Because I am not familiar with the hardware in question, may I kindly
ask the authors of the bindings in question (CCed) to fix this issue?

Thank you very much,

   Wolfram Sang

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYmKneAAoJEBQN5MwUoCm20/IP/Av/W0uohT/MUI43xhFNo/z/
oOHkBNeATVCOqLI4agsZtxphH6LT87gbsqUzcUPzam+ez8iW5EtX0zyR6xqk57+P
2NuG25HEAE46oEq63iWPTVpvUeoIIjOQS31mnTFljdLFBKk8vaLEFqAYM6FpNUJd
K+WjSqtH5Jl+wLNFahXZZKR1qdASSgzS5Q9SQkeXgnNozGf367i+kpCIfgefqkJh
TKt+REiAfKm3DVuGDCOtfepWNTt3Kv3mLR+tsKpGRUKvtoB0JqcPH+UnxsNLB8vV
+Etq9OS0gF+5iW73jTg75aB+UMIvWsXAXDLoV3Vl+dv5GaDTkbZqQ7XuWWg+q7dv
KD2GIUh5od0RxlQeX4pjDS69+/O1Co4m6zxBLYJpJ6N+wYvfWzRvmgVo/mZ2om13
HoemfZQbmSR02JxA3Cxou1vpvF5sXKDGahAMhMJYUI0FMjWI+v0OBUOBNpcAAfgm
+wOR+CxqPMt8GlOhQxFFWKNrQNpK/r/rTgAZRzETLODFWrEJXBQCn6LoU/aBhFrq
box2h1c6gzTRdbdWv7BDZVjvvLp6dQgOdg4/ZRB//d0JRoB4Ul2wz5rYFUaEsNKs
2KMCRWeVGmxtPDhROo1ZY375J291+SmzYa3ipFUeFAT6TPnmPZEBGf0bIJsZbmJ6
7TJqNhDpj+CZqbxRImmP
=GZVA
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

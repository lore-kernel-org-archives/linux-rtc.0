Return-Path: <rtc-linux+bncBDS7HNEFSALRBWVI4W4AKGQEV7FMKUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si4209wmc.3.2016.04.21.15.29.46
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 15:29:46 -0700 (PDT)
Date: Fri, 22 Apr 2016 00:29:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.6
Message-ID: <20160421222945.GA26931@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Linus,

A few fixes for the RTC subsystem. The documentation fix already missed
4.5 so I think it is worth taking it now.

Note that I'm now using a signing subkey so you may need to refresh my
GPG key.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.6-3

for you to fetch changes up to 38a7a73e8ed0fa9e8cd99bb62463afbdcd23429b:

  rtc: ds1307: Use irq when available for wakeup-source device (2016-04-21 23:21:00 +0200)

----------------------------------------------------------------
RTC fixes for 4.6

A documentation fix for s3c and two fixes for the ds1307.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      rtc: s3c: Document in binding that only s3c6410 needs a src clk

Nishanth Menon (1):
      rtc: ds1307: Use irq when available for wakeup-source device

Zhuang Yuyao (1):
      rtc: ds1307: ds3231 temperature s16 overflow

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 7 ++++---
 drivers/rtc/rtc-ds1307.c                          | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXGVRQAAoJENiigzvaE+LC3fQQAI7/YNmNAgWxXk9nET1G4pA2
grA7QykF6l0vA1sd38s1c214ttirgiR8HPLtQw0vOgeNLNhsS18tLKmukzqI2QYq
a8a+IsLL5LEjpsZaqKeXaphH2mKg/27rdtM4RGk+zAS0RevVoQ4UsXJvEykkcvCC
RsD9m8cEA6oYDXWHxtncyzKbtgVtXB1wkKO7ApfXeBPgviXSdEtkd5fDxFnJj/ZK
xKfofGt7NoUi3DLwnw4keI3kNf33yiRyN2u+7fCnE6qnVndnb5pTBKi59wEoLO/C
Hxp4yoY+37WZ/Y9UWhXmEiCeJWDDSpy4FOxqAclzST6YgoHdMmiShmFBZs4UIXHq
MVM9t8zuWMH7IWwCrhgC6G+Hwts+mxrrC4TMFguM8WGOyn+9opahKE2HIfOM9T3p
HZk2T+ue3DMNtSWEofD75rHtKHip7scaUk2LY9IzbYFaqnTkKsDm6HsU9N2I55KI
7+jgucZxWuHV5h8CQCY6EhKubkCR2JOGu81LudY405ZOE9YNHFHLMXgxRkDi/r4l
aTRBLdRZstBdcGcE69zLwsgS7CHyYKZMFPu8a9pJR8YAwnDHx8rV152x1QezyPrl
6kMQ+nJxN3sh2WfVBzoopXJiVoTlWNC6zURdXnKJmDBBfhSz7mLDaMBqE9c0ifvY
ZvbzpPOA7JhefCDB5lAZ
=fvFN
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

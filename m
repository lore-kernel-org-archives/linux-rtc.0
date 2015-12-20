Return-Path: <rtc-linux+bncBDS7HNEFSALRBNGO3KZQKGQEUGQMQWA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si453589wmx.1.2015.12.20.05.03.48
        for <rtc-linux@googlegroups.com>;
        Sun, 20 Dec 2015 05:03:48 -0800 (PST)
Date: Sun, 20 Dec 2015 14:03:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.4 #2
Message-ID: <20151220130337.GA25770@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Linus,

Please pull those late fixes for the RTC subsystem for 4.4.

The following changes since commit 3abb1ada21a4fb5b2920457a2e5c8483abb09a45:

  rtc: ds1307: fix alarm reading at probe time (2015-11-26 18:11:26 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.4-3

for you to fetch changes up to 77535acedc26627f16a1a39c1471f942689fe11e:

  rtc: da9063: fix access ordering error during RTC interrupt at system power on (2015-12-20 13:39:29 +0100)

----------------------------------------------------------------
RTC fixes for 4.4 #2

A fix for a nasty hardware bug in rk808 and a initialization reordering in
da9063 to fix a possible crash.

----------------------------------------------------------------
Julius Werner (1):
      rtc: rk808: Compensate for Rockchip calendar deviation on November 31st

Steve Twiss (1):
      rtc: da9063: fix access ordering error during RTC interrupt at system power on

 drivers/rtc/rtc-da9063.c | 19 +++++++++----------
 drivers/rtc/rtc-rk808.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 14 deletions(-)

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

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJWdqcpAAoJEKbNnwlvZCyzdQ0QAL23ekxMjI5WRMNg1HAHenuw
cU0AE8cVFLes4MaWVf0KDedvg/5068+30UmGZeB1Ogn1Oxm7qCD/mBNs2w3mOX/V
3B6Xq/tHu9Sfjr2Y52YQzQseVG/csfIv0DZkYwJxu1XmOWOlXGR24FQ+nk/QcqR1
cET87F9ByO+OjVNz6DuszloZPk9UnI73+VuFViljq2UD3mABlz63EvWdVsG0NTCV
+nh4/RLFrTKxCCKYCoqbjQXzZlimQF3aOY+uFcoSbZh5dtXmLFhaoZsoCYilykfz
vMXabqTukKz3QkJlL4oEpLCueKd4qkFB7c3BP/RRxnf6clxPSDLxHnZqhZbRQ/GU
FGZresckbrzpUjxtYAPkbZcav/j+dhIxk1QfPhmg+5rnFBDjtu7gxvMp7lYH41Lq
RoPS4cLXlTq7MOMc4DczWGUZ2JNPqzr3FhrI9cJFhQ/7GpAP6rU6Bvtyq7dDBWYc
/1eeI1EM99RxmPZpjBqbUQAs4C9JLt3wC9UjGmqncSCXDIA1+IDZ/E2gbgZUFRj/
xBP9E3I7IvvsmFUFHaqsuuIixDjZ1DVaQ32iY87ojSCYZWa5TEah3GKjQmTaCXBv
RaoilxbWcdlSml+6ipk+MthrAiTt3BxRYQGXFm9XPvMPrt66JUvs6BHUQqRv6qV2
ZUXpF/lo1ImKs2giIXYZ
=jDL+
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

Return-Path: <rtc-linux+bncBDS7HNEFSALRBWUOU2WQKGQEQTLBL4Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si166wib.1.2015.07.17.15.53.13
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Jul 2015 15:53:13 -0700 (PDT)
Date: Sat, 18 Jul 2015 00:53:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.2
Message-ID: <20150717225312.GA30377@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Linus,

A few fixes for the RTC susbsystem for 4.2.

The mt6397 driver was introduce in 4.2 so it is worth fixing before the
final release. I though the compilation warning for armada38x was fixed
by akpm in f98b733e93e00365b4df78fbb33c2cad3080f6bb but he actually
missed some occurrences of the variables. Since I received 4 patches for
that, I think we can include it now.

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-v4.2-2

for you to fetch changes up to d80238bbcad33218c8d34662f144dfb146c2d57b:

  rtc: armada38x: Remove unused variable from armada38x_rtc_set_time() (2015-07-18 00:42:31 +0200)

----------------------------------------------------------------
RTC fixes for 4.2

Drivers:
 - fix mt6397 wakealarm creation
 - remove a compilation warning for armada38x that was forgotten

----------------------------------------------------------------
Fabio Estevam (1):
      rtc: armada38x: Remove unused variable from armada38x_rtc_set_time()

Wei-Ning Huang (1):
      rtc: mt6397: enable wakeup before registering rtc device

 drivers/rtc/rtc-armada38x.c | 2 +-
 drivers/rtc/rtc-mt6397.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVqYdYAAoJEKbNnwlvZCyzEw8P/j7I6z4G3xKvyD2wsFD/fqVj
sl0aXYBowOAjmoOvYvDD9khNSjHNpNCB6disbZwxdLvYHs4i7u0LqQyuYnlxrD6v
EKHoqHYx5x5mXTjuXI+dM9WQBEpYm/ib+WAasBaUol5JdccS4e1sqE3ZzAmYRSuZ
U4Zu7LVdAA3vZGPgsXVMYxmeVECvp85bVu/FUP9pCU3lM0wYPvOtFmD+Qsmofq+o
bEzokMKchnnUrRbMI01V+yHVWhDvSES7yVnCECb5ewLB0WzQB2MTo+H6L3UvACc4
eIJWaSnqyzyEwSKjLSVMCAy9Ns3IW+BlLLWsrXzoIL4ZRPJ46rUYIuUJIApO3HUs
GzRJty52PUwQs+QyP4B/k5Ske6MFGuY9+RNvPBejTTlDETMKG/aneNR6IjLtMf9F
ymreuVcqZ60Xk6Dvqy+0c7P0idy0ZF/QeSpU9W8UCR4vaWntdJ23McgYrxnnP8bE
5gekyMqNCGAUEWLWm1OkkNiXT8Ir9D4J/HcnlHVSItSimUv6pO7UC+Y6UzR2Rgqi
WVXRsAbgkRmd6m0SU7dvMfldJHp7wJPc+eQu7Ou5CHep2RzLpM6eA4jZm8HQ6BUC
iwEYHdGUTy9MulIcjsI5nzxDwhjyU87h9DCpuG4bD1WFxBGSp3B/BYLxxmjR3JHT
YTmpfaCuUQNQ60iYW3O9
=BL/M
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

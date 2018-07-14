Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:57090 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbeGNVRO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 14 Jul 2018 17:17:14 -0400
Date: Sat, 14 Jul 2018 22:56:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 4.18
Message-ID: <20180714205654.GA24863@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are two fixes for 4.18.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.18-2

for you to fetch changes up to fd6792bb022e43faa0c4a45b6f25285e21206f9d:

  rtc: fix alarm read and set offset (2018-07-13 10:37:54 +0200)

----------------------------------------------------------------
RTC fixes for 4.18

 - an important core fix for RTCs using the core offsetting only one driver=
 is
affected.
 - a fix for the error path of mrst

----------------------------------------------------------------
Alexandre Belloni (1):
      rtc: fix alarm read and set offset

Dan Carpenter (1):
      rtc: mrst: fix error code in probe()

 drivers/rtc/interface.c | 8 +++++---
 drivers/rtc/rtc-mrst.c  | 4 +---
 2 files changed, 6 insertions(+), 6 deletions(-)

--=20
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAltKY5QACgkQAyWl4gNJ
NJIGwBAApvXKubAyE+CB0rdW/Urv7CHvRtbzM2h9LmfuKaZCgvJBPn4irDgGH1/o
yCX7+4sGsiNB5Y1jFKbdBU+X44oVsiE4ekdKBgTCC4pA+SQ3x8cjLurOfN64vPJg
Fi/+wjRSqhOh3kR7e/T8HKtUoo0yiGCVq6CxngYe9lGo8b0d4Dj9+YxlVF8TyttI
HwWjskg+fKJOGBjLldSS5BlfI1VZNV1UsqqYutcXseKrksGAlQSC6qpLyrKWuAs6
KQasBxBBsvc80lBnu5Uxc7N7sKYBxgz6zt7gitkgJxdguC7jBSMw9b9J+jWlSDNv
hXukbJlZgCR8Biiv0W0NvYCKJkxeAzuckApFONTYuwEVGbPPPhuiqmb7CzmAe5gF
Vgt4+ydmTB1m/Nrbtp21X4A8crodrV3SdyOIQNXPU790kwap2ZrbpPX7S3XZutJs
2EMCr8yncIeKL+xV7VBzXbOX1EiV9ikAN1IfDgFGoX9jXeF3jfsluPXrs+TUR39E
xfB9r6pWwFSjf40E2U472gRK8d7BRP8JkWeVsEY7adgSrDcy7rSUMDIHYQ52UBrK
p5QKywhcDotmXOxLCVqFI6PXCrty2yiLtol0Nm/8dOWcr+xsIew0hkPnmPKqxMN+
7TtHE24sQYVMRDmCMwoVy6T+DWLkvu6fH1Vb+Gcy/Tu0vaSeINA=
=/9Gk
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
